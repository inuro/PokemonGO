#!/bin/bash
#
#   [usage]
#   $ import2psql.sh <DB name> <game_master dir> <sidefile dir>
#   [example]
#   $ ./import2psql.sh pokemongo masterfiles sidefiles
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
PORT=5432
PSQL_COMMAND="psql -p $PORT $DB"

#files generated from GAME_MASTER
FILE_FORM=$GAMEMASTERDIR/form.csv
FILE_TYPE=$GAMEMASTERDIR/type.csv
FILE_EFFECTIVENESS=$GAMEMASTERDIR/type_effectiveness.csv
FILE_STATS=$GAMEMASTERDIR/pokemon.csv
FILE_MON_FAST=$GAMEMASTERDIR/pokemon_fastmove.csv
FILE_MON_CHARGE=$GAMEMASTERDIR/pokemon_chargemove.csv
FILE_FASTMOVE=$GAMEMASTERDIR/fastmove.csv
FILE_CHARGEMOVE=$GAMEMASTERDIR/chargemove.csv
FILE_FASTMOVE_COMBAT=$GAMEMASTERDIR/fastmove_combat.csv
FILE_CHARGEMOVE_COMBAT=$GAMEMASTERDIR/chargemove_combat.csv
#files statically prepared in sidefiles directory
FILE_LOCALIZE_POKEMON=$SIDEFILEDIR/localize_pokemon.csv
FILE_LOCALIZE_FASTMOVE=$SIDEFILEDIR/localize_fastmove.csv
FILE_LOCALIZE_CHARGEMOVE=$SIDEFILEDIR/localize_chargemove.csv
FILE_LOCALIZE_TYPE=$SIDEFILEDIR/localize_type.csv
FILE_CPM=$SIDEFILEDIR/cpmultiplier.csv
FILE_MON_FAST_LEGACY=$SIDEFILEDIR/pokemon_fastmove_legacy.csv
FILE_MON_CHARGE_LEGACY=$SIDEFILEDIR/pokemon_chargemove_legacy.csv
FILE_POKEMON_NOT_YET=$SIDEFILEDIR/pokemon_not_yet.csv
FILE_STARDUST_CANDY=$SIDEFILEDIR/stardust_candy.csv


#raw table names
TABLE_FORM_RAW=_form
TABLE_TYPE_RAW=_type
TABLE_EFFECTIVENESS_RAW=_effectiveness
TABLE_STATS_RAW=_stats
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
TABLE_POKEMON=pokemon
TABLE_POKEMON_FASTMOVE=pokemon_fastmove
TABLE_POKEMON_CHARGEMOVE=pokemon_chargemove
TABLE_POKEMON_PATTERN=pokemon_pattern
TABLE_CPM=cpm
TABLE_EFFECTIVENESS=effectiveness
TABLE_POKEMON_FASTMOVE_COMBAT=pokemon_fastmove_combat
TABLE_POKEMON_CHARGEMOVE_COMBAT=pokemon_chargemove_combat
TABLE_POKEMON_PATTERN_COMBAT=pokemon_pattern_combat

#other tables
TABLE_STARDUST_CANDY=stardust_candy
TABLE_RESISTANCE=resistance


