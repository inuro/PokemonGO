-- simulate raid battle
-- [usage]
--  simulate_raid(
        'Player_HP, Player_Fastmove, Fastmove_dmg(fully calculated), Player_Chargemove, Chargemove_dmg(fully calculated)',
        'Opponent_HP, Opponent_Fastmove, Fastmove_dmg(fully calculated), Opponent_Chargemove, Chargemove_dmg(fully calculated)'
    )
-- [example] BRELOOM to DIALGA(T5) 
-- select * from simulate_raid('134,COUNTER,14,DYNAMIC_PUNCH,98','15000,DRAGON_BREATH,7,DRACO_METEOR,165');
-- [example] MACHOMP to DIALGA(T5) 
-- select * from simulate_raid('175,COUNTER,13,DYNAMIC_PUNCH,96','15000,DRAGON_BREATH,7,DRACO_METEOR,151');

-- [example] BLAZIKEN | COUNTER     | FOCUS_BLAST 
-- select * from simulate_raid('162,COUNTER,14,FOCUS_BLAST,152','15000,DRAGON_BREATH,7,DRACO_METEOR,168');

-- SALAMENCE        | DRAGON_TAIL   | DRACO_METEOR    |    12 |   117 |  10.9 |  32.5 |      16.2 |      16.8 |           926.3 |      10 |     229 | 182 |  125.8
-- select * from simulate_raid('182,DRAGON_TAIL,12,DRACO_METEOR,117','15000,DRAGON_BREATH,10,DRACO_METEOR,229');

-- ABRA             | ZEN_HEADBUTT  | PSYSHOCK        |     5 |    23 |   4.5 |   8.5 |       6.3 |       7.1 |          2368.4 |      11 |     271 |  85 |  318.8
-- select * from simulate_raid('85,ZEN_HEADBUTT,5,PSYSHOCK,23','15000,DRAGON_BREATH,11,DRACO_METEOR,271');

drop function if exists simulate_raid(player text, opponent text, alliance integer);
create or replace function simulate_raid(player text, opponent text, alliance integer)
returns table(
    Time2Kill numeric,
    dps numeric,
    number integer
)as '
DECLARE
    condition text[];
    p_hp integer;
    p_fastmove text;
    p_f_dmg numeric;
    p_chargemove text;
    p_c_dmg integer;
    o_hp integer;
    o_fastmove text;
    o_f_dmg numeric;
    o_chargemove text;
    o_c_dmg integer;
BEGIN
-------- extract player and opponent conditions
    condition := string_to_array(player,'','');
    p_hp := condition[1]::integer;
    p_fastmove := condition[2];
    p_f_dmg := condition[3]::integer;
    p_chargemove := condition[4];
    p_c_dmg := condition[5]::integer;

    condition := string_to_array(opponent,'','');
    o_hp := condition[1]::integer;
    o_fastmove := condition[2];
    o_f_dmg := condition[3]::integer;
    o_chargemove := condition[4];
    o_c_dmg := condition[5]::integer;

    return query 
        select * from simulate_raid(
            p_hp,p_fastmove,p_f_dmg,p_chargemove,p_c_dmg,
            o_hp,o_fastmove,o_f_dmg,o_chargemove,o_c_dmg,
            alliance
        );
    return;
END
' LANGUAGE 'plpgsql';


