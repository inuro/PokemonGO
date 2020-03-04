-- calcurate raid boss counter
-- select * from calc_raid('DIALGA,DRAGON_BREATH,IRON_HEAD,5');
-- select * from calc_raid('DIALGA,DRAGON_BREATH,DRACO_METEOR,5');
-- select * from calc_raid('LATIAS,DRAGON_BREATH,OUTRAGE,5'); 
-- select * from calc_raid('RAYQUAZA,DRAGON_TAIL,OUTRAGE,5');
--
drop function if exists calc_raid(condition text);
create or replace function calc_raid(condition text)
returns table(
    uid text
    ,f_uid text
    ,c_uid text
    ,f_dmg integer
    ,c_dmg integer
    ,f_dps numeric
    ,c_dps numeric
    ,total_dps numeric
    ,total_dur numeric
    ,ttk numeric
    ,o_f_dmg integer
    --,o_f_p numeric
    ,o_c_dmg integer
    ,hpt integer
    ,o_c_p numeric
    --,time2kill numeric
    --,dps numeric
    --,number integer
    --killtime numeric,
    --deathtime numeric,
    --dmg_per_1 numeric,
    --dmg_per_6 numeric
    ,o_hp integer, o_f_uid text, o_c_uid text
) as '
DECLARE
    temp text[];
    hp_table integer[] := ARRAY[600,1800,3600,9000,15000];
    cpm_table numeric[] := ARRAY[0.61,0.67,0.73,0.79,0.79];
    raid_hp integer;
    raid_cpm numeric;
    opponent_uid text;
    opponent_fastmove text;
    opponent_chargemove text;
    lv integer;
    opponent record;

BEGIN
    temp := string_to_array(condition,'','');
    opponent_uid := puid(temp[1]);
    opponent_fastmove := get_move_uid(temp[2]);
    opponent_chargemove := get_move_uid(temp[3]);
    lv := temp[4]::integer;
    raid_hp := hp_table[lv];
    raid_cpm := cpm_table[lv];
    if raid_hp is null then
        raid_hp := hp_table[5];
        raid_cpm := cpm_table[5];
    end if;

    select 
        FLOOR((B.at + 15) * SQRT(B.df + 15) * SQRT(raid_hp) / 10) as cp,
        A.*, B.type_1, B.type_2, B.uid, raid_hp as "hp", 
        floor((B.at+15) * raid_cpm)::INTEGER as at,
        floor((B.df+15) * raid_cpm)::INTEGER as df
        into opponent 
        from pokemon_pattern A 
        join pokemon B on A.pokemon_uid=B.uid
        where A.pokemon_uid=opponent_uid and A.f_uid=opponent_fastmove and A.c_uid=opponent_chargemove;

RAISE INFO ''Opponent: % (% / %) CP:% - HPT:% ATK:% DEF:%'', opponent.uid, opponent.f_uid, opponent.c_uid, opponent.cp, opponent.hp, opponent.at, opponent.df;