SQL=$(cat << _EOS_
BEGIN;


-------------------------------------------------------------------------------
-- Tables from GAME_MASTER

-- Pokemon form (master table for pokemon) raw table
-- 18,
-- 19,45
-- 19,46
drop table if exists $TABLE_FORM_RAW CASCADE;
create table if not exists $TABLE_FORM_RAW(
    pokemon_id text,
    form_id text
);
\copy $TABLE_FORM_RAW(pokemon_id,form_id) from '$FILE_FORM' with CSV delimiter ',' NULL 'null';

-- Type number/uid raw table
drop table if exists $TABLE_TYPE_RAW CASCADE;
create table if not exists $TABLE_TYPE_RAW(
    index text,
    uid text
);
\copy $TABLE_TYPE_RAW(index,uid) from '$FILE_TYPE' with CSV delimiter ',' NULL 'null';

-- Type effectiveness raw table
drop table if exists $TABLE_EFFECTIVENESS_RAW CASCADE;
create table if not exists $TABLE_EFFECTIVENESS_RAW(
    attacker text,
    defender text,
    mlp numeric
);
\copy $TABLE_EFFECTIVENESS_RAW(attacker, defender, mlp) from '$FILE_EFFECTIVENESS' with CSV delimiter ',' NULL 'null';

-- Pokemon stats raw table
-- 18,null,"PIDGEOT",1,3,166,154,195
-- 19,null,"RATTATA",1,null,103,70,102
-- 19,46,"RATTATA_ALOLA",17,1,103,70,102
-- 19,45,"RATTATA_NORMAL",1,null,103,70,102
drop table if exists $TABLE_STATS_RAW CASCADE;
create table if not exists $TABLE_STATS_RAW(
    pokemon_id text,
    form_id text,
    uid text,
    type_1 text,
    type_2 text,
    AT int,
    DF int,
    HP int
);
\copy $TABLE_STATS_RAW(pokemon_id, form_id, uid, type_1, type_2, AT, DF, HP) from '$FILE_STATS' with CSV delimiter ',' NULL 'null';
-- SPECIAL treats for NIDORAN
UPDATE $TABLE_STATS_RAW set uid='NIDORAN_F' where pokemon_id='29' and uid='NIDORAN';
UPDATE $TABLE_STATS_RAW set uid='NIDORAN_M' where pokemon_id='32' and uid='NIDORAN';

-- Pokemon -> Fastmove reference raw table
-- 18,null,PIDGEOT,255,2018-12-04
-- 18,null,PIDGEOT,239,2018-12-04
-- 19,null,RATTATA,221,2018-12-04
-- 19,null,RATTATA,219,2018-12-04
-- 19,46,RATTATA_ALOLA,221,2018-12-04
-- 19,46,RATTATA_ALOLA,219,2018-12-04
-- 19,45,RATTATA_NORMAL,221,2018-12-04
-- 19,45,RATTATA_NORMAL,219,2018-12-04
drop table if exists $TABLE_MON_FAST_RAW CASCADE;
create table if not exists $TABLE_MON_FAST_RAW(
    pokemon_id text,
    form_id text,
    uid text,
    move text,
    legacy boolean
);
\copy $TABLE_MON_FAST_RAW(pokemon_id, form_id, uid, move, legacy) from '$FILE_MON_FAST' with CSV delimiter ',' NULL 'null';
\copy $TABLE_MON_FAST_RAW(pokemon_id, form_id, uid, move, legacy) from '$FILE_MON_FAST_LEGACY' with CSV delimiter ',' NULL 'null';
-- delete dups
create temporary table temp_pokemon_fast as select distinct * from $TABLE_MON_FAST_RAW;
delete from $TABLE_MON_FAST_RAW where true;
insert into $TABLE_MON_FAST_RAW select * from temp_pokemon_fast;
drop table temp_pokemon_fast;
-- SPECIAL treats for NIDORAN
UPDATE $TABLE_MON_FAST_RAW set uid='NIDORAN_F' where pokemon_id='29' and uid='NIDORAN';
UPDATE $TABLE_MON_FAST_RAW set uid='NIDORAN_M' where pokemon_id='32' and uid='NIDORAN';


-- Pokemon -> Chargemove reference raw table
-- 19,46,RATTATA_ALOLA,279,2018-12-04
-- 19,46,RATTATA_ALOLA,129,2018-12-04
-- 19,46,RATTATA_ALOLA,70,2018-12-04
drop table if exists $TABLE_MON_CHARGE_RAW CASCADE;
create table if not exists $TABLE_MON_CHARGE_RAW(
    pokemon_id text,
    form_id text,
    uid text,
    move text,
    legacy boolean
);
\copy $TABLE_MON_CHARGE_RAW(pokemon_id, form_id, uid, move, legacy) from '$FILE_MON_CHARGE' with CSV delimiter ',' NULL 'null';
\copy $TABLE_MON_CHARGE_RAW(pokemon_id, form_id, uid, move, legacy) from '$FILE_MON_CHARGE_LEGACY' with CSV delimiter ',' NULL 'null';
-- delete dups
create temporary table temp_pokemon_charge as select distinct * from $TABLE_MON_CHARGE_RAW;
delete from $TABLE_MON_CHARGE_RAW where true;
insert into $TABLE_MON_CHARGE_RAW select * from temp_pokemon_charge;
drop table temp_pokemon_charge;
-- SPECIAL treats for NIDORAN
UPDATE $TABLE_MON_CHARGE_RAW set uid='NIDORAN_F' where pokemon_id='29' and uid='NIDORAN';
UPDATE $TABLE_MON_CHARGE_RAW set uid='NIDORAN_M' where pokemon_id='32' and uid='NIDORAN';


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
\copy $TABLE_FASTMOVE_RAW(index,uid,type,power,duration,energy,damage_window_start,damage_window_end) from '$FILE_FASTMOVE' with CSV delimiter ',' NULL 'null';


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
\copy $TABLE_CHARGEMOVE_RAW(index,uid,type,power,duration,energy,damage_window_start,damage_window_end) from '$FILE_CHARGEMOVE' with CSV delimiter ',' NULL 'null';

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
\copy $TABLE_FASTMOVE_COMBAT_RAW(index,uid,type,power,duration,energy) from '$FILE_FASTMOVE_COMBAT' with CSV delimiter ',' NULL 'null';




-- Combat fastmove data raw table
drop table if exists $TABLE_CHARGEMOVE_COMBAT_RAW CASCADE;
create table if not exists $TABLE_CHARGEMOVE_COMBAT_RAW(
    index text,
    uid text,
    type text,
    power int,
    energy int
);
\copy $TABLE_CHARGEMOVE_COMBAT_RAW(index,uid,type,power,energy) from '$FILE_CHARGEMOVE_COMBAT' with CSV delimiter ',' NULL 'null';



-------------------------------------------------------------------------------
-- sidefiles

-- Pokemon loalization
drop table if exists $TABLE_LOCALIZE_POKEMON CASCADE;
create table if not exists $TABLE_LOCALIZE_POKEMON(
    index text,
    uid text,
    jp text,
    en text
);
\copy $TABLE_LOCALIZE_POKEMON(index, uid, jp, en) from '$FILE_LOCALIZE_POKEMON' with CSV delimiter ',' NULL 'null';
-- SPECIAL treats for NIDORAN
UPDATE $TABLE_LOCALIZE_POKEMON set uid='NIDORAN_F' where index='29' and uid='NIDORAN';
UPDATE $TABLE_LOCALIZE_POKEMON set uid='NIDORAN_M' where index='32' and uid='NIDORAN';

-- Fastmove loalization
drop table if exists $TABLE_LOCALIZE_FASTMOVE CASCADE;
create table if not exists $TABLE_LOCALIZE_FASTMOVE(
    index text,
    uid text,
    jp text,
    en text
);
\copy $TABLE_LOCALIZE_FASTMOVE(index, uid, en, jp) from '$FILE_LOCALIZE_FASTMOVE' with CSV delimiter ',' NULL 'null';

-- Chargemove loalization
drop table if exists $TABLE_LOCALIZE_CHARGEMOVE CASCADE;
create table if not exists $TABLE_LOCALIZE_CHARGEMOVE(
    index text,
    uid text,
    jp text,
    en text
);
\copy $TABLE_LOCALIZE_CHARGEMOVE(index, uid, en, jp) from '$FILE_LOCALIZE_CHARGEMOVE' with CSV delimiter ',' NULL 'null';

-- Type loalization
drop table if exists $TABLE_LOCALIZE_TYPE CASCADE;
create table if not exists $TABLE_LOCALIZE_TYPE(
    index text,
    uid text,
    jp text,
    en text
);
\copy $TABLE_LOCALIZE_TYPE(index, uid, en, jp) from '$FILE_LOCALIZE_TYPE' with CSV delimiter ',' NULL 'null';

-- CP multiplier table
drop table if exists $TABLE_CPM CASCADE;
create table if not exists $TABLE_CPM(
    lv numeric,
    mlp numeric
);
\copy $TABLE_CPM(lv, mlp) from '$FILE_CPM' with CSV delimiter ',' NULL 'null';

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

-- Statdust/Candy Cost for LVUP
drop table if exists $TABLE_STARDUST_CANDY;
create table if not exists $TABLE_STARDUST_CANDY(
    lv numeric,
    stardust integer,
    candy integer
);
\copy $TABLE_STARDUST_CANDY(lv, stardust, candy) from '$FILE_STARDUST_CANDY' with CSV delimiter ',' NULL 'null';



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
    join $TABLE_STATS_RAW B on B.pokemon_id=A.pokemon_id and coalesce(B.form_id,'') = coalesce(A.form_id,'') 
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
);
-- all possible pokemon patterns for combat
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
);


