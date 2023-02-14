#!/bin/bash
#
#   [usage]
#   $ import2psql_v3.sh <DB name> <game_master dir> <sidefile dir>
#   [example]
#   $ ./import2psql_v3.sh sandbox masterfiles sidefiles
#   
#   [note]
#   before that, create db pokemongo
#
#   # create database pokemongo
#   $ psql pokemongo
#
#   [export]
#   $ psql pokemongo -c "select *, (10 * 126 / def::NUMERIC) + 1 as avg_dmg, hpt::NUMERIC / ((10 * 126 / def::NUMERIC) + 1 ) as lifelong from cp_pvp_1500_IV15" -A -F $'\t' | sed '$d' > cp1500_iv15.tsv
#   $ psql pokemongo -c "select *, (10 * 173 / def::NUMERIC) + 1 as avg_dmg, hpt::NUMERIC / ((10 * 173 / def::NUMERIC) + 1 ) as lifelong from cp_pvp_2500_IV15" -A -F $'\t' | sed '$d' > cp2500_iv15.tsv


[ $# -ne 3 ] && echo "[usage] $ import2psql.sh <DB name> <game_master dir> <sidefile dir>" && exit 1

DB=$1
GAMEMASTERDIR=$2
SIDEFILEDIR=$3

HOST=localhost
#PORT=5432
PSQL_COMMAND="psql -p 5432 $DB"
#PSQL_COMMAND="psql -U tkawai -h localhost -p 6802 $DB"

#files generated from GAME_MASTER
FILE_FORM=$GAMEMASTERDIR/form.tsv
#FILE_TYPE=$GAMEMASTERDIR/type.csv
FILE_CPM=$GAMEMASTERDIR/cp_multiplier.tsv
FILE_STARDUST_CANDY=$GAMEMASTERDIR/stardust_candy.tsv
FILE_EFFECTIVENESS=$GAMEMASTERDIR/type_effectiveness.tsv
FILE_BATTLE_SETTINGS=$GAMEMASTERDIR/battle_settings.tsv
FILE_COMBAT_SETTINGS=$GAMEMASTERDIR/combat_settings.tsv
FILE_POKEMON=$GAMEMASTERDIR/pokemon.tsv
FILE_MON_FAST=$GAMEMASTERDIR/pokemon_fastmove.tsv
FILE_MON_CHARGE=$GAMEMASTERDIR/pokemon_chargemove.tsv
FILE_FASTMOVE=$GAMEMASTERDIR/fastmove.tsv
FILE_CHARGEMOVE=$GAMEMASTERDIR/chargemove.tsv
FILE_FASTMOVE_COMBAT=$GAMEMASTERDIR/fastmove_combat.tsv
FILE_CHARGEMOVE_COMBAT=$GAMEMASTERDIR/chargemove_combat.tsv

#files statically prepared in sidefiles directory
FILE_LOCALIZE_POKEMON=$SIDEFILEDIR/localize_pokemon.tsv
FILE_LOCALIZE_FASTMOVE=$SIDEFILEDIR/localize_fastmove.tsv
FILE_LOCALIZE_CHARGEMOVE=$SIDEFILEDIR/localize_chargemove.tsv
FILE_LOCALIZE_TYPE=$SIDEFILEDIR/localize_type.tsv
FILE_ORIGINAL_POKEMON_LOCALIZATION=$SIDEFILEDIR/original_pokemom_localization.tsv

#FILE_MON_FAST_LEGACY=$SIDEFILEDIR/pokemon_fastmove_legacy.csv
#FILE_MON_CHARGE_LEGACY=$SIDEFILEDIR/pokemon_chargemove_legacy.csv
FILE_POKEMON_NOT_YET=$SIDEFILEDIR/pokemon_not_yet.csv


#raw table names
TABLE_FORM_RAW=_form
#TABLE_TYPE_RAW=_type
TABLE_CPM=_cpm
TABLE_STARDUST_CANDY=_stardust_candy
TABLE_EFFECTIVENESS_RAW=_effectiveness
TABLE_BATTLE_SETTINGS=_battle_settings
TABLE_COMBAT_SETTINGS=_combat_settings
TABLE_POKEMON=_pokemon
TABLE_MON_FAST_RAW=_mon_fast
TABLE_MON_CHARGE_RAW=_mon_charge
TABLE_FASTMOVE_RAW=_fastmove
TABLE_CHARGEMOVE_RAW=_chargemove
TABLE_FASTMOVE_COMBAT_RAW=_fastmove_combat
TABLE_CHARGEMOVE_COMBAT_RAW=_chargemove_combat
TABLE_POKEMON_NOT_YET=_not_yet

#localization tables
TABLE_LOCALIZE_POKEMON=localize_pokemon
TABLE_LOCALIZE_FASTMOVE=localize_fastmove
TABLE_LOCALIZE_CHARGEMOVE=localize_chargemove
TABLE_LOCALIZE_TYPE=localize_type

#main table names
#TABLE_POKEMON=pokemon
TABLE_POKEMON_FASTMOVE=pokemon_fastmove
TABLE_POKEMON_CHARGEMOVE=pokemon_chargemove
TABLE_POKEMON_PATTERN=pokemon_pattern
TABLE_EFFECTIVENESS=effectiveness
TABLE_POKEMON_FASTMOVE_COMBAT=pokemon_fastmove_combat
TABLE_POKEMON_CHARGEMOVE_COMBAT=pokemon_chargemove_combat
TABLE_POKEMON_PATTERN_COMBAT=pokemon_pattern_combat

#other tables
TABLE_RESISTANCE=resistance
TABLE_WEAKNESS=weakness


SQL=$(cat << _EOS_
BEGIN;
-------------------------------------------------------------------------------
-- CP multiplier table
drop table if exists $TABLE_CPM CASCADE;
create table if not exists $TABLE_CPM(
    lv numeric,
    mlp numeric
);
\copy $TABLE_CPM(lv, mlp) from '$FILE_CPM' with CSV delimiter E'\t' NULL '';
-- insert half values
INSERT into $TABLE_CPM select Round((A.lv+B.lv)/2,1) as lv, SQRT((A.mlp^2 + B.mlp^2)/2) as mlp from $TABLE_CPM A join $TABLE_CPM as B on B.lv=A.lv+1;


-------------------------------------------------------------------------------
-- Statdust/Candy Cost for LVUP
drop table if exists $TABLE_STARDUST_CANDY;
create table if not exists $TABLE_STARDUST_CANDY(
    lv numeric,
    stardust integer,
    candy integer,
    xlcandy integer
);
\copy $TABLE_STARDUST_CANDY(lv, stardust, candy, xlcandy) from '$FILE_STARDUST_CANDY' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Type effectiveness raw table "_effectiveness"
drop table if exists $TABLE_EFFECTIVENESS_RAW CASCADE;
create table if not exists $TABLE_EFFECTIVENESS_RAW(
    attacker text,
    defender text,
    mlp numeric
);
\copy $TABLE_EFFECTIVENESS_RAW(attacker, defender, mlp) from '$FILE_EFFECTIVENESS' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Battle settings "_battle_settings"
drop table if exists $TABLE_BATTLE_SETTINGS CASCADE;
create table if not exists $TABLE_BATTLE_SETTINGS(
    key text,
    value numeric
);
\copy $TABLE_BATTLE_SETTINGS(key, value) from '$FILE_BATTLE_SETTINGS' with CSV delimiter E'\t' NULL '';

-------------------------------------------------------------------------------
-- Combat settings "_battle_settings"
drop table if exists $TABLE_COMBAT_SETTINGS CASCADE;
create table if not exists $TABLE_COMBAT_SETTINGS(
    key text,
    value numeric
);
\copy $TABLE_COMBAT_SETTINGS(key, value) from '$FILE_COMBAT_SETTINGS' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Pokemon form raw table "_form"
-- 0001	BULBASAUR	BULBASAUR_NORMAL
-- 0002	IVYSAUR	IVYSAUR_NORMAL
-- 0003	VENUSAUR	VENUSAUR_NORMAL
drop table if exists $TABLE_FORM_RAW CASCADE;
create table if not exists $TABLE_FORM_RAW(
    pokemon_id text,
    family_id text,
    uid text
);
\copy $TABLE_FORM_RAW(pokemon_id, family_id, uid) from '$FILE_FORM' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Pokemon stats raw table "_pokemon"
-- 0001	BULBASAUR	GRASS	POISON	118	111	128	true
-- 0001	BULBASAUR_FALL_2019	GRASS	POISON	118	111	128	true
-- 0001	BULBASAUR_NORMAL	GRASS	POISON	118	111	128	true

drop table if exists $TABLE_POKEMON CASCADE;
create table if not exists $TABLE_POKEMON(
    pokemon_id text,
    uid text,
    type_1 text,
    type_2 text,
    AT int,
    DF int,
    HP int,
    shadow boolean
);
\copy $TABLE_POKEMON(pokemon_id, uid, type_1, type_2, AT, DF, HP, shadow) from '$FILE_POKEMON' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Delete "dup" pokemons e.g. purified, fall_2019, etc.

-- _formテーブルにあるフォームだけをまず残す
with a as (
    select uid from $TABLE_FORM_RAW left join $TABLE_POKEMON using(pokemon_id,uid)
) delete from $TABLE_POKEMON where uid not in (select * from a);

-- _COPY_2019系を消す（VENUSAUR_COPY_2019、CHARIZARD_COPY_2019、BLASTOISE_COPY_2019、PIKACHU_COPY_2019）
delete from $TABLE_POKEMON 
where uid in ('VENUSAUR_COPY_2019','CHARIZARD_COPY_2019','BLASTOISE_COPY_2019','PIKACHU_COPY_2019');


-------------------------------------------------------------------------------
-- Generate "Shadow" pokemon
insert into $TABLE_POKEMON
select pokemon_id, concat(replace(uid,'_NORMAL',''), '_SHADOW'),type_1,type_2,at,df,hp,shadow
from $TABLE_POKEMON
where shadow=true;


-------------------------------------------------------------------------------
-- Pokemon -> Fastmove reference raw table "_mon_fast"
-- 0001	BULBASAUR	VINE_WHIP_FAST	false
-- 0001	BULBASAUR	TACKLE_FAST	false
-- 0001	BULBASAUR_FALL_2019	VINE_WHIP_FAST	false
-- 0001	BULBASAUR_FALL_2019	TACKLE_FAST	false
drop table if exists $TABLE_MON_FAST_RAW CASCADE;
create table if not exists $TABLE_MON_FAST_RAW(
    pokemon_id text,
    uid text,
    move text,
    legacy boolean
);
\copy $TABLE_MON_FAST_RAW(pokemon_id, uid, move, legacy) from '$FILE_MON_FAST' with CSV delimiter E'\t' NULL '';

-- Delete "dup" pokemons
delete from $TABLE_MON_FAST_RAW where uid not in (select uid from $TABLE_POKEMON);

-- Generate "Shadow" pokemon
insert into $TABLE_MON_FAST_RAW
select pokemon_id, concat(replace(uid,'_NORMAL',''), '_SHADOW'), move, legacy
from $TABLE_MON_FAST_RAW
left join $TABLE_POKEMON using(pokemon_id,uid)
where shadow=true;


-------------------------------------------------------------------------------
-- Pokemon -> Chargemove reference raw table
-- 0001	BULBASAUR	SLUDGE_BOMB	false
-- 0001	BULBASAUR	SEED_BOMB	false
-- 0001	BULBASAUR	POWER_WHIP	false
-- 0001	BULBASAUR_FALL_2019	SLUDGE_BOMB	false
drop table if exists $TABLE_MON_CHARGE_RAW CASCADE;
create table if not exists $TABLE_MON_CHARGE_RAW(
    pokemon_id text,
    uid text,
    move text,
    legacy boolean
);
\copy $TABLE_MON_CHARGE_RAW(pokemon_id, uid, move, legacy) from '$FILE_MON_CHARGE' with CSV delimiter E'\t' NULL '';

-- Delete "dup" pokemons
delete from $TABLE_MON_CHARGE_RAW where uid not in (select uid from $TABLE_POKEMON);

-- Generate "Shadow" pokemon
insert into $TABLE_MON_CHARGE_RAW
select pokemon_id, concat(replace(uid,'_NORMAL',''), '_SHADOW'), move, legacy
from $TABLE_MON_CHARGE_RAW
left join $TABLE_POKEMON using(pokemon_id,uid)
where shadow=true;

-- SPECIAL treats for Shadow/Purified pokemon(add FRASTRATION to _SHADOW / add RETURN to vanilla)
insert into $TABLE_MON_CHARGE_RAW 
select pokemon_id, uid, 'FRUSTRATION' as move, true::boolean as legacy 
from $TABLE_POKEMON
where shadow=true and uid ~ '_SHADOW$';

insert into $TABLE_MON_CHARGE_RAW 
select pokemon_id, uid, 'RETURN' as move, true::boolean as legacy
from $TABLE_POKEMON
where shadow=true and uid !~'_SHADOW$';


-------------------------------------------------------------------------------
-- Fastmove data raw table
drop table if exists $TABLE_FASTMOVE_RAW CASCADE;
create table if not exists $TABLE_FASTMOVE_RAW(
    index text,
    uid text,
    type text,
    power int,
    duration int,
    energy int,
    damage_window_start int,
    damage_window_end int
);
\copy $TABLE_FASTMOVE_RAW(index,uid,type,power,duration,energy,damage_window_start,damage_window_end) from '$FILE_FASTMOVE' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Chargemove data raw table
drop table if exists $TABLE_CHARGEMOVE_RAW CASCADE;
create table if not exists $TABLE_CHARGEMOVE_RAW(
    index text,
    uid text,
    type text,
    power int,
    duration int,
    energy int,
    damage_window_start int,
    damage_window_end int
);
\copy $TABLE_CHARGEMOVE_RAW(index,uid,type,power,duration,energy,damage_window_start,damage_window_end) from '$FILE_CHARGEMOVE' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Combat fastmove data raw table
drop table if exists $TABLE_FASTMOVE_COMBAT_RAW CASCADE;
create table if not exists $TABLE_FASTMOVE_COMBAT_RAW(
    index text,
    uid text,
    type text,
    power int,
    duration int,
    energy int
);
\copy $TABLE_FASTMOVE_COMBAT_RAW(index,uid,type,power,duration,energy) from '$FILE_FASTMOVE_COMBAT' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Combat fastmove data raw table
drop table if exists $TABLE_CHARGEMOVE_COMBAT_RAW CASCADE;
create table if not exists $TABLE_CHARGEMOVE_COMBAT_RAW(
    index text,
    uid text,
    type text,
    power int,
    energy int,
    buff numeric,
    target_at numeric,
    target_df numeric,
    attacker_at numeric,
    attacker_df numeric
);
\copy $TABLE_CHARGEMOVE_COMBAT_RAW(index,uid,type,power,energy,buff,target_at,target_df,attacker_at,attacker_df) from '$FILE_CHARGEMOVE_COMBAT' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Pokemon loalization
drop table if exists $TABLE_LOCALIZE_POKEMON CASCADE;
create table if not exists $TABLE_LOCALIZE_POKEMON(
    pokemon_id text,
    uid text,
    jp text,
    en text
);
\copy $TABLE_LOCALIZE_POKEMON(pokemon_id, uid, jp, en) from '$FILE_LOCALIZE_POKEMON' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Original Pokemon loalization
drop table if exists original_pokemon_localization CASCADE;
create table if not exists original_pokemon_localization(
    pokemon_id text,
    jp text,
    en text,
    de text,
    fr text,
    ko text,
    cn text,
    tw text
);
\copy original_pokemon_localization(pokemon_id, jp, en, de, fr, ko, cn, tw) from '$FILE_ORIGINAL_POKEMON_LOCALIZATION' with CSV delimiter E'\t' NULL '';




-------------------------------------------------------------------------------
-- Fastmove loalization
drop table if exists $TABLE_LOCALIZE_FASTMOVE CASCADE;
create table if not exists $TABLE_LOCALIZE_FASTMOVE(
    index text,
    uid text,
    jp text,
    en text
);
\copy $TABLE_LOCALIZE_FASTMOVE(index, uid, en, jp) from '$FILE_LOCALIZE_FASTMOVE' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Chargemove loalization
drop table if exists $TABLE_LOCALIZE_CHARGEMOVE CASCADE;
create table if not exists $TABLE_LOCALIZE_CHARGEMOVE(
    index text,
    uid text,
    jp text,
    en text
);
\copy $TABLE_LOCALIZE_CHARGEMOVE(index, uid, en, jp) from '$FILE_LOCALIZE_CHARGEMOVE' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Type loalization
drop table if exists $TABLE_LOCALIZE_TYPE CASCADE;
create table if not exists $TABLE_LOCALIZE_TYPE(
    index text,
    uid text,
    jp text,
    en text
);
\copy $TABLE_LOCALIZE_TYPE(index, uid, en, jp) from '$FILE_LOCALIZE_TYPE' with CSV delimiter E'\t' NULL '';


-------------------------------------------------------------------------------
-- Weakness
DROP TABLE if exists $TABLE_WEAKNESS;
CREATE TABLE if not exists $TABLE_WEAKNESS as(
With A as(
    select 
        a.*, 
        b1.attacker as attcker, 
        b1.mlp,b2.mlp,
        COALESCE(b1.mlp,1.0) * COALESCE(b2.mlp,1.0) as eff 
    from $TABLE_POKEMON a 
    left join $TABLE_EFFECTIVENESS_RAW b1 on b1.defender=a.type_1 
    left join $TABLE_EFFECTIVENESS_RAW b2 on b2.defender = a.type_2 and b2.attacker=b1.attacker
)
select
    uid
    ,   (max(case when attcker='NORMAL' then eff else -100.0 end)) as NORMAL
    ,   (max(case when attcker='FIGHTING' then eff else -100.0 end)) as FIGHTING
    ,   (max(case when attcker='FLYING' then eff else -100.0 end)) as FLYING
    ,   (max(case when attcker='POISON' then eff else -100.0 end)) as POISON
    ,   (max(case when attcker='GROUND' then eff else -100.0 end)) as GROUND
    ,   (max(case when attcker='ROCK' then eff else -100.0 end)) as ROCK
    ,   (max(case when attcker='BUG' then eff else -100.0 end)) as BUG
    ,   (max(case when attcker='GHOST' then eff else -100.0 end)) as GHOST
    ,   (max(case when attcker='STEEL' then eff else -100.0 end)) as STEEL
    ,   (max(case when attcker='FIRE' then eff else -100.0 end)) as FIRE
    ,   (max(case when attcker='WATER' then eff else -100.0 end)) as WATER
    ,   (max(case when attcker='GRASS' then eff else -100.0 end)) as GRASS
    ,   (max(case when attcker='ELECTRIC' then eff else -100.0 end)) as ELECTRIC
    ,   (max(case when attcker='PSYCHIC' then eff else -100.0 end)) as PSYCHIC
    ,   (max(case when attcker='ICE' then eff else -100.0 end)) as ICE
    ,   (max(case when attcker='DRAGON' then eff else -100.0 end)) as DRAGON
    ,   (max(case when attcker='DARK' then eff else -100.0 end)) as DARK
    ,   (max(case when attcker='FAIRY' then eff else -100.0 end)) as FAIRY
from A
group by uid
);



-------------------------------------------------------------------------------
-- Functions

-------------------------------------------------------------------------------
-- NULL text checker

DROP function if exists is_empty(c_target TEXT);
CREATE OR REPLACE FUNCTION is_empty(c_target TEXT)
RETURNS boolean
AS $$
declare
	b_flg boolean; 
BEGIN
    b_flg = false;
	if trim(c_target) = '' then
		b_flg = true;
	end if;

	if c_target is null then
		b_flg = true;
	end if;

	return b_flg;
END
$$ LANGUAGE 'plpgsql';




-------------------------------------------------------------------------------
-- puid (get_pokemon_uid)
drop function if exists puid(name text);
create or replace function puid(name text)
returns text as '
DECLARE
    temp record;
BEGIN
    IF name ~ ''^\w+$'' THEN
        select * into temp from $TABLE_LOCALIZE_POKEMON where uid=UPPER(name);
    ELSE
        select * into temp from $TABLE_LOCALIZE_POKEMON where jp=name;
    END IF;
    return temp.uid;
END
' LANGUAGE 'plpgsql';


-------------------------------------------------------------------------------
-- calc CP by LV,IVs (IVs could be omitted)
-- [usage] calc_cp('pokemon_uid, lv, ATIV, DFIV, CPIV')
--  e.g.
-- select * from calc_cp('ヤミラミ,40,15,15,15');
--    uid   |  cp  | lv | hpt | atk | def 
-- ---------+------+----+-----+-----+-----
--  SABLEYE | 1476 | 40 | 120 | 123 | 119
-- 
drop function if exists calc_cp(condition TEXT);
create or replace function calc_cp(condition TEXT)
returns table(uid text, cp integer, lv numeric, atk numeric, def numeric, hpt numeric) as'
DECLARE
    temp text[];
    target_uid TEXT;
    level NUMERIC;
    ATIV integer := 15;
    DFIV integer := 15;
    HPIV integer := 15;
BEGIN
    temp := string_to_array(condition,'','');
    target_uid := puid(temp[1]);
    level := temp[2];
    IF temp[3] is not null then ATIV := temp[3]::integer; end if;
    IF temp[4] is not null then DFIV := temp[4]::integer; end if;
    IF temp[5] is not null then HPIV := temp[5]::integer; end if;

    return query
        select
            B.uid,
            (floor((B.at+ATIV) * (sqrt(B.df+DFIV)) * (sqrt(B.hp+HPIV)) * (A.mlp * A.mlp) / 10))::INTEGER as cp,
            A.lv as lv,
            ((B.at+ATIV) * A.mlp)::NUMERIC as at,
            ((B.df+DFIV) * A.mlp)::NUMERIC as df,
            Floor((B.hp+HPIV) * A.mlp)::NUMERIC as hp
        from $TABLE_CPM A
        join $TABLE_POKEMON B on B.uid in (target_uid)
        where A.lv=level;
    return;
END
' LANGUAGE 'plpgsql';


-------------------------------------------------------------------------------
-- calc status on CP cap
-- [usage] calc_all('pokemon_id, cap_CP, ATIV, DFIV, HPIV, cap_lv')
--  e.g. select * from calc_all('ラティアス,1500,15,15,15');
drop function if exists calc_all(text);
create or replace function calc_all(condition TEXT)
returns table(cp integer, lv numeric, atk numeric, def numeric, hpt numeric) as'
DECLARE
    temp text[];
    target_uid TEXT;
    cap_cp integer := 5500;
    ATIV integer := 15;
    DFIV integer := 15;
    HPIV integer := 15;
    cap_lv integer := 50;
BEGIN
    temp := string_to_array(condition,'','');
    target_uid := puid(temp[1]);
    IF temp[2] is not null then cap_cp := temp[2]::integer; end if;
    IF temp[3] is not null then ATIV := temp[3]::integer; end if;
    IF temp[4] is not null then DFIV := temp[4]::integer; end if;
    IF temp[5] is not null then HPIV := temp[5]::integer; end if;
    IF temp[6] is not null then cap_lv := temp[6]::integer; end if;
--RAISE INFO ''% % % % % %'', target_uid,cap_cp,ATIV,DFIV,HPIV,cap_lv;
    return query
        with A as (
        select
            (floor((B.at+ATIV) * (sqrt(B.df+DFIV)) * (sqrt(B.hp+HPIV)) * (A.mlp * A.mlp) / 10))::INTEGER as cp,
            A.lv as lv,
            ((B.at+ATIV) * A.mlp)::NUMERIC as at,
            ((B.df+DFIV) * A.mlp)::NUMERIC as df,
            Floor((B.hp+HPIV) * A.mlp)::NUMERIC as hp
        from $TABLE_CPM A
        join $TABLE_POKEMON B on B.uid in (target_uid)
        ) select * from A where A.cp <= cap_cp and A.lv <= cap_lv order by A.cp desc limit 1;
    return;
END
' LANGUAGE plpgsql;

-------------------------------------------------------------------------------
--  calc_all_IV_pattern
-- usage: 
--  select * from calc_all_IV_pattern('ENTEI',1500) order by cp desc, (at+df+hp) desc;
--  select * from calc_all_IV_pattern('ENTEI',1500) where cp=1500 order by (at+df+hp) desc;
drop function if exists calc_all_IV_pattern(target_uid TEXT, cap_cp integer, cap_lv integer);
create or replace function calc_all_IV_pattern(target_uid TEXT, cap_cp integer, cap_lv integer DEFAULT 50)
returns table(
    IV text, 
    cp integer, 
    lv numeric, 
    at integer, df integer, hp integer, 
    overall text,
    atk numeric, def numeric, hpt numeric, 
    total numeric,
    dust integer
) as'
DECLARE
    pokemon record;
    at integer;
    df integer;
    hp integer;
BEGIN
    select * into pokemon from $TABLE_POKEMON where uid=target_uid;
    FOR hp in 0..15 LOOP
    FOR at in 0..15 LOOP
    FOR df in 0..15 LOOP

    return query 
        select 
            q1.IV, 
            q2.cp, q2.lv, 
            at as at, df as df, hp as hp, 
            case 
                when at+df+hp = 45 then ''S''
                when at+df+hp >= 37 then ''A''
                when at+df+hp >= 30 then ''B''
                when at+df+hp >= 23 then ''C''
                else ''D''
            end as overall, 
            q2.atk, q2.def, q2.hpt, 
            q2.atk+q2.def+q2.hpt total,
            q3.stardust
        from (select concat(''AT'',at,''/DF'',df,''/HP'',hp) as IV)q1
        join (select * from calc_all(concat_ws('','',target_uid,cap_cp,at,df,hp,cap_lv)))q2 on true
        join $TABLE_STARDUST_CANDY q3 on q3.lv=q2.lv;

    END LOOP;
    END LOOP;
    END LOOP;

    return;
END
' LANGUAGE 'plpgsql';



-------------------------------------------------------------------------------
-- calc_bracket
-- [usage]
--  e.g. select * from calc_bracket('VENUSAUR, 1500, 12, 14, 8');
drop function if exists calc_bracket(condition TEXT);
create or replace function calc_bracket(condition TEXT)
returns table(IV text, cp integer, lv numeric, atk numeric, def numeric, hpt numeric) as'
DECLARE
    temp text[];
    target_uid TEXT;
    cap_cp integer := 5500;
    ATIV integer := 15;
    DFIV integer := 15;
    HPIV integer := 15;
    pokemon record;
BEGIN
    temp := string_to_array(condition,'','');
    target_uid := puid(temp[1]);
    IF temp[2] is not null then cap_cp := temp[2]::integer; end if;
    IF temp[3] is not null then ATIV := temp[3]::integer; end if;
    IF temp[4] is not null then DFIV := temp[4]::integer; end if;
    IF temp[5] is not null then HPIV := temp[5]::integer; end if;

    select * into pokemon from $TABLE_POKEMON where uid=target_uid;
    return query
        select * from (select ''User defined'' as IV)q1
        join (select * from calc_all(CONCAT_WS('','',target_uid,cap_cp,ATIV,DFIV,HPIV)))q2 on true;
    return query 
        select * from (select ''Min(AT00/DF00/HP00)'' as IV)q1
        join (select * from calc_all(CONCAT_WS('','',target_uid,cap_cp,0,0,0)))q2 on true;
    return query 
        select * from (select ''Max(AT15/DF15/HP15)'' as IV)q1
        join (select * from calc_all(CONCAT_WS('','',target_uid,cap_cp,15,15,15)))q2 on true;
    return query 
        select * from (select ''Atacker(AT15/DF00/HP00)'' as IV)q1
        join (select * from calc_all(CONCAT_WS('','',target_uid,cap_cp,15,0,0)))q2 on true;
    return query 
        select * from (select ''Tank(AT00/DF00/HP15)'' as IV)q1
        join (select * from calc_all(CONCAT_WS('','',target_uid,cap_cp,0,0,15)))q2 on true;
    return;
END
' LANGUAGE 'plpgsql';


-------------------------------------------------------------------------------
--  calc weakness(type effectiveness)
-- return 1.0 when move_type or type_1 is null
drop function if exists calc_weakness(TEXT, TEXT, TEXT);
create or replace function calc_weakness(move_type TEXT, type_1 TEXT, type_2 TEXT)
returns NUMERIC as'
DECLARE
    res record;
    mlp_1 NUMERIC := 1.0;
    mlp_2 NUMERIC := 1.0;
BEGIN
    IF move_type is null or type_1 is null THEN
        RETURN 1.0;
    END IF;

    IF type_1 is not null THEN
        select mlp into res from $TABLE_EFFECTIVENESS_RAW where attacker = move_type and defender = type_1;
        IF res is not null THEN
        mlp_1 := res.mlp;
        END IF;
    END IF;

    IF type_2 is not null THEN
        select mlp into res from $TABLE_EFFECTIVENESS_RAW where attacker = move_type and defender = type_2;
        IF res is not null THEN
        mlp_2 := res.mlp;
        END IF;
    END IF;

    RETURN round(mlp_1 * mlp_2 * 1000) / 1000;
END
' LANGUAGE 'plpgsql';


-------------------------------------------------------------------------------
--  calc multiplier from attacker type and defender types

drop function if exists mlp(TEXT, TEXT, TEXT);
create or replace function mlp(attacker_type TEXT, defender_type1 TEXT, defender_type2 TEXT)
returns NUMERIC as $$
DECLARE
    val1 NUMERIC;
    val2 NUMERIC;
BEGIN
    val1 := 1.0;
    val2 := 1.0;
    if not is_empty(defender_type1) then 
        select mlp from _effectiveness where attacker=attacker_type and defender=defender_type1 into val1;
    end if;
    if not is_empty(defender_type2) then 
        select mlp from _effectiveness where attacker=attacker_type and defender=defender_type2 into val2;
    end if;
    return val1 * val2;
END
$$ LANGUAGE 'plpgsql';





-------------------------------------------------------------------------------
-- indexes
DROP INDEX if exists idx_pokemon_uid;
CREATE INDEX idx_pokemon_uid ON $TABLE_POKEMON USING btree (uid);

DROP INDEX if exists idx_effectiveness;
CREATE INDEX idx_effectiveness ON $TABLE_EFFECTIVENESS USING btree(attacker,defender);


-------------------------------------------------------------------------------
COMMIT;
_EOS_
)

echo "${SQL}" | ${PSQL_COMMAND}
exit 0;





DAMMY=$(cat << _EOS_












-------------------------------------------------------------------------------
-- sidefiles










-- Pokemon not yet implemented
-- 385,null,"JIRACHI"
-- 386,34,"DEOXYS_ATTACK"
drop table if exists $TABLE_POKEMON_NOT_YET CASCADE;
create table if not exists $TABLE_POKEMON_NOT_YET(
    pokemon_id text,
    form_id text,
    uid text
);
\copy $TABLE_POKEMON_NOT_YET(pokemon_id, form_id, uid) from '$FILE_POKEMON_NOT_YET' with CSV delimiter ',' NULL 'null';
-- SPECIAL treats for NIDORAN
UPDATE $TABLE_POKEMON_NOT_YET set uid='NIDORAN_F' where pokemon_id='29' and uid='NIDORAN';
UPDATE $TABLE_POKEMON_NOT_YET set uid='NIDORAN_M' where pokemon_id='32' and uid='NIDORAN';




-------------------------------------------------------------------------------
-- main tables

-- pokemon stats
drop table if exists $TABLE_POKEMON CASCADE;
create table if not exists $TABLE_POKEMON as (
    select
        to_number(B.pokemon_id,'999') as index,
        B.uid, 
        C1.uid as type_1,
        C2.uid as type_2,
        B.hp, B.at, B.df,
        (D.uid is null)::boolean as available
    from $TABLE_FORM_RAW A 
    join $TABLE_POKEMON B on B.pokemon_id=A.pokemon_id and coalesce(B.form_id,'') = coalesce(A.form_id,'') 
    join $TABLE_TYPE_RAW C1 on C1.index=B.type_1
    left join $TABLE_TYPE_RAW C2 on C2.index=B.type_2
    left join $TABLE_POKEMON_NOT_YET D on D.uid=B.uid
    order by index
);

--pokemon_fastmove_ref
drop table if exists $TABLE_POKEMON_FASTMOVE CASCADE;
create table if not exists $TABLE_POKEMON_FASTMOVE as (
    select
        to_number(A.pokemon_id, '999') as index, 
        B.uid as pokemon_uid,
        C.uid as move_uid, 
        D.uid as type, 
        C.power, C.duration, C.energy, C.damage_window_start, B.legacy
    from $TABLE_FORM_RAW A 
    join $TABLE_MON_FAST_RAW B on B.pokemon_id=A.pokemon_id and coalesce(B.form_id,'') = coalesce(A.form_id,'')
    join $TABLE_FASTMOVE_RAW C on C.index=B.move
    join $TABLE_TYPE_RAW D on D.index=C.type
    order by index
);
--pokemon_fastmove_ref for combat
drop table if exists $TABLE_POKEMON_FASTMOVE_COMBAT CASCADE;
create table if not exists $TABLE_POKEMON_FASTMOVE_COMBAT as (
    select
        to_number(A.pokemon_id, '999') as index, 
        B.uid as pokemon_uid,
        C.uid as move_uid, 
        D.uid as type, 
        C.power, C.duration, C.energy, B.legacy
    from $TABLE_FORM_RAW A 
    join $TABLE_MON_FAST_RAW B on B.pokemon_id=A.pokemon_id and coalesce(B.form_id,'') = coalesce(A.form_id,'')
    join $TABLE_FASTMOVE_COMBAT_RAW C on C.index=B.move
    join $TABLE_TYPE_RAW D on D.index=C.type
    order by index
);
-- special treats for HIDDEN_POWER
create temporary table hidden_power as select * from $TABLE_POKEMON_FASTMOVE_COMBAT where move_uid='HIDDEN_POWER';
update hidden_power set type='FIGHTING';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='FLYING';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='POISON';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='GROUND';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='ROCK';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='BUG';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='GHOST';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='STEEL';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='FIRE';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='WATER';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='GRASS';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='ELECTRIC';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='PSYCHIC';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='ICE';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='DARK';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
update hidden_power set type='DRAGON';
insert into $TABLE_POKEMON_FASTMOVE_COMBAT select * from hidden_power;
delete from $TABLE_POKEMON_FASTMOVE_COMBAT where move_uid='HIDDEN_POWER' and type='NORMAL';


--pokemon_chargemove_ref
drop table if exists $TABLE_POKEMON_CHARGEMOVE CASCADE;
create table if not exists $TABLE_POKEMON_CHARGEMOVE as (
    select
        to_number(A.pokemon_id, '999') as index, 
        B.uid as pokemon_uid,
        C.uid as move_uid, 
        D.uid as type,
        C.power, C.duration, C.energy, C.damage_window_start, B.legacy
    from $TABLE_FORM_RAW A 
    join $TABLE_MON_CHARGE_RAW B on B.pokemon_id=A.pokemon_id and coalesce(B.form_id,'') = coalesce(A.form_id,'')
    join $TABLE_CHARGEMOVE_RAW C on C.index=B.move
    join $TABLE_TYPE_RAW D on D.index=C.type
    order by index
);
--pokemon_chargemove_ref for combat
drop table if exists $TABLE_POKEMON_CHARGEMOVE_COMBAT CASCADE;
create table if not exists $TABLE_POKEMON_CHARGEMOVE_COMBAT as (
    select
        to_number(A.pokemon_id, '999') as index, 
        B.uid as pokemon_uid,
        C.uid as move_uid, 
        D.uid as type,
        C.power, C.energy, B.legacy
    from $TABLE_FORM_RAW A 
    join $TABLE_MON_CHARGE_RAW B on B.pokemon_id=A.pokemon_id and coalesce(B.form_id,'') = coalesce(A.form_id,'')
    join $TABLE_CHARGEMOVE_COMBAT_RAW C on C.index=B.move
    join $TABLE_TYPE_RAW D on D.index=C.type
    order by index
);

-- Type effectiveness table(using type uid)
drop table if exists $TABLE_EFFECTIVENESS;
create table if not exists $TABLE_EFFECTIVENESS as (
    select 
        B.uid as attacker, 
        C.uid as defender, 
        A.mlp 
    from _effectiveness A 
    join $TABLE_TYPE_RAW B on B.index=A.attacker 
    join $TABLE_TYPE_RAW C on C.index=A.defender
);


-- all possible pokemon patterns
-- EXCEPT Purified(follow Shadow)
drop table if exists $TABLE_POKEMON_PATTERN;
create table if not exists $TABLE_POKEMON_PATTERN as(
select
    A.index, A.uid as pokemon_uid,
    A.type_1,A.type_2,
    B.move_uid as f_uid, B.type as f_type, B.power as f_pow, 
    B.duration::numeric / 1000 as f_dur, 
    B.damage_window_start::numeric / 1000 as f_ini, 
    B.energy as f_ene, B.legacy as f_leg,
    (case when B.type=A.type_1 or B.type=A.type_2 then true else false end) as f_STAB,
    (case when B.type=A.type_1 or B.type=A.type_2 then 1.2 else 1.0 end) * (case when B.power is null then 0 else B.power end) as f_STAB_pow,
    C.move_uid as c_uid, C.type as c_type, C.power as c_pow, 
    C.damage_window_start::numeric / 1000 as c_ini, 
    C.duration::numeric / 1000 as c_dur, 
    C.energy as c_ene, C.legacy as c_leg,
    (case when C.type=A.type_1 or C.type=A.type_2 then true else false end) as c_STAB,
    (case when C.type=A.type_1 or C.type=A.type_2 then 1.2 else 1.0 end) * (case when C.power is null then 0 else C.power end) as c_STAB_pow
from $TABLE_POKEMON A 
join $TABLE_POKEMON_FASTMOVE B on B.pokemon_uid=A.uid and B.index=A.index
join $TABLE_POKEMON_CHARGEMOVE C on C.pokemon_uid=A.uid and C.index=A.index
where true
and A.uid !~ '_PURIFIED$'
--and A.uid !~ '_SHADOW'
);


-- all possible pokemon patterns for combat
-- EXCEPT Purified(follow Shadow)
drop table if exists $TABLE_POKEMON_PATTERN_COMBAT;
create table if not exists $TABLE_POKEMON_PATTERN_COMBAT as(
select
    A.index, A.uid as pokemon_uid,
    A.type_1,A.type_2,
    B.move_uid as f_uid, B.type as f_type, B.power as f_pow, 
    (B.duration + 1)::numeric * 0.5 as f_dur, 
    B.energy as f_ene, B.legacy as f_leg,
    (case when B.type=A.type_1 or B.type=A.type_2 then true else false end) as f_STAB,
    (case when B.type=A.type_1 or B.type=A.type_2 then 1.2 else 1.0 end) * (case when B.power is null then 0 else B.power end) as f_STAB_pow,
    C.move_uid as c_uid, C.type as c_type, C.power as c_pow, 
    C.energy as c_ene, C.legacy as c_leg,
    (case when C.type=A.type_1 or C.type=A.type_2 then true else false end) as c_STAB,
    (case when C.type=A.type_1 or C.type=A.type_2 then 1.2 else 1.0 end) * (case when C.power is null then 0 else C.power end) as c_STAB_pow
from $TABLE_POKEMON A 
join $TABLE_POKEMON_FASTMOVE_COMBAT B on B.pokemon_uid=A.uid and B.index=A.index
join $TABLE_POKEMON_CHARGEMOVE_COMBAT C on C.pokemon_uid=A.uid and C.index=A.index
where true
--and A.available=true 
and A.uid not in ('DITTO', 'SHEDINJA')
and A.uid !~ '_PURIFIED$'
--and A.uid !~ '_SHADOW'
);


-- resistance exploded
--drop table if exists $TABLE_RESISTANCE;
--create table if not exists $TABLE_RESISTANCE as(
--select 
--    A.uid as move_type,
--    B.uid as pokemon_type1,
--    C.uid as pokemon_type2,
--    calc_weakness(A.uid,B.uid,C.uid) as mlp 
--from _type A 
--join _type B on true 
--join (select uid from _type union select null)C on true
--);


-------------------------------------------------------------------------------
-- indexes



DROP INDEX if exists idx_pokemon_pattern_combat;
CREATE INDEX idx_pokemon_pattern_combat ON $TABLE_POKEMON_PATTERN_COMBAT USING btree (pokemon_uid, f_uid, c_uid);







-------------------------------------------------------------------------------
-- functions





drop function if exists get_resistance(TEXT, TEXT, TEXT);
create or replace function get_resistance(_move_type TEXT, _pokemon_type1 TEXT, _pokemon_type2 TEXT)
returns NUMERIC as'
DECLARE
    res record;
BEGIN
    select * into res from resistance where move_type=_move_type and pokemon_type1=_pokemon_type1 and pokemon_type2=_pokemon_type2;
    return res.mlp;
END
' LANGUAGE 'plpgsql';















-- select * from calc_evolve_border('サーナイト,キルリア,2500');
--  title | to_cp | from_cp | lvl  | hpiv | ativ | dfiv | rank 
-- -------+-------+---------+------+------+------+------+------
--  min   |  2483 |     690 | 34.5 |    1 |    0 |    0 | D
--  max   |  2498 |     778 | 28.5 |   12 |   15 |   15 | A
drop function if exists calc_evolve_border(condition TEXT);
create or replace function calc_evolve_border(condition TEXT)
returns table(
    title text,
    to_cp integer, 
    from_cp integer,
    lvl numeric,
    hpiv integer,
    ativ integer,
    dfiv integer,
    rank text
) as'
DECLARE
    temp text[];
    to_uid TEXT;
    from_uid TEXT;
    cap_cp INTEGER;
BEGIN
    temp := string_to_array(condition,'','');
    to_uid := puid(temp[1]);
    from_uid := puid(temp[2]);
    cap_cp := temp[3];
    return query 
        With A as(
            select * from calc_all_IV_pattern(to_uid,cap_cp)
        ), B as(
            select
                A.*,
                (floor((B.at+A.at) * (sqrt(B.df+A.df)) * (sqrt(B.hp+A.hp)) * (c.mlp * c.mlp) / 10))::INTEGER as _from_cp
            from A
            join pokemon B on B.uid=from_uid
            join cpm C on C.lv=A.lv
        )
        select ''min'', cp, _from_cp, lv, hp, at, df, overall from B order by _from_cp limit 1;

    return query 
        With A as(
            select * from calc_all_IV_pattern(to_uid,cap_cp)
        ), B as(
            select
                A.*,
                (floor((B.at+A.at) * (sqrt(B.df+A.df)) * (sqrt(B.hp+A.hp)) * (c.mlp * c.mlp) / 10))::INTEGER as _from_cp
            from A
            join pokemon B on B.uid=from_uid
            join cpm C on C.lv=A.lv
        )
        select ''max'', cp, _from_cp, lv, hp, at, df, overall from B order by _from_cp desc limit 1;

    return;
END
' LANGUAGE 'plpgsql';







-- calc killtime
-- 243,"COUNTER",2,12,900,8,700,900
-- 246,"DYNAMIC_PUNCH",2,90,2700,50,1200,2700
-- select * from test(200, 12, 'COUNTER', 90, 'DYNAMIC_PUNCH');
drop function if exists calc_killtime(
    hpt numeric, f_dmg numeric, f_uid text, c_dmg numeric, c_uid text
);
create or replace function calc_killtime(
    hpt numeric, f_dmg numeric, f_uid text, c_dmg numeric, c_uid text
)
returns numeric as '
DECLARE
    fast record;
    charge record;
    time numeric := 0;
    gained integer := 0;
    turn int:=1;
BEGIN
    select * into fast from $TABLE_FASTMOVE_RAW F where F.uid=f_uid; 
    select * into charge from $TABLE_CHARGEMOVE_RAW C where C.uid=c_uid; 
    LOOP
        -- FAST move
        hpt := hpt - f_dmg;
        time := time + fast.damage_window_start;
        IF hpt <= 0 THEN
--RAISE INFO ''#% fastmove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            EXIT;
        END IF;
        time := time + (fast.duration - fast.damage_window_start);
        gained := gained + fast.energy;
        IF gained > 100 THEN 
            gained := 100;
        END IF;

        -- CHARGE move
        IF gained >= charge.energy THEN
--RAISE INFO ''#% fastmove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            gained := gained - charge.energy;
            hpt := hpt - c_dmg;
            time := time + charge.damage_window_start;
            IF hpt <= 0 THEN
--RAISE INFO ''#% chargemove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
                EXIT;
            END IF;
            time := time + (charge.duration - charge.damage_window_start);
--RAISE INFO ''#% chargemove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            turn := turn + 1;
        END IF;
    END LOOP;
return ROUND(time / 1000, 1);
END
' LANGUAGE 'plpgsql';


-- calc killtime for combat
-- (Target HP, Fastmove Damage, Fastmove ID, Fastmove Ene, Fastmove Duration,
--  Chargemove Damage, Chargemove ID, Chargemove Ene, barrier_left int)
-- 243,"COUNTER",2,12,900,8,700,900
-- 246,"DYNAMIC_PUNCH",2,90,2700,50,1200,2700
-- select * from test(200, 12, 'COUNTER', 90, 'DYNAMIC_PUNCH');
drop function if exists calc_killtime_combat(
    hpt numeric, f_dmg numeric, f_ene numeric, f_dur numeric, c_dmg numeric, c_ene numeric, barrier_left int
);
create or replace function calc_killtime_combat(
    hpt numeric, f_dmg numeric, f_ene numeric, f_dur numeric, c_dmg numeric, c_ene numeric, barrier_left int
)
returns numeric as '
DECLARE
    time numeric := 0;
    gained integer := 0;
    turn int:=1;
BEGIN
    LOOP
        -- FAST move
        hpt := hpt - f_dmg;
        time := time + f_dur;
        IF hpt <= 0 THEN
--RAISE INFO ''#% fastmove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            EXIT;
        END IF;
        gained := gained + f_ene;
        IF gained > 100 THEN 
            gained := 100;
        END IF;

        -- CHARGE move
        IF gained >= c_ene THEN
--RAISE INFO ''#% fastmove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            gained := gained - c_ene;
            IF barrier_left > 0 THEN
                barrier_left := barrier_left - 1;
            ELSE
                hpt := hpt - c_dmg;
            END IF;
            IF hpt <= 0 THEN
--RAISE INFO ''#% chargemove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
                EXIT;
            END IF;
--RAISE INFO ''#% chargemove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            turn := turn + 1;
        END IF;
    END LOOP;
return ROUND(time, 1);
END
' LANGUAGE 'plpgsql';




-- calc counter
-- [usage]
-- [counter with opponent move type] 
-- select * from calc_counter('RAYQUAZA',2500,15,15,15,'FLYING') order by firepower desc;
-- [general ranking for specific type]
-- select * from calc_counter(null, 1500,15,15,15,null) where (type_1='FIRE' or type_2='FIRE') order by dps desc;
-- [general ranking for specific move type]
-- select * from calc_counter(null, 1500,15,15,15,null) where (c_type='ELECTRIC') order by dps desc;

drop function if exists calc_counter(opponent_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer, opponent_move_type TEXT);
create or replace function calc_counter(opponent_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer, opponent_move_type TEXT)
returns table(
    index numeric, uid text, jp text, type_1 text, type_2 text, cp integer, lv numeric, hpt integer,  atk numeric, def numeric, 
    Lf text, fastmove text, f_type text, f_dps numeric, 
--    f_dmg numeric, f_dur numeric, f_ini numeric, f_ene integer, f_stab_pow numeric, f_eff numeric,
    Lc text, chargemove text, c_type text, c_dps numeric,  
--    c_dmg numeric,c_dur numeric, c_ini numeric, c_ene integer, c_stab_pow numeric, c_eff numeric,
    dps numeric, 
    killtime numeric,
--    AC numeric, 
    dps_T numeric
--    , AC_T numeric
) as '
DECLARE
    opponent record;
    opponent_type_1 TEXT := null;
    opponent_type_2 TEXT := null;
    opponent_atk NUMERIC := 1.0;
    opponent_def NUMERIC := 1.0;
    opponent_hpt NUMERIC := 1.0;
BEGIN
    select * into opponent from $TABLE_POKEMON P, calc_all(opponent_uid,cap_cp,HPIV,ATIV,DFIV) Q where P.uid=opponent_uid;
    IF opponent.uid is not null THEN
        opponent_type_1 = opponent.type_1;
        opponent_type_2 = opponent.type_2;
        opponent_atk = opponent.atk;
        opponent_def = opponent.def;
        opponent_hpt = opponent.hpt;
RAISE INFO ''Opponent: % - ATK:% DEF:% HPT:%'', opponent_uid, opponent_atk, opponent_def, opponent_hpt;
    END IF;
return query 
With
-- fetch master pokemon data(implemented pokemon only)
Q as (
    select 
        A.index, A.uid, A.type_1, A.type_2, 
        B.cp, B.lv, B.atk, B.def, B.hpt
    from $TABLE_POKEMON A, calc_all(A.uid,cap_cp,HPIV,ATIV,DFIV) as B
    where A.available = true
),
-- join moveset pattens and calc effectiveness, chargetime
R1 as (
    select 
        Q.*, 
        R.f_uid, R.f_type, R.f_ene, R.f_dur, R.f_ini, R.f_stab_pow, R.f_leg,
        R.c_uid, R.c_type,R.c_ene, R.c_dur, R.c_ini, R.c_stab_pow, R.c_leg,
        R.c_ene::NUMERIC / R.f_ene::NUMERIC as chargetime,
        calc_weakness(R.f_type, opponent_type_1, opponent_type_2) as f_eff,
        calc_weakness(R.c_type, opponent_type_1, opponent_type_2) as c_eff
    from Q
    join $TABLE_POKEMON_PATTERN R on R.pokemon_uid=Q.uid
),
-- calc damage
R2 as (
    select 
        R1.*, 
        (FLOOR(0.5 * (R1.atk::NUMERIC / opponent_def) * R1.f_stab_pow * R1.f_eff) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * (R1.atk::NUMERIC / opponent_def) * R1.c_stab_pow * R1.c_eff) + 1)::numeric as c_dmg
    from R1
),
-- calc dps and killtime
R3 as (
    select
        R2.*,
        R2.f_dmg / R2.f_dur as f_dps,
        R2.c_dmg / R2.c_dur as c_dps,
        calc_killtime(opponent_hpt, R2.f_dmg, R2.f_uid, R2.c_dmg, R2.c_uid) as killtime
    from R2
),
-- calc total dps
S as (
    select
        R3.*,
        (case 
            when R3.f_ene is null then 0 
            else (R3.f_dps * R3.chargetime + R3.c_dps * R3.c_dur) / (R3.chargetime + R3.c_dur)
        end) as dps
    from R3
),
T_DPS as (
    select
        avg(S.dps) as avg,
        stddev(S.dps) as stdrd
    from S
)
--, T_AC as (
--    select
--        avg(S.AC) as avg,
--        stddev(S.AC) as stdrd
--    from S
--) 
select
    S.index, S.uid, LP.jp, S.type_1, S.type_2, S.cp, S.lv, S.atk, S.def, S.hpt, 
    (case when S.f_leg = true then ''▲'' else null end), 
    LF.jp, S.f_type, round(S.f_dps, 1),
--    S.f_dmg, round(S.f_dur,1), round(S.f_ini,1), S.f_ene, S.f_stab_pow, round(S.f_eff,1),
    (case when S.c_leg = true then ''▲'' else null end), 
    LC.jp, S.c_type, round(S.c_dps, 1),
--    S.c_dmg,round(S.c_dur,1), round(S.c_ini,1), S.c_ene, S.c_stab_pow, round(S.c_eff,1),
    round(S.dps, 1), 
    S.killtime,
--    ROUND(S.AC, 2),
    ROUND((S.dps - T_DPS.avg) / T_DPS.stdrd * 10 + 50, 1)
--    ,ROUND((S.AC - T_AC.avg) / T_AC.stdrd * 10 + 50, 1)
from S
join $TABLE_LOCALIZE_POKEMON LP on LP.uid=S.uid
join $TABLE_LOCALIZE_FASTMOVE LF on LF.uid=S.f_uid
join $TABLE_LOCALIZE_CHARGEMOVE LC on LC.uid=S.c_uid
join T_DPS on true
--join T_AC on true
;
return;
END
' LANGUAGE 'plpgsql';



-------------------------------------------------------------------------------
-- calc counter for combat
-- [usage]
-- select * from calc_counter_combat('パルキア',5500,15,15,15,'DRAGON_BREATH','FIRE_BLAST');
drop function if exists calc_counter_combat(opponent_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer, opponent_fastmove TEXT, opponent_chargemove TEXT, player_uid TEXT, player_fastmove TEXT, player_chargemove TEXT);
create or replace function calc_counter_combat(opponent_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer, opponent_fastmove TEXT, opponent_chargemove TEXT, player_uid TEXT, player_fastmove TEXT, player_chargemove TEXT)
returns table(
-- pokemon
    index numeric, 
    uid text, 
    jp text, 
    type_1 text, 
    type_2 text, 
    cp integer, 
    lv numeric, 
    atk numeric, 
    def numeric, 
    hpt integer, 
-- fastmove
    Lf text, 
    f_uid text,
    fastmove text, 
    f_type text, 
    f_dmg numeric,
    f_ene integer, 
    f_dur numeric, 
-- chargemove
    Lc text, 
    c_uid text,
    chargemove text, 
    c_type text, 
    c_dmg numeric, 
    c_ene integer, 
-- one cycle
    f_x integer,
    dps numeric, 
    kill numeric,
    death numeric,
    kill_b numeric,
    death_b numeric,

    fdpsp numeric, -- fastmove DPS(%) 
    ofdpsp numeric, -- opponent fastmove DPS(%)
    cdp numeric, -- chargemove Damage(%)
    ocdp numeric, -- opponent chargemove Damage(%)

    sec2chg numeric, -- sec to charge
    o_sec2chg numeric -- opponent sec to charge
) as '
DECLARE
    opponent record;
    opponent_type_1 TEXT := null;
    opponent_type_2 TEXT := null;
    opponent_atk NUMERIC := 100.0;
    opponent_def NUMERIC := 100.0;
    opponent_hpt NUMERIC := 100.0;
    opponent_f_stab_pow NUMERIC := 10;
    opponent_c_stab_pow NUMERIC := 100;
    opponent_f_type TEXT := ''NORMAL'';
    opponent_c_type TEXT := ''NORMAL'';
    opponent_f_dur NUMERIC := 1.0;
    opponent_move_type TEXT := opponent_f_type;
    opponent_c_ene NUMERIC := 1.0;
    opponent_f_ene NUMERIC := 1.0;
BEGIN
    -- follow JP
    select get_pokemon_uid(opponent_uid) into opponent_uid;
    select get_move_uid(opponent_fastmove) into opponent_fastmove;
    select get_move_uid(opponent_chargemove) into opponent_chargemove;
    select get_pokemon_uid(player_uid) into player_uid;
    select get_move_uid(player_fastmove) into player_fastmove;
    select get_move_uid(player_chargemove) into player_chargemove;

    select * into opponent from $TABLE_POKEMON P, calc_all(opponent_uid,cap_cp,HPIV,ATIV,DFIV) Q where P.uid=opponent_uid;
    IF opponent.uid is not null THEN
        opponent_type_1 := opponent.type_1;
        opponent_type_2 := opponent.type_2;
        opponent_atk := opponent.atk;
        opponent_def := opponent.def;
        opponent_hpt := opponent.hpt;

        IF opponent_uid is not null and opponent_fastmove is not null and opponent_chargemove is not null THEN
            select * into opponent from $TABLE_POKEMON_PATTERN_COMBAT P where P.pokemon_uid=opponent_uid and P.f_uid=opponent_fastmove and P.c_uid=opponent_chargemove;
            opponent_f_stab_pow := opponent.f_stab_pow;
            opponent_c_stab_pow := opponent.c_stab_pow;
            opponent_f_type := opponent.f_type;
            opponent_c_type := opponent.c_type;
            opponent_f_dur := opponent.f_dur;
            opponent_f_ene := opponent.f_ene;
            opponent_c_ene := opponent.c_ene;
        END IF;

RAISE INFO ''Opponent: % - ATK:% DEF:% HPT:% % / %'', opponent_uid, opponent_atk, opponent_def, opponent_hpt, opponent_fastmove, opponent_chargemove;
    ELSE
        null;
RAISE INFO ''Opponent: null - just for calculating general dps'' ;
    END IF;
return query 
With
-- fetch master pokemon data(implemented pokemon only)
Q as (
    select 
        A.index, A.uid, A.type_1, A.type_2, 
        B.cp, B.lv, B.atk, B.def, B.hpt
    from $TABLE_POKEMON A, calc_all(A.uid,cap_cp,HPIV,ATIV,DFIV) as B
    where A.available = true 
    and (case when player_uid is not null then A.uid=player_uid else true end)
),
-- join moveset pattens and calc effectiveness, chargetime and opponent moves effectiveness
R1 as (
    select 
        Q.*, 
        R.f_uid, R.f_type, R.f_ene, R.f_dur, R.f_stab_pow, R.f_leg,
        R.c_uid, R.c_type,R.c_ene, R.c_stab_pow, R.c_leg,
        R.c_ene::NUMERIC / R.f_ene::NUMERIC as chargetime,
        -- use get_resistance instead calc_weakness
--        get_resistance(R.f_type, opponent_type_1, opponent_type_2) as f_eff,
--        get_resistance(R.c_type, opponent_type_1, opponent_type_2) as c_eff,
--        get_resistance(opponent_f_type, Q.type_1, Q.type_2) as opponent_f_eff,
--        get_resistance(opponent_c_type, Q.type_1, Q.type_2) as opponent_c_eff
        calc_weakness(R.f_type, opponent_type_1, opponent_type_2) as f_eff,
        calc_weakness(R.c_type, opponent_type_1, opponent_type_2) as c_eff,
        calc_weakness(opponent_f_type, Q.type_1, Q.type_2) as opponent_f_eff,
        calc_weakness(opponent_c_type, Q.type_1, Q.type_2) as opponent_c_eff
    from Q
    join $TABLE_POKEMON_PATTERN_COMBAT R on R.pokemon_uid=Q.uid
    where (case when player_uid is not null then R.pokemon_uid=player_uid else true end)
    and (case when player_fastmove is not null then R.f_uid=player_fastmove else true end)
    and (case when player_chargemove is not null then R.c_uid=player_chargemove else true end)
),
-- calc damages
R2 as (
    select 
        R1.*, 
        (FLOOR(0.5 * ROUND(R1.atk::NUMERIC / opponent_def, 2) * R1.f_stab_pow * R1.f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(R1.atk::NUMERIC / opponent_def, 2) * R1.c_stab_pow * R1.c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / R1.def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / R1.def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from R1
),
-- calc dps and killtime
R3 as (
    select
        R2.*,
        R2.f_dmg / R2.f_dur as f_dps,
        --R2.c_dmg / R2.c_dur as c_dps,
        calc_killtime_combat(opponent_hpt, R2.f_dmg, R2.f_uid, R2.c_dmg, R2.c_uid, 0) as killtime,
        calc_killtime_combat(
            R2.hpt, 
            opponent_f_dmg,
            opponent_fastmove,
            opponent_c_dmg,
            opponent_chargemove,
            0
        )as deathtime,
        calc_killtime_combat(opponent_hpt, R2.f_dmg, R2.f_uid, R2.c_dmg, R2.c_uid, 2) as killtime_b,
        calc_killtime_combat(
            R2.hpt, 
            opponent_f_dmg,
            opponent_fastmove,
            opponent_c_dmg,
            opponent_chargemove,
            2
        )as deathtime_b
    from R2
),
-- calc total dps
S as (
    select
        R3.*,
        (case 
            when R3.f_ene is null then 0 
            else (R3.f_dps * R3.chargetime + R3.c_dmg) / (R3.chargetime * R3.f_dur)
        end) as dps,
        Ceil(R3.chargetime) * R3.f_dmg + R3.c_dmg as cycle_dmg,
        Ceil(R3.chargetime) * R3.f_dur as cycle_time
    from R3
),
T_DPS as (
    select
        avg(S.dps) as avg,
        stddev(S.dps) as stdrd
    from S
)
select
-- pokemon
    S.index, 
    S.uid, 
    LP.jp, 
    S.type_1, 
    S.type_2, 
    S.cp, 
    S.lv, 
    S.hpt, 
    S.atk, 
    S.def, 
-- fastmove
    (case when S.f_leg = true then ''▲'' else null end), 
    S.f_uid,
    LF.jp, 
    S.f_type, 
    S.f_dmg, 
    S.f_ene, 
    S.f_dur,
-- chargemove
    (case when S.c_leg = true then ''▲'' else null end), 
    S.c_uid,
    LC.jp, 
    S.c_type, 
    S.c_dmg, 
    S.c_ene, 
-- one cycle
    Ceil(S.chargetime)::INTEGER,
    round(S.dps, 1), 
    S.killtime,
    S.deathtime,
    S.killtime_b,
    S.deathtime_b,

    Round(S.f_dps / opponent_hpt, 3),
    Round((opponent_f_dmg / S.hpt) / opponent_f_dur, 3),
    Round(S.c_dmg / opponent_hpt, 3),
    Round(opponent_c_dmg / S.hpt, 3)
    ,ceil(S.c_ene::numeric / S.f_ene) * S.f_dur   -- as sec2chg
    ,ceil(opponent_c_ene::numeric / opponent_f_ene) * opponent_f_dur    -- as o_sec2chg
from S
join $TABLE_LOCALIZE_POKEMON LP on LP.uid=S.uid
join $TABLE_LOCALIZE_FASTMOVE LF on LF.uid=S.f_uid
join $TABLE_LOCALIZE_CHARGEMOVE LC on LC.uid=S.c_uid
join T_DPS on true
;
return;
END
' LANGUAGE 'plpgsql';



-- for simple query without specifying player pokemon
drop function if exists calc_counter_combat(opponent_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer, opponent_fastmove TEXT, opponent_chargemove TEXT);
create or replace function calc_counter_combat(opponent_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer, opponent_fastmove TEXT, opponent_chargemove TEXT)
returns table(
-- pokemon
    index numeric, 
    uid text, 
    jp text, 
    type_1 text, 
    type_2 text, 
    cp integer, 
    lv numeric, 
    hpt integer, 
    atk numeric, 
    def numeric, 
-- fastmove
    Lf text, 
    f_uid text,
    fastmove text, 
    f_type text, 
    f_dmg numeric,
    f_ene integer, 
    f_dur numeric, 
-- chargemove
    Lc text, 
    c_uid text,
    chargemove text, 
    c_type text, 
    c_dmg numeric, 
    c_ene integer, 
-- one cycle
    f_x integer,
    dps numeric, 
    kill numeric,
    death numeric,
    kill_b numeric,
    death_b numeric,

    fdpsp numeric, -- fastmove DPS(%) 
    ofdpsp numeric, -- opponent fastmove DPS(%)
    cdp numeric, -- chargemove Damage(%)
    ocdp numeric, -- opponent chargemove Damage(%)

    sec2chg numeric, -- sec to charge
    o_sec2chg numeric -- opponent sec to charge
) as '
BEGIN
    return query select * from calc_counter_combat(opponent_uid, cap_cp, HPIV, ATIV, DFIV, opponent_fastmove, opponent_chargemove, null, null, null);
    return;
END
' LANGUAGE 'plpgsql';



-------------------------------------------------------------------------------
-- calculate all win(kill < death) and lose(kill>death) patterns
-- [usage] heavy query - basically make static table
-- BEGIN;
-- drop table if exists win_lose;
-- create table win_lose as (select * from count_win_lose_pattern(5500));
-- COMMIT;
-- 

-- 
-- BEGIN;
-- insert into win_lose select * from count_win_lose_pattern(1500);
-- COMMIT;
--
drop function if exists count_win_lose_pattern(CAP_CP INTEGER);
create or replace function count_win_lose_pattern(CAP_CP INTEGER)
returns TABLE(
    pokemon TEXT,
    fastmove TEXT,
    chargemove TEXT,
    CAP INTEGER,
    win INTEGER,
    lose INTEGER,
    win_unique INTEGER,
    lose_unique INTEGER
) as'
DECLARE
    pattern record;
    total integer;
    total_unique integer;
    cnt integer := 1;
BEGIN
    select count(*) into total from $TABLE_POKEMON_PATTERN_COMBAT;
    select count(distinct pokemon_uid) into total_unique from $TABLE_POKEMON_PATTERN_COMBAT;
    for pattern in select * from $TABLE_POKEMON_PATTERN_COMBAT loop
        raise INFO ''% / %'', cnt, total;
        return query
            select 
                pattern.pokemon_uid, 
                pattern.f_uid, 
                pattern.c_uid, 
                CAP_CP,
                count(*)::INTEGER,
                (total-count(*))::INTEGER,
                count(distinct uid)::INTEGER,
                (total_unique-count(distinct uid))::INTEGER
            from calc_counter_combat(pattern.pokemon_uid,CAP_CP,15,15,15,pattern.f_uid,pattern.c_uid)
            where kill<death and kill_b<death_b;
        cnt := cnt + 1;
        --IF cnt=3
        --    THEN exit;
        --END IF;
    end loop;
    RETURN;
END
' LANGUAGE 'plpgsql';






-- markup TYPE text for HUGO
-- usage: type_markup('ICE')
-- returns: {{< type ICE >}}
drop function if exists type_markup(type_uid TEXT);
create or replace function type_markup(type_uid TEXT)
returns TEXT as '
BEGIN
    RETURN ''{{< type '' || type_uid || '' >}}'';
END
' LANGUAGE 'plpgsql';






drop function if exists stats_minmax(_statsanalysis TEXT);
create or replace function stats_minmax(_statsanalysis TEXT)
returns table (min INTEGER, max INTEGER) as '
BEGIN
    case
        when UPPER(_statsanalysis) ~ ''A'' then return query select 15, 15;
        when UPPER(_statsanalysis) ~ ''B'' then return query select 13, 14;
        when UPPER(_statsanalysis) ~ ''C'' then return query select 8, 12;
        else return query select 0, 7;
    end case;
    return;
END
' LANGUAGE 'plpgsql';

drop function if exists overall_minmax(_overall TEXT);
create or replace function overall_minmax(_overall TEXT)
returns table (min INTEGER, max INTEGER) as '
BEGIN
    case
        when UPPER(_overall) ~ ''A'' then return query select 37, 45;
        when UPPER(_overall) ~ ''B'' then return query select 30, 36;
        when UPPER(_overall) ~ ''C'' then return query select 23, 29;
        else return query select 0, 22;
    end case;
    return;
END
' LANGUAGE 'plpgsql';



drop function if exists puid(name text);
create or replace function puid(name text)
returns text as '
DECLARE
    temp text;
BEGIN
    select * into temp from get_pokemon_uid(name);
    return temp;
END
' LANGUAGE 'plpgsql';

drop function if exists get_pokemon_uid(name text);
create or replace function get_pokemon_uid(name text)
returns text as '
DECLARE
    temp record;
BEGIN
    IF name ~ ''^\w+$'' THEN
        select * into temp from $TABLE_LOCALIZE_POKEMON where uid=UPPER(name);
        --select * into temp from $TABLE_LOCALIZE_POKEMON where uid=UPPER(case when position(''_'' in name)>0 then concat(substring(name for position(''_'' in name)),''NORMAL'') else name end);
    ELSE
        select * into temp from $TABLE_LOCALIZE_POKEMON where jp=name;
    END IF;
    return temp.uid;
END
' LANGUAGE 'plpgsql';


drop function if exists get_move_uid(name text);
create or replace function get_move_uid(name text)
returns text as '
DECLARE
    temp record;
BEGIN
    IF name ~ ''^\w+$'' THEN
        select * into temp from $TABLE_LOCALIZE_FASTMOVE where uid=UPPER(name)
        union select * from $TABLE_LOCALIZE_CHARGEMOVE where uid=UPPER(name);
    ELSE
        select * into temp from $TABLE_LOCALIZE_FASTMOVE where jp=name
        union select * from $TABLE_LOCALIZE_CHARGEMOVE where jp=name;
    END IF;
    return temp.uid;
END
' LANGUAGE 'plpgsql';


-- calculate pokemon IV 
-- shortcut for convenience
-- e.g. select * from calc_iv('メルタン,344,65,1600,d,ad,d,メルメタル');
drop function if exists calc_iv(text);
create or replace function calc_iv(condition TEXT)
returns table(lv NUMERIC, hpt INTEGER, atk INTEGER, def INTEGER, total TEXT, evolved_cp INTEGER) as'
DECLARE
    temp text[];
    _pokemon TEXT;
    _cp INTEGER;
    _hp INTEGER;
    _stardust INTEGER;
    _overall TEXT;
    _beststats TEXT;
    _statsanalysis TEXT;
    _evolve TEXT;
BEGIN
    temp := string_to_array(condition,'','');
    _pokemon := get_pokemon_uid(temp[1]);
    _cp := temp[2]::integer;
    _hp := temp[3]::integer;
    _stardust := temp[4]::integer;
    _overall := temp[5];
    _beststats := temp[6];
    _statsanalysis := temp[7];
    _evolve := temp[8];
    return query select * from calc_iv(_pokemon, _cp, _hp, _stardust, _overall, _beststats, _statsanalysis, _evolve);
END
' LANGUAGE plpgsql;

drop function if exists calc_iv(_pokemon TEXT, _cp INTEGER, _hp INTEGER, _stardust INTEGER, _overall TEXT, _beststats TEXT, _statsanalysis TEXT, _evolve TEXT);
create or replace function calc_iv(_pokemon TEXT, _cp INTEGER, _hp INTEGER, _stardust INTEGER, _overall TEXT, _beststats TEXT, _statsanalysis TEXT, _evolve TEXT)
returns table(lv NUMERIC, hpt INTEGER, atk INTEGER, def INTEGER, total TEXT, evolved_cp INTEGER) as '
DECLARE
    temp record;
    f_at boolean;
    f_df boolean;
    f_hp boolean;
    min_at integer := 0;
    min_df integer := 0;
    min_hp integer := 0;
    max_at integer := 15;
    max_df integer := 15;
    max_hp integer := 15;
    min_overall integer := 0;
    max_overall integer := 45;
    pokemon record;
    evolve record;
    lvs record;
    c_lvs cursor for select A.lv,B.mlp from $TABLE_STARDUST_CANDY A join $TABLE_CPM B on B.lv=A.lv where A.stardust=_stardust;
    mlp numeric;
    hpIV integer;
    atIV integer;
    dfIV integer;
    calculatedHP integer;
    calculatedCP integer;
    evolveCP integer := 0;
BEGIN
    -- extract _beststats text into flags (e.g. ''ah'' into f_at:true, f_df:false, f_hp:true) 
    select UPPER(_beststats) ~ ''A'' into f_at;
    select UPPER(_beststats) ~ ''D'' into f_df;
    select UPPER(_beststats) ~ ''H'' into f_hp;
    select * from stats_minmax(_statsanalysis) into temp;
    IF f_at THEN 
        min_at := temp.min;
        max_at := temp.max;
    ELSE
        max_at := temp.max - 1;
    END IF;
    IF f_df THEN 
        min_df := temp.min;
        max_df := temp.max;
    ELSE
        max_df := temp.max - 1;
    END IF;
    IF f_hp THEN 
        min_hp := temp.min;
        max_hp := temp.max;
    ELSE
        max_hp := temp.max - 1;
    END IF;
    --raise NOTICE ''at:%-% df:%-% hp:%-%'', min_at,max_at, min_df,max_df, min_hp,max_hp;

    select * from overall_minmax(_overall) into temp;
    min_overall := temp.min;
    max_overall := temp.max;
    --raise NOTICE ''overall:%-%'', min_overall, max_overall;

    -- determine which pokemon
    select * into pokemon from $TABLE_POKEMON where uid=get_pokemon_uid(_pokemon);

    -- determine evolve target if exists
    IF _evolve is not null THEN
        select * into evolve from $TABLE_POKEMON where uid=get_pokemon_uid(_evolve);
    END IF;

    -- 1. guess possible LVs from stardust
    FOR lvs in c_lvs loop
        mlp := lvs.mlp;
        --raise NOTICE ''lv:% mlp:%'', lvs.lv, mlp;

        -- 1. guess HP first
        FOR hpIV in min_hp..max_hp loop
            calculatedHP = floor((pokemon.hp + hpIV) * mlp);
            IF calculatedHP = _hp THEN
                -- 2. guess AT and DF
                FOR atIV in min_at..max_at LOOP
                FOR dfIV in min_df..max_df LOOP
                    calculatedCP := floor((pokemon.at + atIV) * (sqrt(pokemon.df + dfIV)) * (sqrt(pokemon.hp + hpIV)) * (mlp * mlp) / 10);
                    --raise NOTICE ''LV:% AT:% DF:% HP:% -> CP:%'', lvs.lv, atIV, dfIV, hpIV, calculatedCP;
                    IF calculatedCP = _cp and atIV+dfIV+hpIV >= min_overall and atIV+dfIV+hpIV<= max_overall THEN
                        --raise NOTICE ''  ** MATCH ** '';
                        IF _evolve is not null THEN
                            evolveCP := floor((evolve.at + atIV) * (sqrt(evolve.df + dfIV)) * (sqrt(evolve.hp + hpIV)) * (mlp * mlp) / 10);
                        END IF;
                        return query 
                            select 
                                lvs.lv, hpIV, atIV, dfIV,  
                                upper(to_hex(hpIV)) || upper(to_hex(atIV)) || upper(to_hex(dfIV)) || ''%'' || ceil((hpIV+atIV+dfIV)*100 / 45), 
                                evolveCP;
                    END IF;
                end loop;
                end loop;
            END IF;
        end loop;
    end loop;

    return;
END
' LANGUAGE 'plpgsql';



-- calculate powerup costs
drop function if exists calc_cost(current_lv numeric, target_lv numeric, current_candy integer);
create function calc_cost(current_lv numeric, target_lv numeric, current_candy integer)
returns table (stardust integer, candy integer, achievable_lv numeric, how_many_mroe_candy integer) as '
DECLARE
    row record;
    _candy integer := 0;
    _stardust integer := 0;
    _achievable_lv numeric := -1.0;
BEGIN
    FOR row in select * from $TABLE_STARDUST_CANDY loop
        CONTINUE WHEN row.lv < current_lv;
        EXIT WHEN row.lv=target_lv;
        _candy := _candy + row.candy;
        _stardust := _stardust + row.stardust;
        --raise NOTICE '' lv:% candy:% / %'',row.lv, _candy, current_candy;
        IF (_achievable_lv < 0) and (current_candy - _candy < 0) THEN
            _achievable_lv := row.lv;
        END IF;
    end loop;
    IF _achievable_lv < 0 and current_candy >= _candy THEN
        _achievable_lv := row.lv;
    END IF;
    return query select _stardust, _candy, _achievable_lv, case when _candy > current_candy then _candy - current_candy else 0 end;
    return;
END
' LANGUAGE 'plpgsql';



-- 進化後のCPと、キャップ時に幾つになるかを計算
-- select * from calc_evo('アチャモ,バシャーモ,525,12,15,15,1500');
-- select * from calc_evo('アチャモ,バシャーモ,525,12,15,15');
--   cp  | lv | evo_cp | evo_lv 
-- ------+----+--------+--------
--  1373 | 17 |   1494 |   18.5
-- (1 row)
drop function if exists calc_evo(condition TEXT);
create or replace function calc_evo(condition TEXT)
returns table(cp integer, lv numeric, evo_cp integer, evo_lv numeric,evo_hp integer, evo_at numeric, evo_df numeric, stardust integer, candy integer) as'
DECLARE
    temp text[];
    target_uid TEXT;
    evo_uid TEXT;
    cp INTEGER;
    HPIV integer := 15;
    ATIV integer := 15;
    DFIV integer := 15;
    cap integer := 1500;
    cap_LV numeric := 41;

    calculatedCP INTEGER;
    evo_cp INTEGER;
    evo_cp_cap INTEGER;

    level NUMERIC;
    pokemon record;
    evolve record;
    lvs record;
    c_lvs cursor for select * from cpm;
    _mlp NUMERIC;
BEGIN
    temp := string_to_array(condition,'','');
    target_uid := puid(temp[1]);
    evo_uid := puid(temp[2]);
    cp := temp[3];
    HPIV := temp[4]::integer;
    ATIV := temp[5]::integer;
    DFIV := temp[6]::integer;
    IF temp[7] is not null then cap := temp[7]::integer; end if;
    IF temp[8] is not null then cap_LV := temp[8]::numeric; end if;

    select * into pokemon from pokemon where uid=get_pokemon_uid(target_uid);
    select * into evolve from pokemon where uid=get_pokemon_uid(evo_uid);

    -- calculate level
    FOR lvs in c_lvs LOOP
        _mlp := lvs.mlp;
        calculatedCP := floor((pokemon.at + ATIV) * (sqrt(pokemon.df + DFIV)) * (sqrt(pokemon.hp + HPIV)) * (_mlp * _mlp) / 10);
        IF calculatedCP = cp THEN
            level := lvs.lv;
            evo_cp := (floor((evolve.at + ATIV) * (sqrt(evolve.df + DFIV)) * (sqrt(evolve.hp + HPIV)) * (_mlp * _mlp) / 10));
            return query
                with A as (
                    select
                        (floor((evolve.at + ATIV) * (sqrt(evolve.df + DFIV)) * (sqrt(evolve.hp + HPIV)) * (A.mlp * A.mlp) / 10))::INTEGER as cp, 
                        A.lv
                    from cpm A
                    where A.lv <= cap_LV
                ) 
                , B as(
                    select evo_cp as _cp, level as _lv, A.cp as _evo_cp, A.lv as _evo_lv from A where A.cp <= cap order by A.cp desc limit 1
                )
                select 
                    B.*,
                    floor((evolve.hp+HPIV) * D.mlp)::INTEGER,
                    ((evolve.at+ATIV) * D.mlp)::NUMERIC,
                    ((evolve.df+DFIV) * D.mlp)::NUMERIC,                    
                    C.stardust, C.candy
                from B join calc_cost(B._lv, B._evo_lv, 0) C on true
                join cpm D on D.lv=B._evo_lv;
        END IF;
    END LOOP;

    return;
END
' LANGUAGE 'plpgsql';



-------------------------------------------------------------------------------
-- views

drop view if exists fastmove_combat_export;
drop view if exists chargemove_combat_export;
drop view if exists life_cp1500_IV15;
drop view if exists life_cp2500_IV15;
drop view if exists dps_cp1500_IV15;


drop view if exists weakness;
create view weakness as(
select
    A.index, B.jp, A.uid, A.type_1, A.type_2,
	calc_weakness('NORMAL',A.type_1,A.type_2) as Normal,
	calc_weakness('FIGHTING',A.type_1,A.type_2) as Fighting,
	calc_weakness('FLYING',A.type_1,A.type_2) as Flying,
	calc_weakness('POISON',A.type_1,A.type_2) as Poison,
	calc_weakness('GROUND',A.type_1,A.type_2) as Ground,
	calc_weakness('ROCK',A.type_1,A.type_2) as Rock,
	calc_weakness('BUG',A.type_1,A.type_2) as Bug,
	calc_weakness('GHOST',A.type_1,A.type_2) as Ghost,
	calc_weakness('STEEL',A.type_1,A.type_2) as Steel,
	calc_weakness('FIRE',A.type_1,A.type_2) as Fire,
	calc_weakness('WATER',A.type_1,A.type_2) as Water,
	calc_weakness('GRASS',A.type_1,A.type_2) as Grass,
	calc_weakness('ELECTRIC',A.type_1,A.type_2) as Electric,
	calc_weakness('PSYCHIC',A.type_1,A.type_2) as Psychic,
	calc_weakness('ICE',A.type_1,A.type_2) as Ice,
	calc_weakness('DRAGON',A.type_1,A.type_2) as Dragon,
	calc_weakness('DARK',A.type_1,A.type_2) as Dark,
	calc_weakness('FAIRY',A.type_1,A.type_2) as Fairy
from $TABLE_POKEMON A
join $TABLE_LOCALIZE_POKEMON B on B.uid=A.uid
);


-- query builder
drop view if exists query_counter_fast_killtime;
create view query_counter_fast_killtime as(
select concat(
    'select * , Ceil(1/fdpsp) * ofdpsp as damage from calc_counter_combat(''',
    A.pokemon_uid,
    ''',1500,15,15,15,''',
    A.f_uid,
    ''',''',
    A.c_uid,
    ''') order by kill_b/death_b, kill_b, damage, uid, dps desc limit 50; -- ',
    B.jp, ' ', C.jp, ' ', D.jp
    )
from pokemon_pattern_combat A
join localize_pokemon B on B.uid=A.pokemon_uid
join localize_fastmove C on C.uid=A.f_uid
join localize_chargemove D on D.uid=A.c_uid
order by A.index
);


drop view if exists query_counter_less_damage;
create view query_counter_less_damage as(
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
order by A.index
);

COMMIT;
_EOS_
)

echo "${SQL}" | ${PSQL_COMMAND}

# exports
#${PSQL_COMMAND} -c "select * from life_cp1500_IV15" -A -t -F $'\t' | sed '$d' > cp1500_iv15.tsv
#${PSQL_COMMAND} -c "select * from life_cp2500_IV15" -A -t -F $'\t' | sed '$d' > cp2500_iv15.tsv
#${PSQL_COMMAND} -c "select * from weakness" -A -t -F $'\t' | sed '$d' > weakness.tsv


#${PSQL_COMMAND} -c "select * from fastmove_combat_export" -A -t -F $'\t' > fastmove_combat.tsv
#${PSQL_COMMAND} -c "select * from chargemove_combat_export" -A -t -F $'\t' > chargemove_combat.tsv
##${PSQL_COMMAND} -c "select * from fastmove_combat_export" -A -t -F $'\t' | sed '$d' > fastmove_combat.tsv
##${PSQL_COMMAND} -c "select * from chargemove_combat_export" -A -t -F $'\t' | sed '$d' > chargemove_combat.tsv

#${PSQL_COMMAND} -c "select * from query_counter_fast_killtime" -A -t -F $'\t' > query_counter_fast_killtime.txt
#${PSQL_COMMAND} -c "select * from query_counter_less_damage" -A -t -F $'\t' > query_counter_less_damage.txt



exit 0;