return query 
With
-- fetch master pokemon data(implemented pokemon only)
Q as (
    select 
        A.index, A.uid, A.type_1, A.type_2, 
        B.cp, B.lv, B.atk, B.def, B.hpt
    from pokemon A, calc_all(A.uid,5500,15,15,15) as B
    where A.available = true 
)
-- join moveset pattens and calc effectiveness, chargetime and opponent moves effectiveness
,R1 as (
    select 
        Q.*, 
        R.f_uid, R.f_type, R.f_ene, R.f_dur, R.f_ini, R.f_stab_pow, R.f_leg,
        R.c_uid, R.c_type,R.c_ene, R.c_dur, R.c_ini, R.c_stab_pow, R.c_leg,
        R.c_ene::NUMERIC / R.f_ene::NUMERIC as chargetime,
        calc_weakness(R.f_type, opponent.type_1, opponent.type_2) as f_eff,
        calc_weakness(R.c_type, opponent.type_1, opponent.type_2) as c_eff,
        calc_weakness(opponent.f_type, Q.type_1, Q.type_2) as opponent_f_eff,
        calc_weakness(opponent.c_type, Q.type_1, Q.type_2) as opponent_c_eff
    from Q
    join pokemon_pattern R on R.pokemon_uid=Q.uid
)
-- calc damages
,R2 as (
    select 
        R1.*, 
        (FLOOR(0.5 * ROUND(R1.atk::NUMERIC / opponent.df, 2) * R1.f_stab_pow * R1.f_eff) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(R1.atk::NUMERIC / opponent.df, 2) * R1.c_stab_pow * R1.c_eff) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent.at::NUMERIC / R1.def, 2) * opponent.f_stab_pow * opponent_f_eff) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent.at::NUMERIC / R1.def, 2) * opponent.c_stab_pow * opponent_c_eff) + 1)::numeric as opponent_c_dmg
    from R1
)
-- calc dps and killtime
,R3 as (
    select
        R2.*,
        R2.f_dmg / R2.f_dur as f_dps,
        R2.c_dmg / R2.c_dur as c_dps
    --    calc_killtime(
    --        opponent.hp, 
    --        R2.f_dmg, 
    --        R2.f_uid, 
    --        R2.c_dmg, 
    --        R2.c_uid
    --    ) as killtime,

    --    calc_killtime(
    --        R2.hpt, 
    --        R2.opponent_f_dmg,
    --        opponent_fastmove,
    --        R2.opponent_c_dmg,
    --        opponent_chargemove
    --    )as deathtime
    from R2
)
-- calc total dps
,S as (
     select
        R3.*,
        (case 
            when R3.f_ene is null then 0.00000001 
            else (R3.f_dps * R3.chargetime + R3.c_dps * R3.c_dur) / (R3.chargetime + R3.c_dur)
        end) as dps
    from R3
)
-- simulate raid
--,T as (
--    select
--        *
--    from R3, simulate_raid(R3.hpt,R3.f_uid,R3.f_dmg::numeric,R3.c_uid,R3.c_dmg::numeric,opponent.hp,opponent.f_uid,R3.opponent_f_dmg::numeric,opponent.c_uid,R3.opponent_c_dmg::numeric)
--)
select 
    S.uid
    ,S.f_uid
    ,S.c_uid
    ,S.f_dmg::integer
    ,S.c_dmg::integer
    ,round(S.f_dps,1) as f_dps
    ,round(S.c_dps,1) as c_dps
    ,round(S.dps,1) as total_dps
    ,Round(Ceil(S.c_ene::numeric / S.f_ene) * S.f_dur + S.c_dur, 1)
    ,Round(opponent.hp / S.dps, 1)
    ,S.opponent_f_dmg::integer
    --,Round(100 * S.opponent_f_dmg / S.hpt, 1)
    ,S.opponent_c_dmg::integer
    ,S.hpt
    ,Round(100 * S.opponent_c_dmg / S.hpt, 1)
    --,S.time2kill
    --,S.dps
    --,S.number
    ,opponent.hp,opponent.f_uid,opponent.c_uid
from S;

return;
END
' LANGUAGE 'plpgsql';