-- resistance exploded
drop table if exists $TABLE_RESISTANCE;
create table if not exists $TABLE_RESISTANCE as(
select 
    A.uid as move_type,
    B.uid as pokemon_type1,
    C.uid as pokemon_type2,
    calc_weakness(A.uid,B.uid,C.uid) as mlp 
from _type A 
join _type B on true 
join (select uid from _type union select null)C on true
);

-------------------------------------------------------------------------------
-- functions

drop function if exists calc_cp(condition TEXT);
create or replace function calc_cp(condition TEXT)
returns table(uid text, cp integer, lv numeric, hpt integer, atk integer, def integer) as'
DECLARE
    temp text[];
    target_uid TEXT;
    level NUMERIC;
    HPIV integer := 15;
    ATIV integer := 15;
    DFIV integer := 15;
BEGIN
    temp := string_to_array(condition,'','');
    target_uid := puid(temp[1]);
    level := temp[2];
    IF temp[3] is not null then HPIV := temp[3]::integer; end if;
    IF temp[4] is not null then ATIV := temp[4]::integer; end if;
    IF temp[5] is not null then DFIV := temp[5]::integer; end if;

    return query
        select
            B.uid,
            (floor((B.at+ATIV) * (sqrt(B.df+DFIV)) * (sqrt(B.hp+HPIV)) * (A.mlp * A.mlp) / 10))::INTEGER as cp,
            A.lv as lv,
            floor((B.hp+HPIV) * A.mlp)::INTEGER as hp,
            floor((B.at+ATIV) * A.mlp)::INTEGER as at,
            floor((B.df+DFIV) * A.mlp)::INTEGER as df
        from $TABLE_CPM A
        join $TABLE_POKEMON B on B.uid in (target_uid)
        where A.lv=level;
    return;
