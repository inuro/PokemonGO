

coalesce(s.form_id,'')
coalesce(f.form_id,'')



-- pokemon

select
    to_number(B.pokemon_id,'999') as index,
    B.uid, 
    C1.uid as type_1,
    C2.uid as type_2,
    B.hp, B.at, B.df
from _form A 
join _stats B on B.pokemon_id=A.pokemon_id and coalesce(B.form_id,'') = coalesce(A.form_id,'') 
join _type C1 on C1.index=B.type_1
left join _type C2 on C2.index=B.type_2
order by index;


--pokemon_fastmove_ref
select
    to_number(A.pokemon_id, '999') as pokemon_id, 
    B.uid,
    C.uid, 
    C.type, 
    C.power, C.duration
from _form A 
join _mon_fast B on B.pokemon_id=A.pokemon_id and coalesce(B.form_id,'') = coalesce(A.form_id,'')
join _fastmove C on C.move_id=B.move_id
order by pokemon_id;

--pokemon_chargemove_ref
select
    to_number(A.pokemon_id, '999') as pokemon_id, 
    B.uid,
    C.uid, 
    C.type, 
    C.power, C.duration
from _form A 
join _mon_charge B on B.pokemon_id=A.pokemon_id and coalesce(B.form_id,'') = coalesce(A.form_id,'')
join _chargemove C on C.move_id=B.move_id
order by pokemon_id,B.uid;






select
    to_number(B.pokemon_id,'999') as index,
    B.uid, 
    D.jp,
    D.en,
    C1.uid as type_1,
    C2.uid as type_2,
    B.hp, B.at, B.df
from _form A 
join _stats B on B.pokemon_id=A.pokemon_id and coalesce(B.form_id,'') = coalesce(A.form_id,'') 
join _type C1 on C1.index=B.type_1
left join _type C2 on C2.index=B.type_2
join localize_pokemon D on D.uid=B.uid
order by index


-- all matchings
select
    A.index, A.uid, A.type_1, A.type_2,A.hp,A.at,A.df,
    B.move_uid, B.type, B.power, B.duration, B.energy, B.legacy,
    C.move_uid, C.type, C.power, C.duration, C.energy, C.legacy
from pokemon A 
join pokemon_fastmove B on B.pokemon_uid=A.uid
join pokemon_chargemove C on C.pokemon_uid=A.uid
;


-- dps test
select
    A.index, A.pokemon_uid,
    B.jp as pokemon_jp,
    C.jp as move_jp,
    A.type as move_type,
    A.power as pow,
    A.duration as dur,
    A.energy as ene,
    A.legacy as leg,
    (case when A.type=D.type_1 or A.type=D.type_2 then true else false end) as STAB,
    (case when A.type=D.type_1 or A.type=D.type_2 then 1.2 else 1.0 end) * A.power * D.at / A.duration * 1000 as dps
from pokemon_fastmove A
join localize_pokemon B on B.uid=A.pokemon_uid
join localize_fastmove C on C.uid=A.move_uid
join pokemon D on D.uid=A.pokemon_uid
;


-- all matchings
select
    A.index, A.uid,
    B.move_uid as f_id, B.type as f_type , B.power as f_pow, B.duration as f_dur, B.energy as f_ene, B.legacy as f_leg,
    (case when B.type=A.type_1 or B.type=A.type_2 then true else false end) as f_STAB,
    (case when B.type=A.type_1 or B.type=A.type_2 then 1.2 else 1.0 end) * (case when B.power is null then 0 else B.power end) as f_STAB_pow,
    C.move_uid as c_id, C.type as c_type, C.power as c_pow, C.duration as c_dur, C.energy as c_ene, C.legacy as c_leg,
    (case when C.type=A.type_1 or C.type=A.type_2 then true else false end) as c_STAB,
    (case when C.type=A.type_1 or C.type=A.type_2 then 1.2 else 1.0 end) * (case when C.power is null then 0 else C.power end) as c_STAB_pow
from pokemon A 
join pokemon_fastmove B on B.pokemon_uid=A.uid
join pokemon_chargemove C on C.pokemon_uid=A.uid
;

With q as(
    select A.index, B.jp, A.uid, A.type_1, A.type_2, A.hp, A.at, A.df from pokemon A
    join localize_pokemon B on B.uid=A.uid
),
q2 as (
    select q.*, q2.*, 'hoge' as hoge from q,calc_all(q.uid,2500,15,15,15) as q2
)
select * from q2;
limit 10;

With q as(
    select A.index, B.jp, A.uid, A.type_1, A.type_2, A.hp, A.at, A.df from pokemon A
    join localize_pokemon B on B.uid=A.uid
),
q2 as (
    select * from q,calc_all(q.uid,2500,15,15,15)
)
select * from q, q2;
limit 10;



