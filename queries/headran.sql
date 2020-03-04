select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('HEATRAN',5500,15,15,15,'FIRE_SPIN','FIRE_BLAST') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('HEATRAN',5500,15,15,15,'FIRE_SPIN','IRON_HEAD') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;

select *
from calc_counter_combat('HEATRAN',5500,15,15,15,'FIRE_SPIN','IRON_HEAD') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;

select *
from calc_counter_combat('HEATRAN',2500,15,15,15,'FIRE_SPIN','IRON_HEAD') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;



select *
from calc_counter_combat('HEATRAN',2500,15,15,15,'FIRE_SPIN','FIRE_BLAST') 
where kill<death and kill_b<death_b and kill=kill_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;

select *
from calc_counter_combat('SHARPEDO',1500,15,15,15,'BITE','CRUNCH') 
where kill<death and kill_b<death_b and kill=kill_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;



select *
from calc_counter_combat('SHARPEDO',1500,15,15,15,'BITE','CRUNCH') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;


select *
from calc_counter_combat('MEDICHAM',1500,15,15,15,'COUNTER','DYNAMIC_PUNCH') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;



--DRIFBLIM
select * from pokemon_pattern_combat where pokemon_uid='DRIFBLIM';

select *
from calc_counter_combat('DRIFBLIM',1500,15,15,15,'HEX','OMINOUS_WIND') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;

--RATICATE_ALOLA
select *
from calc_counter_combat('RATICATE_ALOLA',1500,15,15,15,'BITE','CRUNCH') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;


--ZAPDOS
select *
from calc_counter_combat('ZAPDOS',5500,15,15,15,'THUNDER_SHOCK','THUNDERBOLT') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;

--RAIKOU
select *
from calc_counter_combat('RAIKOU',5500,15,15,15,'THUNDER_SHOCK','THUNDERBOLT') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;

--LATIAS
select *
from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','OUTRAGE') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;
select *
from calc_counter_combat('LATIAS',2500,15,15,15,'DRAGON_BREATH','OUTRAGE') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;


--MAWILE
select * from pokemon_pattern_combat where pokemon_uid='MAWILE';

select *
from calc_counter_combat('MAWILE',1500,15,15,15,'BITE','PLAY_ROUGH') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;


--EMPOLEON
select * from pokemon_pattern_combat where pokemon_uid='EMPOLEON';
 index | pokemon_uid |   f_uid    | f_type | f_pow | f_dur | f_ene | f_leg | f_stab | f_stab_pow |    c_uid     | c_type | c_pow | c_ene | c_leg | c_stab | c_stab_pow 
-------+-------------+------------+--------+-------+-------+-------+-------+--------+------------+--------------+--------+-------+-------+-------+--------+------------
   395 | EMPOLEON    | METAL_CLAW | STEEL  |     5 |   1.0 |     6 | f     | t      |        6.0 | HYDRO_PUMP   | WATER  |   130 |    75 | f     | t      |      156.0
   395 | EMPOLEON    | METAL_CLAW | STEEL  |     5 |   1.0 |     6 | f     | t      |        6.0 | FLASH_CANNON | STEEL  |   110 |    65 | f     | t      |      132.0
   395 | EMPOLEON    | METAL_CLAW | STEEL  |     5 |   1.0 |     6 | f     | t      |        6.0 | BLIZZARD     | ICE    |   130 |    75 | f     | f      |      130.0
   395 | EMPOLEON    | WATERFALL  | WATER  |    10 |   1.5 |     8 | f     | t      |       12.0 | HYDRO_PUMP   | WATER  |   130 |    75 | f     | t      |      156.0
   395 | EMPOLEON    | WATERFALL  | WATER  |    10 |   1.5 |     8 | f     | t      |       12.0 | FLASH_CANNON | STEEL  |   110 |    65 | f     | t      |      132.0
   395 | EMPOLEON    | WATERFALL  | WATER  |    10 |   1.5 |     8 | f     | t      |       12.0 | BLIZZARD     | ICE    |   130 |    75 | f     | f      |      130.0
(6 rows)

select *
from calc_counter_combat('EMPOLEON',1500,15,15,15,'METAL_CLAW','BLIZZARD') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;

select *
from calc_counter_combat('EMPOLEON',2500,15,15,15,'WATERFALL','HYDRO_PUMP') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;