END
' LANGUAGE 'plpgsql';


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
        select mlp into res from $TABLE_EFFECTIVENESS where attacker = move_type and defender = type_1;
        IF res is not null THEN
        mlp_1 := res.mlp;
        END IF;
--raise INFO ''mlp_1 = %'', mlp_1;
    END IF;

    IF type_2 is not null THEN
        select mlp into res from $TABLE_EFFECTIVENESS where attacker = move_type and defender = type_2;
        IF res is not null THEN
        mlp_2 := res.mlp;
        END IF;
--raise INFO ''mlp_2 = %'', mlp_2;
    END IF;

    RETURN round(mlp_1 * mlp_2 * 1000) / 1000;
END
' LANGUAGE 'plpgsql';


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



-- calc status on CP cap
-- wrapper for convenience
-- usage: select * from calc_all('ラティアス,1500,15,15,15');
drop function if exists calc_all(text);
create or replace function calc_all(condition TEXT)
returns table(cp integer, lv numeric, hpt integer, atk integer, def integer) as'
DECLARE
    temp text[];
    target_uid TEXT;
    cap_cp integer := 5500;
    HPIV integer := 15;
    ATIV integer := 15;
    DFIV integer := 15;
BEGIN
    temp := string_to_array(condition,'','');
    target_uid := get_pokemon_uid(temp[1]);
    IF temp[2] is not null then cap_cp := temp[2]::integer; end if;
    IF temp[3] is not null then HPIV := temp[3]::integer; end if;
    IF temp[4] is not null then ATIV := temp[4]::integer; end if;
    IF temp[5] is not null then DFIV := temp[5]::integer; end if;
    return query select * from calc_all(target_uid, cap_cp, HPIV, ATIV, DFIV);
END
' LANGUAGE plpgsql;