With q1 as(
    select A.index, A.uid, A.type_1, A.type_2 from pokemon A
),
q2 as (
    select q1.*, temp.*, 'hoge' as hoge from q1, calc_all(q1.uid,2500,15,15,15) as temp
)
select * from q2
limit 10;




With Q as (
    select 
        A.index, A.uid, A.type_1, A.type_2, 
        B.cp, B.lv, B.atk, B.def, B.hpt, B.lifelong as life
    from pokemon A, calc_all(A.uid,1500,15,15,15) as B
),
R as (
    select 
        Q.*, 
        R.f_uid, R.f_type, R.f_ene, R.f_dur, R.f_stab_pow,
        Q.atk * R.f_stab_pow / R.f_dur as f_dps,
        R.c_uid, R.c_type,R.c_ene, R.c_dur, R.c_stab_pow,
        Q.atk * R.c_stab_pow / R.c_dur as c_dps,
        R.c_ene::NUMERIC / R.f_ene::NUMERIC as chargetime
    from Q
    join pokemon_pattern R on R.pokemon_uid=Q.uid
)
select
    R.index, R.uid, LP.jp, R.type_1, R.type_2, R.cp, R.lv, R.atk, R.def, R.hpt, 
    LF.jp, R.f_type, 
--    R.f_ene, R.f_stab_pow, to_char(R.f_dur, '0.9') as f_dur, 
    R.f_dps::INTEGER, 
    LC.jp, R.c_type, 
--    R.c_ene, R.c_stab_pow, to_char(R.c_dur, '0.9') as c_dur, 
    R.c_dps::INTEGER, 
    (case when R.f_ene is null then 0 else
        (R.f_dps * R.chargetime + R.c_dps * R.c_dur) / 
        (R.chargetime + R.c_dur)
    end)::INTEGER as total_dps,
    to_char(R.life, '999.99') as life
from R
join localize_pokemon LP on LP.uid=R.uid
join localize_fastmove LF on LF.uid=R.f_uid
join localize_chargemove LC on LC.uid=R.c_uid
where R.uid = 'LAPRAS';

fdps 1840
fene 8
fdur 0.9
cdps 4516.3636363636363636
cene 50
cdur 3.3

1840 * (50 / 8) = 11500
4516 * 3.3 = 14904
(50 / 8) + 3.3 = 9.55
(11500 + 14904) / 9.55 = 2764.691099476439791



drop view if exists dps_cp1500_IV15;
create view dps_cp1500_IV15 as(
With Q as (
    select 
        A.index, A.uid, A.type_1, A.type_2, 
        B.cp, B.lv, B.atk, B.def, B.hpt, B.lifelong as life
    from pokemon A, calc_all(A.uid,1500,15,15,15) as B
),
R as (
    select 
        Q.*, 
        R.f_uid, R.f_type, R.f_ene, R.f_dur, R.f_stab_pow,
        Q.atk * R.f_stab_pow / R.f_dur as f_dps,
        R.c_uid, R.c_type,R.c_ene, R.c_dur, R.c_stab_pow,
        Q.atk * R.c_stab_pow / R.c_dur as c_dps,
        R.c_ene::NUMERIC / R.f_ene::NUMERIC as chargetime
    from Q
    join pokemon_pattern R on R.pokemon_uid=Q.uid
)
select
    R.index, R.uid, R.type_1, R.type_2, R.cp, R.lv, R.atk, R.def, R.hpt, 
    R.f_uid, R.f_type, R.f_ene, R.f_stab_pow, to_char(R.f_dur, '0.9') as f_dur, R.f_dps::INTEGER, 
    R.c_uid, R.c_type, R.c_ene, R.c_stab_pow, to_char(R.c_dur, '0.9') as c_dur, R.c_dps::INTEGER, 
    (case when R.f_ene is null then 0 else
        (R.f_dps * R.chargetime + R.c_dps * R.c_dur) / 
        (R.chargetime + R.c_dur)
    end)::INTEGER as total_dps,
    to_char(R.life, '999.99') as life
from R
);







CREATE TABLE items (
 id SMALLINT
 , name VARCHAR(16)
 , item_id SMALLINT
 , item_name VARCHAR(16)
 , PRIMARY KEY(id, item_id)
);
 
INSERT INTO items VALUES
  (1, '文房具', 1, 'シャーペン')
  , (1, '文房具', 2, '消しゴム')
  , (1, '文房具', 3, '定規')
  , (2, 'かばん', 1, 'リュックサック')
  , (2, 'かばん', 2, 'ショルダーバッグ');
 

CREATE TABLE hoge (
 id int
 , label text
);
 