--GARDEVOIR
select * from pokemon_pattern_combat where pokemon_uid='GARDEVOIR';
CONFUSION
DAZZLING_GLEAM
select *
from calc_counter_combat('GARDEVOIR',2500,15,15,15,'CONFUSION','DAZZLING_GLEAM') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;


SKUNTANK
select * from pokemon_pattern_combat where pokemon_uid='SKUNTANK';
select *
from calc_counter_combat('SKUNTANK',2500,15,15,15,'BITE','CRUNCH') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;

WHISCASH
select *
from calc_counter_combat('WHISCASH',2500,15,15,15,'WATER_GUN','MUD_BOMB') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;

ABOMASNOW
select *
from calc_counter_combat('ABOMASNOW',2500,15,15,15,'RAZOR_LEAF','BLIZZARD') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;
select *
from calc_counter_combat('ABOMASNOW',2500,15,15,15,'POWDER_SNOW','OUTRAGE') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;


select *
from calc_counter_combat('ROSERADE',1500,15,15,15,'RAZOR_LEAF','SOLAR_BEAM') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;



select type_1,type_2, count(*) from pokemon group by type_1,type_2 order by type_1,type_2;


select CASE when type_1>type_2 then concat(type_1,'-',type_2) else concat(type_2,type_1) end, count(*)
from pokemon group by CASE when type_1>type_2 then concat(type_1,type_2) else concat(type_2,type_1) end;



select type_1, type_2, CASE when type_1>type_2 then true else false end from pokemon;

With Q as(
    select 
        CASE when type_1>type_2 then concat(type_2,'/',type_1) 
        else (
            case when type_2 is null then type_1 else concat(type_1,'/',type_2) end
        )
    end as types from pokemon
)
select types,count(*) from Q group by types order by types;





With Q as(
    select 
        CASE when type_1>type_2 then concat(type_2,'/',type_1) 
        else (
            case when type_2 is null then type_1 else concat(type_1,'/',type_2) end
        )
    end as types from pokemon
),
R as (
    select types, count(*) as cnt from Q group by types
)
select * from R order by cnt;


select *
from calc_counter_combat('SPIRITOMB',1500,15,15,15,'SUCKER_PUNCH','SHADOW_BALL') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;


select *
from calc_counter_combat(null,1500,15,15,15,null,null)
order by dps desc;




select *
from calc_counter_combat('DRAGONAIR',1500,15,15,15,'DRAGON_BREATH','DRAGON_PULSE') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;


 index |       uid        |              jp               |  type_1  |  type_2  |  cp  | lv | atk | def | hpt | lf |    fastmove    |  f_type  | f_dmg | f_dur | f_x | lc |    chargemove    |  c_type  | c_dmg | set |  per  | sec  | dps  | kill  | death | kill_b | death_b | ofd | fdpsp | ofdpsp |   x   |  cdp  |  ocdp  
-------+------------------+-------------------------------+----------+----------+------+----+-----+-----+-----+----+----------------+----------+-------+-------+-----+----+------------------+----------+-------+-----+-------+------+------+-------+-------+--------+---------+-----+-------+--------+-------+-------+--------
    68 | MACHAMP          | カイリキー                    | FIGHTING |          | 3056 | 40 | 196 | 137 | 175 |    | カウンター     | FIGHTING |    18 |   1.0 |   8 |    | ばくれつパンチ   | FIGHTING |   202 | 346 | 1.831 |  8.0 | 46.3 |   8.0 |  20.5 |   11.0 |    29.5 |   3 | 0.095 |  0.034 | 2.778 | 1.069 |  0.303
    68 | MACHAMP          | カイリキー                    | FIGHTING |          | 3056 | 40 | 196 | 137 | 175 |    | カウンター     | FIGHTING |    18 |   1.0 |   5 | ▲  | クロスチョップ   | FIGHTING |   112 | 202 | 1.069 |  5.0 | 40.4 |   5.0 |  20.5 |   11.0 |    29.5 |   3 | 0.095 |  0.034 | 2.778 | 0.593 |  0.303
  