drop function if exists calc_all(target_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer) cascade;
create or replace function calc_all(target_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer)
returns table(cp integer, lv numeric, hpt integer, atk integer, def integer) as'
BEGIN
    return query
        with A as (
        select
            (floor((B.at+ATIV) * (sqrt(B.df+DFIV)) * (sqrt(B.hp+HPIV)) * (A.mlp * A.mlp) / 10))::INTEGER as cp,
            A.lv as lv,
            floor((B.hp+HPIV) * A.mlp)::INTEGER as hp,
            floor((B.at+ATIV) * A.mlp)::INTEGER as at,
            floor((B.df+DFIV) * A.mlp)::INTEGER as df
        from cpm A
        join $TABLE_POKEMON B on B.uid in (target_uid)
        ) select * from A where A.cp <= cap_cp order by A.cp desc limit 1;
    return;
END
' LANGUAGE 'plpgsql';






-- usage: select * from calc_bracket('VENUSAUR', 1500, 12, 14, 8);
drop function if exists calc_bracket(target_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer);
create or replace function calc_bracket(target_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer)
returns table(IV text, cp integer, hpt integer, lv numeric, atk integer, def integer) as'
DECLARE
    pokemon record;
BEGIN
    select * into pokemon from $TABLE_POKEMON where uid=target_uid;
    return query
        select * from (select ''User defined'' as IV)q1
        join (select * from calc_all(target_uid,cap_cp,HPIV,ATIV,DFIV))q2 on true;
    return query 
        select * from (select ''Min(HP00/AT00/DF00)'' as IV)q1
        join (select * from calc_all(target_uid,cap_cp,0,0,0))q2 on true;
    return query 
        select * from (select ''Max(HP15/AT15/DF15)'' as IV)q1
        join (select * from calc_all(target_uid,cap_cp,15,15,15))q2 on true;
    return query 
        select * from (select ''Atacker(HP00/AT15/DF00)'' as IV)q1
        join (select * from calc_all(target_uid,cap_cp,0,15,0))q2 on true;
    return query 
        select * from (select ''Tank(HP15/AT00/DF15)'' as IV)q1
        join (select * from calc_all(target_uid,cap_cp,15,0,15))q2 on true;
    return;
END
' LANGUAGE 'plpgsql';



-- usage: 
--  select * from calc_all_IV_pattern('ENTEI',1500) order by cp desc, (at+df+hp) desc;
--  select * from calc_all_IV_pattern('ENTEI',1500) where cp=1500 order by (at+df+hp) desc;
drop function if exists calc_all_IV_pattern(target_uid TEXT, cap_cp integer);
create or replace function calc_all_IV_pattern(target_uid TEXT, cap_cp integer)
returns table(
    IV text, 
    cp integer, 
    lv numeric, 
    hp integer, at integer, df integer, 
    overall text,
    hpt integer, atk integer, def integer, 
    total integer,
    dust integer
) as'
DECLARE
    pokemon record;
    hp integer;
    at integer;
    df integer;
BEGIN
    select * into pokemon from $TABLE_POKEMON where uid=target_uid;

    FOR hp in 0..15 LOOP
    FOR at in 0..15 LOOP
    FOR df in 0..15 LOOP

    return query 
        select 
            q1.IV, 
            q2.cp, q2.lv, 
            hp as hp, at as at, df as df, 
            case 
                when at+df+hp = 45 then ''S''
                when at+df+hp >= 37 then ''A''
                when at+df+hp >= 30 then ''B''
                when at+df+hp >= 23 then ''C''
                else ''D''
            end as overall, 
            q2.hpt, q2.atk, q2.def, 
            q2.atk+q2.def+q2.hpt total,
            q3.stardust
        from (select concat(''HP'',hp,''/AT'',at,''/DF'',df) as IV)q1
        join (select * from calc_all(target_uid,cap_cp,hp,at,df))q2 on true
        join stardust_candy q3 on q3.lv=q2.lv;

    END LOOP;
    END LOOP;
    END LOOP;

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
-- (Target HP, Fastmove Damage, Fastmove ID, Chargemove Damage, Chargemove Damage, barrier_left int)
-- 243,"COUNTER",2,12,900,8,700,900
-- 246,"DYNAMIC_PUNCH",2,90,2700,50,1200,2700
-- select * from test(200, 12, 'COUNTER', 90, 'DYNAMIC_PUNCH');
drop function if exists calc_killtime_combat(
    hpt numeric, f_dmg numeric, f_uid text, c_dmg numeric, c_uid text, barrier_left int
);
create or replace function calc_killtime_combat(
    hpt numeric, f_dmg numeric, f_uid text, c_dmg numeric, c_uid text, barrier_left int
)
returns numeric as '
DECLARE
    fast record;
    charge record;
    time numeric := 0;
    gained integer := 0;
    turn int:=1;