INSERT INTO hoge VALUES
  (1, 'hage')
  , (2, 'hige')
  , (3, 'hoge');


drop function if exists hige(text);
create function hige(name text)
returns text as '
BEGIN
    return concat(name, ''_hige'');
END
' LANGUAGE 'plpgsql';



With Q as (
    select 
        A.index, A.uid, A.type_1, A.type_2, 
        B.cp, B.lv, B.atk, B.def, B.hpt
    from pokemon A, calc_all(A.uid,2500,15,15,15) as B
),
R as (
    select 
        Q.*, 
        R.f_uid, R.f_type, R.f_ene, R.f_dur,
        case when R.f_stab_pow is null then 0 else R.f_stab_pow / (R.f_dur / 1000) end,
    --    case when R.f_stab_pow is null then 0 else Q.atk * R.f_stab_pow / (R.f_dur / 1000) end as f_dps,
        R.c_uid, R.c_type,R.c_ene, R.c_dur,
        Q.atk * R.c_stab_pow / (R.c_dur / 1000) as c_dps
    from Q
    join pokemon_pattern R on R.pokemon_uid=Q.uid
)
select * from R where R.uid='AZURILL';


select 
    A.index, A.uid, A.type_1, A.type_2, 
    B.cp, B.lv, B.atk, B.def, B.hpt
from pokemon A, calc_all(A.uid,2500,15,15,15) as B
;




drop function if exists test(target_uid TEXT);
create or replace function test(target_uid TEXT)
returns table(cp integer, lv numeric, atk integer, def integer, hpt integer, lifelong numeric) as'
DECLARE
    pokemon record;
BEGIN
    select * into pokemon from $TABLE_POKEMON where uid=target_uid;
    return query
        WITH q as(
        select
        calc_cp(cap_cp,pokemon.hp,pokemon.at,pokemon.df,HPIV,ATIV,DFIV)::integer as cp, 
        calc_lv(cap_cp,pokemon.hp,pokemon.at,pokemon.df,HPIV,ATIV,DFIV) as lv,
        calc_atk(cap_cp,pokemon.hp,pokemon.at,pokemon.df,HPIV,ATIV,DFIV)::integer as atk,
        calc_def(cap_cp,pokemon.hp,pokemon.at,pokemon.df,HPIV,ATIV,DFIV)::integer as def,
        calc_hp(cap_cp,pokemon.hp,pokemon.at,pokemon.df,HPIV,ATIV,DFIV)::integer as hpt
        )
        select *, q.hpt::NUMERIC / ((10 * 127 / q.def::NUMERIC) + 1 ) as lifelong from q
        ;
    return;
END
' LANGUAGE 'plpgsql';


drop function if exists test(target_uid TEXT);
create or replace function test(target_uid TEXT)
returns table(
    index numeric, uid text, jp text, type_1 text, type_2 text, cp integer, lv numeric, atk integer, def integer, hpt integer, fastmove text, f_type text, f_leg boolean, f_dps integer, chargemove text, c_type text, c_leg boolean, c_dps integer, total_dps integer, life text
--, f_eff numeric, c_eff numeric
) as '
DECLARE
    target record;
BEGIN
select P.type_1, P.type_2 into target from pokemon P where P.uid=target_uid;
-- raise INFO ''type1 = % type2 = %'', target.type_1, target.type_2;
return query 
With Q as (
    select 
        A.index, A.uid, A.type_1, A.type_2, 
        B.cp, B.lv, B.atk, B.def, B.hpt, B.lifelong as life
    from pokemon A, calc_all(A.uid,1500,15,15,15) as B
),
R1 as (
    select 
        Q.*, 
        R.f_uid, R.f_type, R.f_ene, R.f_dur, R.f_stab_pow, R.f_leg,
        R.c_uid, R.c_type,R.c_ene, R.c_dur, R.c_stab_pow, R.c_leg,
        R.c_ene::NUMERIC / R.f_ene::NUMERIC as chargetime,
        F1.mlp * (case when F2.mlp is null then 1.0 else F2.mlp end) as f_eff,
        C1.mlp * (case when C2.mlp is null then 1.0 else C2.mlp end) as c_eff
    from Q
    join pokemon_pattern R on R.pokemon_uid=Q.uid
    join effectiveness F1 on F1.attacker = R.f_type and F1.defender = target.type_1
    left join effectiveness F2 on (case when target.type_2 is null then false else F2.attacker = R.f_type and F2.defender = target.type_2 end)
    join effectiveness C1 on C1.attacker = R.c_type and C1.defender = target.type_1
    left join effectiveness C2 on (case when target.type_2 is null then false else C2.attacker = R.c_type and C2.defender = target.type_2 end)
),
R2 as (
    select 
        R1.*, 
        R1.atk * R1.f_stab_pow * R1.f_eff / R1.f_dur as f_dps,
        R1.atk * R1.c_stab_pow * R1.c_eff / R1.c_dur as c_dps
    from R1
),
S as (select
    R2.index, R2.uid, LP.jp, R2.type_1, R2.type_2, R2.cp, R2.lv, R2.atk, R2.def, R2.hpt, 
    LF.jp as fastmove, R2.f_type, R2.f_leg,
--    R2.f_ene, R2.f_stab_pow, to_chaR2.R2.f_duR2. ''0.9'') as f_dur, 
    R2.f_dps::INTEGER, 
    LC.jp as chargemove, R2.c_type, R2.c_leg,