select 
    index as "#",
    uid,
    jp as name,
    type_1,
    type_2,
    lf as "▲",
    fastmove as "通常技",
    f_type as "タイプ",
    chargemove as "必殺技",
    c_type as "タイプ",
    sec as "溜め",
    kill as "倒す",
    death as "倒され",
    kill_b as "倒す(B)",
    death_b as "倒され(B)",
    Round(fdpsp * 100,1) || '%' as "通常DPS",
    Round(ofdpsp * 100,1) || '%' as "敵通常DPS",
    Round(cdp * 100,1) || '%' as "必殺DMG",
    Round(ocdp * 100,1) || '%' as "敵必殺DMG"
from calc_counter_combat('DRAGONAIR',1500,15,15,15,'DRAGON_BREATH','DRAGON_PULSE')
where kill < death and kill_b < death_b
order by kill/death
;


select 
--    index as "#",
--    uid,
    jp as "ポケモン",
    type_1 as "タイプ1",
    type_2 as "タイプ2",
    lf as "▲",
    fastmove as "通常技",
    f_type as "タイプ",
    lc as "▲",
    chargemove as "必殺技",
    c_type as "タイプ",
    sec as "溜め",
    kill as "倒す",
    death as "倒され",
    kill_b as "倒す(B)",
    death_b as "倒され(B)",
    Round(fdpsp * 100,1) || '%' as "通常DPS",
    Round(ofdpsp * 100,1) || '%' as "敵通常DPS",
    Round(cdp * 100,1) || '%' as "必殺DMG",
    Round(ocdp * 100,1) || '%' as "敵必殺DMG"
from calc_counter_combat('CRESSELIA',5500,15,15,15,'PSYCHO_CUT','MOONBLAST') 
where kill < death and kill_b < death_b
order by kill/death
;


select 
--    index as "#",
--    uid,
    jp as "ポケモン",
    type_1 as "タイプ1",
    type_2 as "タイプ2",
    lf as "▲",
    fastmove as "通常技",
    f_type as "タイプ",
    lc as "▲",
    chargemove as "必殺技",
    c_type as "タイプ",
    sec as "溜め",
    kill as "倒す",
    death as "倒され",
    kill_b as "倒す(B)",
    death_b as "倒され(B)",
    Round(fdpsp * 100,1) || '%' as "通常DPS",
    Round(ofdpsp * 100,1) || '%' as "敵通常DPS",
    Round(cdp * 100,1) || '%' as "必殺DMG",
    Round(ocdp * 100,1) || '%' as "敵必殺DMG"
from calc_counter_combat('GROUDON',5500,15,15,15,'MUD_SHOT','EARTHQUAKE')  
where kill < death and kill_b < death_b
order by index, (kill/death) * (kill_b/death_b)
;

select 
--    index as "#",
--    uid,
    jp as "ポケモン",
    type_1 as "タイプ1",
    type_2 as "タイプ2",
    lf as "▲",
    fastmove as "通常技",
    f_type as "タイプ",
    lc as "▲",
    chargemove as "必殺技",
    c_type as "タイプ",
    sec as "溜め",
    kill as "倒す",
    death as "倒され",
    kill_b as "倒す(B)",
    death_b as "倒され(B)",
    Round(fdpsp * 100,1) || '%' as "通常DPS",
    Round(ofdpsp * 100,1) || '%' as "敵通常DPS",
    Round(cdp * 100,1) || '%' as "必殺DMG",
    Round(ocdp * 100,1) || '%' as "敵必殺DMG"
from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','OUTRAGE')  
where kill < death and kill_b < death_b
order by index, (kill/death) * (kill_b/death_b)
;


select 
--    index as "#",
--    uid,
    jp as "ポケモン",
    type_1 as "タイプ1",
    type_2 as "タイプ2",
    lf as "▲",
    fastmove as "通常技",
    f_type as "タイプ",
    lc as "▲",
    chargemove as "必殺技",
    c_type as "タイプ",
    sec as "溜め",
    kill as "倒す",
    death as "倒され",
    kill_b as "倒す(B)",
    death_b as "倒され(B)",
    Round(fdpsp * 100,1) || '%' as "通常DPS",
    Round(ofdpsp * 100,1) || '%' as "敵通常DPS",
    Round(cdp * 100,1) || '%' as "必殺DMG",
    Round(ocdp * 100,1) || '%' as "敵必殺DMG"
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW')  
where kill < death and kill_b < death_b
order by index, (kill/death) * (kill_b/death_b)
;