drop function if exists simulate_raid(p_hp integer,p_fastmove text,p_f_dmg numeric,p_chargemove text,p_c_dmg numeric,o_hp integer,o_fastmove text,o_f_dmg numeric,o_chargemove text,o_c_dmg numeric, alliance integer);
create or replace function simulate_raid(p_hp integer,p_fastmove text,p_f_dmg numeric,p_chargemove text,p_c_dmg numeric,o_hp integer,o_fastmove text,o_f_dmg numeric,o_chargemove text,o_c_dmg numeric, alliance integer)
returns table(
    Time2Kill numeric,
    dps numeric,
    number integer
)as '
DECLARE
    condition text[];
    temp record;

    p_max_hp integer;
    p_f_dur numeric;
    p_f_ini numeric;
    p_f_ene integer;
    p_c_dur numeric;
    p_c_ini numeric;
    p_c_ene integer;
    p_f_timer numeric := 0.0;
    p_c_timer numeric := 0.0;
    p_charge integer := 0;
    p_swap_timer numeric := 0.0;
    p_count integer := 1;

    o_max_hp integer;
    o_f_dur numeric;
    o_f_ini numeric;
    o_f_ene integer;
    o_c_dur numeric;
    o_c_ini numeric;
    o_c_ene integer;
    o_f_timer numeric := 0.0;
    o_c_timer numeric := 0.0;
    o_charge integer := 0;

    elapsed_time numeric := 0.0;
    message text;
    given_damage integer := 0;
    cycle_start_time numeric := 0.0;

BEGIN
-------- extract player and opponent conditions
    p_max_hp := p_hp;
    o_max_hp := o_hp;

-------- player dmg multiply by alliance member number
    p_f_dmg := p_f_dmg * alliance;
    p_c_dmg := p_c_dmg * alliance;

-- RAISE info ''Player: hp:% / % (dmg:%) / % (dmg:%)'', p_hp,p_fastmove,p_f_dmg,p_chargemove,p_c_dmg;
-- RAISE info ''Opponent: hp:% / % (dmg:%) / % (dmg:%)'', o_hp,o_fastmove,o_f_dmg,o_chargemove,o_c_dmg;

-------- fetch move info
    select * into temp from _fastmove where uid=p_fastmove;
    p_f_dur := temp.duration::numeric / 1000;
    p_f_ini := temp.damage_window_start::numeric / 1000;
    p_f_ene := temp.energy;
    select * into temp from _chargemove where uid=p_chargemove;
    p_c_dur := temp.duration::numeric / 1000;
    p_c_ini := temp.damage_window_start::numeric / 1000;
    p_c_ene := temp.energy;

    -- raid boss has +1.5 extra duration
    select * into temp from _fastmove where uid=o_fastmove;
    o_f_dur := temp.duration::numeric / 1000 + 1.5;
    o_f_ini := temp.damage_window_start::numeric / 1000;
    o_f_ene := temp.energy;
    select * into temp from _chargemove where uid=o_chargemove;
    o_c_dur := temp.duration::numeric / 1000 + 1.5;
    o_c_ini := temp.damage_window_start::numeric / 1000;
    o_c_ene := temp.energy;

-- RAISE info ''Player move: % % % % / % % % %'', p_fastmove,round(p_f_dur,1),round(p_f_ini,1),p_f_ene, p_chargemove,round(p_c_dur,1),round(p_c_ini,1),p_c_ene;
-- RAISE info ''Player move: % % % % / % % % %'', o_fastmove,round(o_f_dur,1),round(o_f_ini,1),o_f_ene, o_chargemove,round(o_c_dur,1),round(o_c_ini,1),o_c_ene;

-------- loop by 0.1sec