--    R2.c_ene, R2.c_stab_pow, to_char(R2.c_dur, ''0.9'') as c_dur, 
    R2.c_dps::INTEGER, 
    (case when R2.f_ene is null then 0 else
        (R2.f_dps * R2.chargetime + R2.c_dps * R2.c_dur) / 
        (R2.chargetime + R2.c_dur)
    end)::INTEGER as total_dps,
    to_char(R2.life, ''999.99'') as life
--    , R2.f_eff, R2.c_eff
from R2
join localize_pokemon LP on LP.uid=R2.uid
join localize_fastmove LF on LF.uid=R2.f_uid
join localize_chargemove LC on LC.uid=R2.c_uid
)
select *
from S;
return;
END
' LANGUAGE 'plpgsql';



select * from test('LAPRAS') limit 1;




drop function if exists test(target_uid TEXT ,opponent_move_type TEXT);
create or replace function test(target_uid TEXT ,opponent_move_type TEXT)
returns table(pokemon text, move text, mlp numeric) as'
DECLARE
    pokemon record;
    eff1 record;
    eff2 record;
BEGIN
    select * into pokemon from pokemon where uid=target_uid;
    select * into eff1 from effectiveness where (case
        when opponent_move_type is null then false 
        else attacker=opponent_move_type and defender=pokemon.type_1
    end);
    select * into eff2 from effectiveness where (case
        when opponent_move_type is null or pokemon.type_2 is null then false 
        else attacker=opponent_move_type and defender=pokemon.type_2
    end);
    raise INFO ''eff1: %, %, %'', eff1.attacker, eff1.defender, eff1.mlp;
    raise INFO ''eff2: %, %, %'', eff2.attacker, eff2.defender, eff2.mlp;
    return query select pokemon.uid, opponent_move_type, (case when eff1.mlp is null then 1.0 else eff1.mlp end) * (case when eff2.mlp is null then 1.0 else eff2.mlp end);
    return;
END
' LANGUAGE 'plpgsql';

select * from effectiveness where (case when '' is null then false else attacker='' end);



select *, 
    row_number() OVER (ORDER BY total_dps desc) AS dps_rank,
    ROUND((total_dps - AVRG) / STDRD * 10 + 50, 1) as dps_T,
    row_number() OVER (ORDER BY firepower desc) AS fp_rank,
    ROUND((firepower - AVRG) / STDRD * 10 + 50, 1) as fp_T
from calc_counter('',1500,15,15,15,'') 
where c_type='FIRE' 
order by total_dps desc 
;


select *, 
    row_number() OVER (ORDER BY dps desc) AS dps_rank,
    row_number() OVER (ORDER BY firepower desc) AS fp_rank
from calc_counter('BLISSEY',1500,15,15,15,'FAIRY') 
--where c_type='FIRE' 
order by firepower desc 
;

select *
from calc_counter('BLISSEY',1500,15,15,15,'FAIRY') 
order by firepower desc 
;



select *
, dps_t * life_t as p
from calc_counter('',1500,15,15,15,'') 
where
(type_1='FIRE' or type_2='FIRE')
and (f_type='FIRE' or c_type='FIRE')
--and dps_t > 50 and life_t > 30
order by firepower desc;

select *
, dps_t * life_t as p
from calc_counter('',1500,15,15,15,'') 
where
(type_1='ROCK' or type_2='ROCK')
and f_type='ROCK' and c_type='ROCK'
--and dps_t > 50 and life_t > 30
order by firepower desc;


select *
, dps_t * life_t as p
from calc_counter('RAYQUAZA',2500,15,15,15,'DRAGON') 
order by firepower desc;

select *
, dps_t * life_t as p
from calc_counter('RAYQUAZA',2500,15,15,15,'FLYING') 
order by firepower desc;



drop function if exists test();
create or replace function test()
returns integer as '
DECLARE
    target record;
BEGIN
    select * into target from items A where A.item_name=''シャーペン'';
    select B.label into target.label from hoge B where B.id=''2'';
    raise info ''%'', target;
    return 1;