BEGIN
    select * into fast from $TABLE_FASTMOVE_COMBAT_RAW F where F.uid=f_uid; 
    select * into charge from $TABLE_CHARGEMOVE_COMBAT_RAW C where C.uid=c_uid; 
    IF fast.uid is NULL or charge.uid is NULL THEN
        return -1.0;
    END IF;
    
    LOOP
        -- FAST move
        hpt := hpt - f_dmg;
        time := time + (1 + fast.duration)::numeric * 0.5;
        IF hpt <= 0 THEN
--RAISE INFO ''#% fastmove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            EXIT;
        END IF;
        gained := gained + fast.energy;
        IF gained > 100 THEN 
            gained := 100;
        END IF;

        -- CHARGE move
        IF gained >= charge.energy THEN
--RAISE INFO ''#% fastmove HPT:% TIME:% ENE:%'', turn, hpt, time, gained;
            gained := gained - charge.energy;
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
    index numeric, uid text, jp text, type_1 text, type_2 text, cp integer, lv numeric, hpt integer,  atk integer, def integer, 
    Lf text, fastmove text, f_type text, f_dps numeric, 
--    f_dmg numeric, f_dur numeric, f_ini numeric, f_ene integer, f_stab_pow numeric, f_eff numeric,
    Lc text, chargemove text, c_type text, c_dps numeric,  
--    c_dmg numeric,c_dur numeric, c_ini numeric, c_ene integer, c_stab_pow numeric, c_eff numeric,
    dps numeric, 
    killtime numeric,
    AC numeric, 
    dps_T numeric, AC_T numeric
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
),
T_AC as (
    select
        avg(S.AC) as avg,
        stddev(S.AC) as stdrd
    from S
) 
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
    ROUND(S.AC, 2),
    ROUND((S.dps - T_DPS.avg) / T_DPS.stdrd * 10 + 50, 1),
    ROUND((S.AC - T_AC.avg) / T_AC.stdrd * 10 + 50, 1)
from S
join $TABLE_LOCALIZE_POKEMON LP on LP.uid=S.uid
join $TABLE_LOCALIZE_FASTMOVE LF on LF.uid=S.f_uid
join $TABLE_LOCALIZE_CHARGEMOVE LC on LC.uid=S.c_uid
join T_DPS on true
join T_AC on true;
return;
END
' LANGUAGE 'plpgsql';




-- calc counter for combat
-- [usage]
-- [counter with opponent move type] 
-- select * from calc_counter('BLISSEY',2500,15,15,15,'POUND','HYPER_BEAM') order by firepower desc;
-- [general ranking for specific type]
-- select * from calc_counter(null, 1500,15,15,15,null) where (type_1='FIRE' or type_2='FIRE') order by dps desc;
-- [general ranking for specific move type]
-- select * from calc_counter(null, 1500,15,15,15,null) where (c_type='ELECTRIC') order by dps desc;

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
    atk integer, 
    def integer, 
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
    ocdp numeric -- opponent chargemove Damage(%)
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
    atk integer, 
    def integer, 
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
    ocdp numeric -- opponent chargemove Damage(%)
) as '
BEGIN
    return query select * from calc_counter_combat(opponent_uid, cap_cp, HPIV, ATIV, DFIV, opponent_fastmove, opponent_chargemove, null, null, null);
    return;
END
' LANGUAGE 'plpgsql';




-- calculate all win(kill < death) and lose(kill>death) patterns
-- [usage] heavy query - basically make static table
-- BEGIN;
-- drop table if exists win_lose;
-- create table win_lose as (select * from count_win_lose_pattern(5500));
-- COMMIT;
-- 
-- BEGIN;
-- insert into win_lose select * from count_win_lose_pattern(2500);
-- COMMIT;
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




-------------------------------------------------------------------------------
-- views