With A as (
select 
--    index as "#",
--    uid,
    jp as "ポケモン",
    type_1 as "タイプ1",
    type_2 as "タイプ2",
    lf as "▲",
    fastmove as "通常技",
    f_type as "タイプ",
    lc as "▲",
    chargemove as "必殺技",
    c_type as "タイプ",
    sec as "溜め",
    kill as "倒す",
    death as "倒され",
    kill_b as "倒す(B)",
    death_b as "倒され(B)",
    Round(fdpsp * 100,1) || '%' as "通常DPS",
    Round(ofdpsp * 100,1) || '%' as "敵通常DPS",
    Round(cdp * 100,1) || '%' as "必殺DMG",
    Round(ocdp * 100,1) || '%' as "敵必殺DMG"
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW')  
where kill < death and kill_b < death_b
order by index, (kill/death) * (kill_b/death_b)
) 
select count(*), count(distinct "ポケモン") as cnt from A;


-- アクアテールとハイドロポンプを両方持つポケモン
select A.* from pokemon_pattern_combat A join pokemon_pattern_combat B on B.pokemon_uid=A.pokemon_uid and B.f_uid=A.f_uid where A.c_uid='AQUA_TAIL' and B.c_uid='HYDRO_PUMP';


-- チャージの溜まるのが早い順
select B.jp, A.*, CEIL(c_ene::NUMERIC / f_ene::NUMERIC) * f_dur as chargetime 
from pokemon_pattern_combat A
join localize_pokemon B on B.uid=A.pokemon_uid
order by chargetime, index;

-- HP*DEFの値（アーマークラス）が高い順
select distinct
index,uid,jp,type_1,type_2,cp,lv,atk,def,hpt,
(def*hpt) as "AC"
from calc_counter_combat(null,5500,15,15,15,null,null)
order by "AC" desc;

select distinct
index,uid,jp,type_1,type_2,cp,lv,atk,def,hpt,
(def*hpt) as "AC"
from calc_counter_combat(null,1500,15,15,15,null,null)
order by "AC" desc;


-- 偏差値とランクつき



With A as(
    select distinct
    index,uid,jp,type_1,type_2,cp,lv,atk,def,hpt,
    (def*hpt) as ac
    from calc_counter_combat(null,5500,15,15,15,null,null)
), B as (
    select avg(A.ac) as avg_ac, stddev(A.ac) as stddev_ac from A
), C as (
    select avg(A.atk) as avg_atk, stddev(A.atk) as stddev_atk from A
)
select
    A.index, A.uid, A.jp, A.type_1, A.type_2, A.cp, A.lv, A.atk, A.def, A.hpt,
    ROUND(A.ac / B.avg_ac * 100, 0) as AC,
    ROUND((A.ac - B.avg_ac) / B.stddev_ac * 10 + 50, 1) as T_AC,
    rank() OVER (ORDER BY A.ac desc) AS rank_AC,
    ROUND((A.atk - C.avg_atk) / C.stddev_atk * 10 + 50, 1) as T_ATK,
    rank() OVER (ORDER BY A.atk desc) AS rank_atk
    from A
    join B on true
    join C on true
order by A.ac desc;

With A as(
    select distinct
    index,uid,jp,type_1,type_2,cp,lv,atk,def,hpt,
    (def*hpt) as ac
    from calc_counter_combat(null,1500,15,15,15,null,null)
), B as (
    select avg(A.ac) as avg_ac, stddev(A.ac) as stddev_ac from A
), C as (
    select avg(A.atk) as avg_atk, stddev(A.atk) as stddev_atk from A
)
select
    A.index, A.uid, A.jp, A.type_1, A.type_2, A.cp, A.lv, A.atk, A.def, A.hpt,
    ROUND(A.ac / B.avg_ac * 100, 0) as AC,
    ROUND((A.ac - B.avg_ac) / B.stddev_ac * 10 + 50, 1) as T_AC,
    rank() OVER (ORDER BY A.ac desc) AS rank_AC,
    ROUND((A.atk - C.avg_atk) / C.stddev_atk * 10 + 50, 1) as T_ATK,
    rank() OVER (ORDER BY A.atk desc) AS rank_atk
    from A
    join B on true
    join C on true
order by A.ac desc;