END
' LANGUAGE 'plpgsql';


drop function if exists calc_effectiveness(attacker TEXT, defender TEXT);

create or replace function calc_effectiveness(attacker TEXT, type_1 TEXT, type_2 TEXT)
returns NUMERIC as'
DECLARE
    res record;
    mlp NUMERIC := 1.0;
BEGIN
    select mlp into res from $TABLE_EFFECTIVENESS where attacker = move_type and defender = type_1;
    mlp_1 := res.mlp;
--    raise INFO ''mlp_1 = %'', mlp_1;
    IF type_2 is not null THEN
        select mlp into res from $TABLE_EFFECTIVENESS where attacker = move_type and defender = type_2;
        mlp_2 := res.mlp;
--        raise INFO ''mlp_2 = %'', mlp_2;
    END IF;
    RETURN round(mlp_1 * mlp_2 * 1000) / 1000;
END
' LANGUAGE 'plpgsql';

select * from pokemon P, calc_all('BLISSEY',1500,15,15,15,'''') Q where P.uid='BLISSEY';


drop function if exists test(opponent_uid TEXT);
create or replace function test(opponent_uid TEXT)
returns NUMERIC as '
DECLARE
    opponent record;
    opponent_type_1 TEXT := null;
    opponent_type_2 TEXT := null;
    opponent_def NUMERIC := 1.0;
    opponent_hpt NUMERIC := 1.0;
BEGIN
RAISE INFO ''opponent:%'',opponent_uid;
    select * into opponent from pokemon P, calc_all(opponent_uid,1500,15,15,15,'''') Q where P.uid=opponent_uid;
RAISE INFO ''fetched:%'',opponent;
   IF opponent.uid is not null THEN
        opponent_type_1 = opponent.type_1;
        opponent_type_2 = opponent.type_2;
        opponent_def = opponent.def;
        opponent_hpt = opponent.hpt;
RAISE INFO ''opponent_def: %'', opponent_def;
    ELSE
RAISE INFO ''opponent % not found'', opponent_uid;
    END IF;
    return opponent_def;
END
' LANGUAGE 'plpgsql';


drop function if exists test(
    hpt numeric, f_dmg numeric, f_setup numeric, f_dur numeric, f_ene integer,
    c_dmg numeric, c_setup numeric, c_dur numeric, c_ene integer
);
create or replace function test(
    hpt numeric, f_dmg numeric, f_setup numeric, f_dur numeric, f_ene integer,
    c_dmg numeric, c_setup numeric, c_dur numeric, c_ene integer
)
returns numeric as '
DECLARE
    time numeric := 0;
    gained integer := 0;
BEGIN
    LOOP
        -- FAST move
        hpt := hpt - f_dmg;
        time := time + f_setup;
        EXIT WHEN hpt <= 0;
        time := time + (f_dur - f_setup);
        gained := gained + f_ene;

        -- CHARGE move
        IF gained >= c_ene THEN
            hpt := hpt - c_dmg;
            time := time + c_setup;
            EXIT WHEN hpt <= 0;
            time := time + (c_dur - c_setup);
            gained := gained - c_ene;
        END IF;
    END LOOP;
return time;
END
' LANGUAGE 'plpgsql';


-- 243,"COUNTER",2,12,900,8,700,900
-- 246,"DYNAMIC_PUNCH",2,90,2700,50,1200,2700
select * from test(200, 12, 0.7, 0.9, 8, 90, 1.2, 2.7, 50);

-- 207,"LOW_KICK",2,6,600,6,300,600
-- 247,"FOCUS_BLAST",2,140,3500,100,3000,3500
select * from test(200, 6, 0.3, 0.6, 6, 140, 3.0, 3.5, 100);



drop function if exists test(
    hpt numeric, f_dmg numeric, f_uid text, c_dmg numeric, c_uid text
);
create or replace function test(
    hpt numeric, f_dmg numeric, f_uid text, c_dmg numeric, c_uid text
)
returns numeric as '
DECLARE
    fast record;
    charge record;
    time numeric := 0;
    gained integer := 0;
BEGIN
    select * into fast from _fastmove F where F.uid=f_uid; 
    select * into charge from _chargemove C where C.uid=c_uid; 
    LOOP
        -- FAST move
        hpt := hpt - f_dmg;
        time := time + fast.damage_window_start;
        EXIT WHEN hpt <= 0;
        time := time + (fast.duration - fast.damage_window_start);
        gained := gained + fast.energy;

        -- CHARGE move
        IF gained >= charge.energy THEN
            hpt := hpt - c_dmg;
            time := time + charge.damage_window_start;
            EXIT WHEN hpt <= 0;
            time := time + (charge.duration - charge.damage_window_start);
            gained := gained - charge.energy;
        END IF;
    END LOOP;
return ROUND(time / 1000, 1);
END
' LANGUAGE 'plpgsql';


-- 243,"COUNTER",2,12,900,8,700,900
-- 246,"DYNAMIC_PUNCH",2,90,2700,50,1200,2700
select * from test(200, 12, 'COUNTER', 90, 'DYNAMIC_PUNCH');

-- 207,"LOW_KICK",2,6,600,6,300,600
-- 247,"FOCUS_BLAST",2,140,3500,100,3000,3500
select * from test(200, 6, 'LOW_KICK', 140, 'FOCUS_BLAST');

select * from test(297, 7, 'LOW_KICK', 92, 'DYNAMIC_PUNCH');


WITH Q as(
select *
from calc_counter('METAGROSS',1500,15,0,15,'STEEL') 
-- where c_type='STEEL' 
where dps_t > 50 and ac_t > 50
)
select * from Q
where (uid, dps) in (
    select uid, MAX(dps) from Q group by uid
)
order by dps desc
limit 20;

WITH Q as(
select *
from calc_counter('METAGROSS',1500,15,0,15,'STEEL') 
-- where c_type='STEEL' 
where dps_t > 50 and ac_t > 50
)
select * from Q
where (uid, dps) in (
    select uid, MAX(dps) from Q group by uid
)
order by ac desc
limit 20;








drop function if exists test(val text);
create or replace function test(val text)
returns boolean as '
DECLARE
    text1 text := ''ABC_DEF'';
    text2 text := ''ナッシー'';
    temp record;
    ret boolean;
BEGIN
    IF val ~ ''^[A-Z_]+$'' then
        select true into ret;
    else
        select false into ret;
    END IF;
    return ret;
END
' language 'plpgsql';




drop function if exists test(
    _pokemon text, _cp integer, _hp integer, _stardust integer, _overall text, _stats_feedback text, _best_1 text, _best_2 text, _best_3 text
);
create or replace function test(
    _pokemon text, _cp integer, _hp integer, _stardust integer, _overall text, _stats_feedback text, _best_1 text, _best_2 text, _best_3 text
)
returns record as '
DECLARE
    row_table record;
    stardust_table record;
    min_lv numeric;
    max_lv numeric;
    temp record;
    hoge record;
    curs_lv CURSOR FOR SELECT * from stardust_candy where stardust = _stardust;
    lvs numeric[];
    lv numeric;
BEGIN
    FOR temp in curs_lv LOOP
        RAISE info ''lv from cursor: %'', temp.lv;
        lvs = array_append(lvs, temp.lv);
    END LOOP;

    FOR temp in curs_lv LOOP
        RAISE info ''lv from cursor again: %'', temp.lv;
    END LOOP;

    FOREACH lv in ARRAY lvs LOOP
        RAISE info ''lv from array: %'', lv;
    END LOOP;

    FOR temp in select * from stardust_candy where stardust = _stardust LOOP
        RAISE info ''lv from query: %'', temp.lv;
    END LOOP;

    select min(lv) into min_lv from stardust_candy where stardust = _stardust;
    --min_lv := temp.lv;
    select max(lv) into max_lv from stardust_candy where stardust = _stardust;
    --max_lv := temp.lv;
    IF _pokemon ~ ''^[a-zA-Z0-9_]+$'' THEN
        select * into row_table from pokemon A join localize_pokemon B on B.uid=A.uid where A.uid=_pokemon;
    ELSE
        select * into row_table from pokemon A join localize_pokemon B on B.uid=A.uid where B.jp=_pokemon;
    END IF;

    RAISE info ''from % to %'',min_lv, max_lv;

    return stardust_table;
END
' LANGUAGE 'plpgsql';





drop function if exists test(
    _pokemon text, _cp integer, _hp integer, _stardust integer, _overall text, _stats_feedback text, _best_1 text, _best_2 text, _best_3 text
);
create or replace function test(
    _pokemon text, _cp integer, _hp integer, _stardust integer, _overall text, _stats_feedback text, _best_1 text, _best_2 text, _best_3 text
)
returns record as '
DECLARE
    row_table record;
    stardust_table record;
    min_lv numeric;
    max_lv numeric;
    temp record;
    hoge record;
    curs_lv CURSOR FOR SELECT * from stardust_candy where stardust = _stardust;
    lvs numeric[];
    lv numeric;
BEGIN
    FOR temp in select * from stardust_candy where stardust = _stardust LOOP
        RAISE info ''lv from query: %'', temp.lv;
        lvs = array_append(lvs, temp.lv);
    END LOOP;

    FOR temp in curs_lv LOOP
        RAISE info ''lv from cursor: %'', temp.lv;
    --    lvs = array_append(lvs, temp.lv);
    END LOOP;

    FOR temp in curs_lv LOOP
        RAISE info ''lv from cursor again: %'', temp.lv;
    END LOOP;

    FOREACH lv in ARRAY lvs LOOP
        RAISE info ''lv from array: %'', lv;
    END LOOP;



    select min(lv) into min_lv from stardust_candy where stardust = _stardust;
    --min_lv := temp.lv;
    select max(lv) into max_lv from stardust_candy where stardust = _stardust;
    --max_lv := temp.lv;
    IF _pokemon ~ ''^[a-zA-Z0-9_]+$'' THEN
        select * into row_table from pokemon A join localize_pokemon B on B.uid=A.uid where A.uid=_pokemon;
    ELSE
        select * into row_table from pokemon A join localize_pokemon B on B.uid=A.uid where B.jp=_pokemon;
    END IF;

    RAISE info ''from % to %'',min_lv, max_lv;

    return stardust_table;
END
' LANGUAGE 'plpgsql';




drop function if exists test(val text);
create or replace function test(val text)
returns boolean as '
DECLARE
    text1 text := ''ABC_DEF'';
    text2 text := ''ナッシー'';
    temp record;
    ret boolean;
BEGIN
    IF val ~ ''^[A-Z_]+$'' then
        select true into ret;
    else
        select false into ret;
    END IF;
    return ret;
END
' language 'plpgsql';



drop TYPE if exists hp_lv;
CREATE TYPE hp_lv AS (
    lv numeric,
    hp integer
);
drop function if exists test(val text);
create or replace function test(val text)
returns hp_lv as '
DECLARE
    tbl record;
    temp lp_lv[];
BEGIN
    FOR tbl in select * from stardust_candy where stardust = 1000 LOOP
        RAISE info ''lv from query: %'', temp.lv;
        temp = array_append(lvs, (temp.lv, temp.stardust));
    END LOOP;
    return temp[1];
END
' language 'plpgsql';






drop function if exists test(hp integer);
create or replace function test(hp integer)
returns integer as '
DECLARE
    temp JSON;
BEGIN
    temp := ''{"lv":2.5, "hp":0}''::JSON;
--    temp->''hp'' := hp;
    return temp::JSON->''hp'';
END
' language 'plpgsql';






drop function if exists test(hp integer);
create or replace function test(hp integer)
returns integer as '
DECLARE
    temp JSON;
BEGIN
    temp := concat(''{"lv":2.5, "hp":'', hp, ''}'')::JSON;
--    temp->''hp'' := hp;
    return temp::JSON->''hp'';
END
' language 'plpgsql';



With Q as (
    select
        A.index,B.jp as move, C.jp as type, 
        A.power as pow, A.duration as dur, A.energy as ene 
    from _fastmove_combat A 
    join localize_fastmove B on B.uid=A.uid 
    join localize_type C on C.index=A.type
),
R as(
    select 
        Q.index, Q.move, Q.type,
        Q.pow, (Q.dur + 1)::numeric * 0.5 as dur, Q.ene
    from Q
)
select
    *,
    case when pow is null then 0 else Round(pow / dur, 2) end as dps,
    case when ene is null then 0 else Round(ene / dur, 2) end as eps
from R
;


With Q as (
    select
        A.index,
        A.uid,
        B.jp as move, 
        C.uid as type, 
        A.power as pow, (A.energy * -1) as ene 
    from _chargemove_combat A 
    join localize_chargemove B on B.uid=A.uid 
    join localize_type C on C.index=A.type
)
select
    *,
    case when pow is null then 0 else Round(pow::numeric / ene::numeric, 2) end as dpe
from Q
order by index;





--   psql sandbox -c "select * from calc_counter_combat('METAGROSS',1500,15,15,15,'BULLET_PUNCH','METEOR_MASH') order by kill_b, x desc, kill limit 50;" -A -t -F $'\t' > fastmove_combat.tsv


With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('METAGROSS',1500,15,15,15,'BULLET_PUNCH','METEOR_MASH')) 
select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) and kill_b < 16 order by damage,uid;