With A as(
select * from calc_raid('DIALGA,DRAGON_BREATH,DRACO_METEOR,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
select A.* 
from A join B on B.uid=A.uid and B.total_dps=A.total_dps
order by A.total_dps desc limit 40;


With A as(
select * from calc_raid('DIALGA,DRAGON_BREATH,DRACO_METEOR,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select A.* 
    from A join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.uid, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p, D.*
from C, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg) D
order by D.dps desc;




With A as(
select * from calc_raid('DIALGA,DRAGON_BREATH,DRACO_METEOR,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select A.* 
    from A 
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.uid, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by D.dps desc;







With A as(
select * from calc_raid('DIALGA,DRAGON_BREATH,DRACO_METEOR,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select A.* 
    from A join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.o_c_p limit 40
)
select
C.uid, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p, D.*
from C, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg) D;



With A as(
select * from calc_raid('RAYQUAZA,DRAGON_TAIL,OUTRAGE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select A.* 
    from A 
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.uid, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p, D.*
from C, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg) D
order by D.dps desc;

With A as(
select * from calc_raid('RAYQUAZA,DRAGON_TAIL,OUTRAGE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select A.* 
    from A 
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    where A.uid='MAMOSWINE'
    order by A.total_dps desc limit 40
)
select
C.uid, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p, D.*
from C, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg) D
order by D.dps desc;






With A as(
select * from calc_raid('RAYQUAZA,DRAGON_TAIL,OUTRAGE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select A.* 
    from A 
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.uid, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by D.dps desc;







-- select * from calc_killtime_raid(134,7,'DRAGON_BREATH',165,'DRACOR_METEOR');
-- select * from calc_killtime_raid(134,7,'DRAGON_BREATH',66,'IRON_HEAD');
drop function if exists calc_killtime_raid(hpt numeric, f_dmg numeric, f_uid text, c_dmg numeric, c_uid text);
create or replace function calc_killtime_raid(hpt numeric, f_dmg numeric, f_uid text, c_dmg numeric, c_uid text)
returns numeric as '
DECLARE
    fast record;
    charge record;
    time numeric := 0;
    gained integer := 0;
    turn int:=1;
BEGIN
    select * into fast from _fastmove F where F.uid=f_uid; 
    select * into charge from _chargemove C where C.uid=c_uid; 
    LOOP
        -- FAST move
        hpt := hpt - f_dmg;
        time := time + fast.damage_window_start;
        IF hpt <= 0 THEN
RAISE INFO ''#% fastmove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            EXIT;
        END IF;
        time := time + (fast.duration - fast.damage_window_start);
        gained := gained + fast.energy;
        IF gained > 100 THEN 
            gained := 100;
        END IF;
RAISE INFO ''HPT:% / ENE:%'',hpt, gained;

        -- CHARGE move
        IF gained >= charge.energy THEN
RAISE INFO ''#% fastmove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            gained := gained - charge.energy;
            hpt := hpt - c_dmg;
            time := time + charge.damage_window_start;
            IF hpt <= 0 THEN
RAISE INFO ''#% chargemove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
                EXIT;
            END IF;
            time := time + (charge.duration - charge.damage_window_start);
RAISE INFO ''#% chargemove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            turn := turn + 1;
        END IF;
    END LOOP;
return ROUND(time / 1000, 1);
END
' LANGUAGE 'plpgsql';




With A as(
select * from calc_raid('TERRAKION,ZEN_HEADBUTT,CLOSE_COMBAT,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select A.* 
    from A 
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.uid, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by D.dps desc;


With A as(
select * from calc_raid('TERRAKION,SMACK_DOWN,ROCK_SLIDE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select A.* 
    from A 
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.uid, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by D.dps desc;


With A as(
select * from calc_raid('TERRAKION,ZEN_HEADBUTT,EARTHQUAKE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by F.number;


With A as(
select * from calc_raid('TERRAKION,SMACK_DOWN,EARTHQUAKE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by F.number;



With A as(
select * from calc_raid('TERRAKION,ZEN_HEADBUTT,CLOSE_COMBAT,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by F.number limit 20;


With A as(
select * from calc_raid('TERRAKION,SMACK_DOWN,CLOSE_COMBAT,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by F.number limit 20;



With A as(
select * from calc_raid('TERRAKION,ZEN_HEADBUTT,ROCK_SLIDE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by F.number limit 20;


With A as(
select * from calc_raid('TERRAKION,SMACK_DOWN,ROCK_SLIDE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by F.number limit 20;



With A as(
select * from calc_raid('TERRAKION,ZEN_HEADBUTT,EARTHQUAKE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by F.number limit 20;


With A as(
select * from calc_raid('HEATRUn,SMACK_DOWN,EARTHQUAKE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by F.number limit 20;




With A as(
select * from calc_raid('HEATRAN,FIRE_SPIN,STONE_EDGE,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by E.number 
limit 50;

With A as(
select * from calc_raid('HEATRAN,FIRE_SPIN,IRON_HEAD,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by E.number 
limit 50;

With A as(
select * from calc_raid('HEATRAN,FIRE_SPIN,FLAMETHROWER,5')
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by E.number 
limit 50;



-- DPS（トータル）の偏差値70以上から、2人がかりで300秒以内で倒せるやつを出す
With A as(
select * from calc_raid('HEATRAN,FIRE_SPIN,FLAMETHROWER,5')
--select * from calc_raid('HEATRAN,FIRE_SPIN,IRON_HEAD,5')
--select * from calc_raid('HEATRAN,FIRE_SPIN,STONE_EDGE,5')
)
, B as(
    select stddev(total_dps) as dev_dps, avg(total_dps) as avg_dps from A
)
, B2 as(
    select A.*,
        (total_dps - avg_dps) / dev_dps*10+50 as T_dps
    from A, B
)
, C as(
    select G.jp, B2.* 
    from B2
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    where T_dps > 70
    order by B2.total_dps desc
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
--,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
--,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
,C.T_dps
from C
--, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
--, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
where E.time2kill<300
order by E.number 
limit 50;



With A as(
select * from calc_raid('HEATRAN,FIRE_SPIN,FLAMETHROWER,5')
)
, B as(
    select stddev(total_dps) as dev_dps, avg(total_dps) as avg_dps from A
)
, B2 as(
    select A.*,
        (total_dps - avg_dps) / dev_dps*10+50 as T_dps
    from A, B
)
, C as(
    select G.jp, B2.* 
    from B2
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    where T_dps > 50
    order by B2.total_dps desc
)
select count(*) from C;









With Z as(
    select * from pokemon_pattern_combat where pokemon_uid='HEATRAN' 
    and f_uid='FIRE_SPIN' and c_uid in ('FLAMETHROWER','IRON_HEAD') 
), A as(
select * from calc_raid(concat_ws(',',Z.pokemon_uid,Z.f_uid,Z.c_uid,'5')), Z
)
, B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by E.number 
--order by D.time2kill
limit 50;




With Z as(
    select * from pokemon_pattern_combat where pokemon_uid='HEATRAN' 
    --and f_uid='FIRE_SPIN' and c_uid in ('FLAMETHROWER','IRON_HEAD') 
), A as(
    select A.* from Z, calc_raid(concat_ws(',',Z.pokemon_uid,Z.f_uid,Z.c_uid,'5')) as A 
), B as(
    select uid, max(total_dps) as total_dps from A group by uid
)
, C as(
    select G.jp, A.* 
    from A 
    join localize_pokemon G using (uid)
    --join B on B.uid=A.uid and B.total_dps=A.total_dps
    --order by A.total_dps desc limit 40
)
select
C.jp, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
, C.o_f_uid, C.o_c_uid
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by F.number 
--order by D.time2kill
limit 100;




With Z as(
    select * from pokemon_pattern_combat where pokemon_uid='HEATRAN' 
    --and f_uid='FIRE_SPIN' and c_uid in ('FLAMETHROWER','IRON_HEAD') 
), C as(
    select A.* from Z, calc_raid(concat_ws(',',Z.pokemon_uid,Z.f_uid,Z.c_uid,'5')) as A 
)
select
C.uid, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
,D.time2kill as ttk, D.dps as dps, D.number as num
,E.time2kill as ttkx2, E.dps as dpsx2, E.number as numx2
,F.time2kill as ttkx3, F.dps as dpsx3, F.number as numx3
, C.o_f_uid, C.o_c_uid
from C
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) E
, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 3) F
order by F.number 
--order by D.time2kill
limit 100;



With Z as(
    select * from pokemon_pattern_combat where pokemon_uid='HEATRAN' 
    --and f_uid='FIRE_SPIN' and c_uid in ('FLAMETHROWER','IRON_HEAD') 
), C as(
    select A.* from Z, calc_raid(concat_ws(',',Z.pokemon_uid,Z.f_uid,Z.c_uid,'5')) as A 
)
select * from C , simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 1) D
order by C.ttk;


With Z as(
    select * from pokemon_pattern_combat where pokemon_uid='HEATRAN' 
    and f_uid='FIRE_SPIN' 
    --and c_uid in ('FLAMETHROWER','IRON_HEAD') 
), A as(
    select A.* from Z, calc_raid(concat_ws(',',Z.pokemon_uid,Z.f_uid,Z.c_uid,'5')) as A 
), C as(
    select * from A order by A.ttk limit 1000
), X as(
    select
        C.uid, C.f_uid, C.c_uid, C.f_dmg, C.c_dmg, C.f_dps, C.c_dps, C.total_dur as "cycle_time", C.o_f_dmg, C.o_c_dmg, C.hpt, C.o_c_p
        ,D.time2kill as ttk, D.dps as dps, D.number as num
        ,C.o_f_uid, C.o_c_uid
    from C, simulate_raid(C.hpt, C.f_uid, C.f_dmg, C.c_uid, C.c_dmg, C.o_hp, C.o_f_uid, C.o_f_dmg, C.o_c_uid, C.o_c_dmg, 2) as D
)
select * from X
where ttk<=300
order by num;