LOOP
    message := '''';

    -- もしプレイヤーがやられて入れ替え中（swap_duration_ms=1000)は何もしない
    if p_swap_timer = 0 then
        -- Player perspective
        case 
            -- 両方のカウントダウンが0で、チャージが溜まってなければFastmoveのカウントダウンを開始
            when p_f_timer = 0 and p_c_timer = 0 and p_charge < p_c_ene then
                p_f_timer := p_f_dur;
                message := message || '' player Fastmove triggered'';
            
            -- FastmoveのカウントダウンがDagame_Window_Startに達したら、Fastmoveのダメージを与え、チャージを加算
            when p_f_dur - p_f_timer = Round(p_f_ini, 1) then
                o_hp := o_hp - p_f_dmg;
                o_charge := Least(o_charge + Ceil(p_f_dmg / 2), 100);
                p_charge := Least(p_charge + p_f_ene, 100);
                message := message || '' player Fastmove FIRED!'';
                given_damage := given_damage + p_f_dmg;
            
            -- 両方のカウントダウンが0で、チャージが溜まっていればChargemoveのカウントダウンを開始
            when p_f_timer = 0 and p_c_timer = 0 and p_charge >= p_c_ene then
                p_c_timer := p_c_dur;
                message := message || '' player Chargemove triggered'';

            -- ChargemoveのカウントダウンがDamage_Window_Startに達したら、Chargemoveのダメージを与え、チャージを加算
            when p_c_dur - p_c_timer = Round(p_c_ini, 1) then
                o_hp := o_hp - p_c_dmg;
                o_charge := Least(o_charge + Ceil(p_c_dmg / 2), 100);
                p_charge := p_charge - p_c_ene;
                message := message || '' player Chargemove FIRED!'';
                given_damage := given_damage + p_c_dmg;
            
            else
                message := message;
        end case;

        -- Opponent perspective
        case 
            -- 両方のカウントダウンが0で、チャージが溜まってなければFastmoveのカウントダウンを開始
            when o_f_timer = 0 and o_c_timer = 0 and o_charge < o_c_ene then
                o_f_timer := o_f_dur;
                message := message || '' Opponent Fastmove triggered'';
            
            -- FastmoveのカウントダウンがDagame_Window_Startに達したら、Fastmoveのダメージを与え、チャージを加算
            when o_f_dur - o_f_timer = Round(o_f_ini, 1) then
                p_hp := p_hp - o_f_dmg;
                p_charge := Least(p_charge + Ceil(o_f_dmg / 2), 100);
                o_charge := Least(o_charge + o_f_ene, 100);
                message := message || '' Opponent Fastmove FIRED!'';
            
            -- 両方のカウントダウンが0で、チャージが溜まっていればChargemoveのカウントダウンを開始
            when o_f_timer = 0 and o_c_timer = 0 and o_charge >= o_c_ene then
                o_c_timer := o_c_dur;
                message := message || '' Opponent Chargemove triggered'';

            -- ChargemoveのカウントダウンがDamage_Window_Startに達したら、Chargemoveのダメージを与え、チャージを加算
            when o_c_dur - o_c_timer = Round(o_c_ini, 1) then
                p_hp := p_hp - o_c_dmg;
                p_charge := Least(p_charge + Ceil(o_c_dmg / 2), 100);
                o_charge := o_charge - o_c_ene;
                message := message || '' Opponent Chargemove FIRED!'';
            
            else
                message := message;
        end case;
    end if;

    -- Time elapsed
    elapsed_time := elapsed_time + 0.1;
    p_f_timer := Greatest(p_f_timer - 0.1, 0.0);
    p_c_timer := Greatest(p_c_timer - 0.1, 0.0);
    o_f_timer := Greatest(o_f_timer - 0.1, 0.0);
    o_c_timer := Greatest(o_c_timer - 0.1, 0.0);
    p_swap_timer := Greatest(p_swap_timer - 0.1, 0.0);

-- RAISE info ''[%->%] Player#% HP:% Charge:% | %,% / Opponent HP:% Charge:% % '',elapsed_time-0.1, elapsed_time, p_count, p_hp, p_charge, p_f_dur - p_f_timer, p_f_ini, o_hp, o_charge, message;  

    -- Check player HP and swap to new Pokemon
    if p_hp <= 0 then
-- RAISE info ''Player#% down and switch to #% - given damage % in % sec'', p_count, p_count+1, given_damage, (elapsed_time - cycle_start_time);
        p_swap_timer := 1.0;
        p_hp := p_max_hp;
        p_charge := 0;
        p_f_timer := 0.0;
        p_c_timer := 0.0;
        p_count := p_count + 1;
        given_damage := 0;
        cycle_start_time := elapsed_time;
    end if;

    EXIT when o_hp <= 0;
END LOOP;


return query
    select
        elapsed_time,
        Round((o_max_hp - o_hp) / elapsed_time, 1),
        p_count
    ;
return;
END
' LANGUAGE 'plpgsql';