select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('METAGROSS',1500,15,15,15,'BULLET_PUNCH','METEOR_MASH') order by kill_b, damage;

select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('PORYGON',1500,15,15,15,'QUICK_ATTACK','SOLAR_BEAM') order by kill_b, damage;

select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('SHARPEDO',1500,15,15,15,'BITE','CRUNCH') order by kill_b, damage;

With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('SHARPEDO',1500,15,15,15,'BITE','CRUNCH')) 
select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) and kill = kill_b order by damage,uid;



select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('SKUNTANK',1500,15,15,15,'BITE','CRUNCH') order by kill_b, damage;
With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('SKUNTANK',1500,15,15,15,'BITE','CRUNCH')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid;


select * from calc_bracket('SKUNTANK',1500,13,12,14,null);

With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('SKUNTANK',1500,13,12,14,'BITE','CRUNCH')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid;


With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('FLOATZEL',1500,15,15,15,'WATER_GUN','HYDRO_PUMP')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid;


With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('LATIOS',1500,15,15,15,'DRAGON_BREATH','SOLAR_BEAM')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid;

select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('DRAGONITE',1500,15,15,15,'DRAGON_TAIL','DRACO_METEOR') order by kill_b, damage;
With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('DRAGONITE',1500,15,15,15,'DRAGON_TAIL','DRACO_METEOR')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid;