drop view if exists fastmove_combat_export;
create view fastmove_combat_export as(
    With Q as (
        select
            --A.index,
            A.uid, B.jp as move, C.uid as type, 
            A.power as pow, A.duration as dur, A.energy as ene 
        from $TABLE_FASTMOVE_COMBAT_RAW A 
        join $TABLE_LOCALIZE_FASTMOVE B on B.uid=A.uid 
        join $TABLE_LOCALIZE_TYPE C on C.index=A.type
    ),
    R as(
        select 
            Q.uid, Q.move, Q.type,
            Q.pow, (Q.dur + 1)::numeric * 0.5 as dur, Q.ene
        from Q
    )
    select
        *,
        case when pow is null then 0 else Round(pow / dur, 2) end as dps,
        case when ene is null then 0 else Round(ene / dur, 2) end as eps
    from R
);

drop view if exists chargemove_combat_export;
create view chargemove_combat_export as(
    With Q as (
        select
            --A.index,
            A.uid,B.jp as move, C.uid as type, 
            A.power as pow, A.energy as ene 
        from $TABLE_CHARGEMOVE_COMBAT_RAW A 
        join $TABLE_LOCALIZE_CHARGEMOVE B on B.uid=A.uid 
        join $TABLE_LOCALIZE_TYPE C on C.index=A.type
    )
    select
        *,
        case when pow is null then 0 else Round(pow::numeric / ene::numeric, 2) end as dpe
    from Q
);



drop view if exists life_cp1500_IV15;
create view life_cp1500_IV15 as(
    With q as(
        select A.index, B.jp, A.uid, A.type_1, A.type_2, A.hp, A.at, A.df from $TABLE_POKEMON A
        join $TABLE_LOCALIZE_POKEMON B on B.uid=A.uid
    )
    select * from q,calc_all(q.uid,1500,15,15,15)
);

drop view if exists life_cp2500_IV15;
create view life_cp2500_IV15 as(
    With q as(
        select A.index, B.jp, A.uid, A.type_1, A.type_2, A.hp, A.at, A.df from $TABLE_POKEMON A
        join $TABLE_LOCALIZE_POKEMON B on B.uid=A.uid
    )
    select * from q,calc_all(q.uid,2500,15,15,15)
);


drop view if exists dps_cp1500_IV15;
create view dps_cp1500_IV15 as(
With Q as (
    select 
        A.index, A.uid, A.type_1, A.type_2, 
        B.cp, B.lv, B.atk, B.def, B.hpt
    from $TABLE_POKEMON A, calc_all(A.uid,1500,15,15,15) as B
),
R as (
    select 
        Q.*, 
        R.f_uid, R.f_type, R.f_ene, R.f_dur, R.f_stab_pow, R.f_leg,
        Q.atk * R.f_stab_pow / R.f_dur as f_dps,
        R.c_uid, R.c_type,R.c_ene, R.c_dur, R.c_stab_pow, R.c_leg,
        Q.atk * R.c_stab_pow / R.c_dur as c_dps,
        R.c_ene::NUMERIC / R.f_ene::NUMERIC as chargetime
    from Q
    join $TABLE_POKEMON_PATTERN R on R.pokemon_uid=Q.uid
),
S as (select
    R.index, R.uid, LP.jp, R.type_1, R.type_2, R.cp, R.lv, R.atk, R.def, R.hpt, 
    LF.jp as fastmove, R.f_type, R.f_leg,
--    R.f_ene, R.f_stab_pow, to_char(R.f_dur, '0.9') as f_dur, 
    R.f_dps::INTEGER, 
    LC.jp as chargemove, R.c_type, R.c_leg,
--    R.c_ene, R.c_stab_pow, to_char(R.c_dur, '0.9') as c_dur, 
    R.c_dps::INTEGER, 
    (case when R.f_ene is null then 0 else
        (R.f_dps * R.chargetime + R.c_dps * R.c_dur) / 
        (R.chargetime + R.c_dur)
    end)::INTEGER as total_dps
from R
join $TABLE_LOCALIZE_POKEMON LP on LP.uid=R.uid
join $TABLE_LOCALIZE_FASTMOVE LF on LF.uid=R.f_uid
join $TABLE_LOCALIZE_CHARGEMOVE LC on LC.uid=R.c_uid
)
select *
from S
);


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