select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('MAWILE',1500,15,15,15,'BITE','PLAY_ROUGH') order by kill_b, damage;
With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('MAWILE',1500,15,15,15,'BITE','PLAY_ROUGH')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid;



select concat(
    'select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat(''',
    A.pokemon_uid,
    ''',1500,15,15,15,''',
    A.f_uid,
    ''',''',
    A.c_uid,
    ''') order by kill_b, damage limit 30; -- ',
    B.jp, ' ', C.jp, ' ', D.jp
    )
from pokemon_pattern_combat A
join localize_pokemon B on B.uid=A.pokemon_uid
join localize_fastmove C on C.uid=A.f_uid
join localize_chargemove D on D.uid=A.c_uid
order by A.index;


select concat(
    'With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat(''',
    A.pokemon_uid,
    ''',1500,15,15,15,''',
    A.f_uid,
    ''',''',
    A.c_uid,
    ''')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid limit 30; -- ',
    B.jp, ' ', C.jp, ' ', D.jp
    )
from pokemon_pattern_combat A
join localize_pokemon B on B.uid=A.pokemon_uid
join localize_fastmove C on C.uid=A.f_uid
join localize_chargemove D on D.uid=A.c_uid
order by A.index;



select A.index, A.uid, A.type_1, A.type_2, B.cp, B.lv, B.atk, B.def, B.hpt, B.AC from pokemon A, calc_all(A.uid,1500,15,15,15,'') as B;

select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW') order by kill_b/death_b, kill_b, damage, uid, dps desc limit 50; -- ギラティナ (アナザーフォルム) りゅうのいぶき ドラゴンクロー

With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid limit 30; -- ギラティナ (アナザーフォルム) りゅうのいぶき ドラゴンクロー



select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','THUNDER') 
where uid='CRESSELIA' 
order by kill_b/death_b, kill_b, damage, uid, dps desc limit 50; -- ラティアス りゅうのいぶき かみなり

With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','THUNDER')) select * from Q 
where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) 
and uid='CRESSELIA' 
order by damage,uid limit 30; -- ラティアス りゅうのいぶき かみなり




With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('LATIOS',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid limit 30; -- ラティオス りゅうのいぶき ドラゴンクロー


With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','OUTRAGE')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid limit 30; -- ラティアス りゅうのいぶき げきりん

V0466_POKEMON_ELECTIVIRE    エレキブル
V0467_POKEMON_MAGMORTAR     ブーバーン
V0472_POKEMON_GLISCOR       グライオン


select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('MUK_ALOLA',1500,15,15,15,'BITE','SLUDGE_WAVE') order by kill_b, damage, uid, dps desc limit 50; -- ベトベトン (アローラのすがた) かみつく ヘドロウェーブ
With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('MUK_ALOLA',1500,15,15,15,'BITE','SLUDGE_WAVE')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid limit 30; -- ベトベトン (アローラのすがた) かみつく ヘドロウェーブ

select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('MUK_ALOLA',2500,15,15,15,'BITE','SLUDGE_WAVE') order by kill_b, damage, uid, dps desc limit 50; -- ベトベトン (アローラのすがた) かみつく ヘドロウェーブ
With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('MUK_ALOLA',2500,15,15,15,'BITE','SLUDGE_WAVE')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid limit 30; -- ベトベトン (アローラのすがた) かみつく ヘドロウェーブ

select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('MUK_ALOLA',5500,15,15,15,'BITE','SLUDGE_WAVE') order by kill_b, damage, uid, dps desc limit 50; -- ベトベトン (アローラのすがた) かみつく ヘドロウェーブ
With Q as (select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat('MUK_ALOLA',5500,15,15,15,'BITE','SLUDGE_WAVE')) select * from Q where (uid, chargemove) in (select uid, MAX(chargemove) from Q group by uid) order by damage,uid limit 30; -- ベトベトン (アローラのすがた) かみつく ヘドロウェーブ




