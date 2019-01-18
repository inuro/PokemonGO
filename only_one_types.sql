select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'BUG' in (type_1,type_2) and 'FIGHTING' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'BUG' in (type_1,type_2) and 'GHOST' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'BUG' in (type_1,type_2) and 'WATER' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'DARK' in (type_1,type_2) and 'ROCK' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'DRAGON' in (type_1,type_2) and 'GRASS' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'DRAGON' in (type_1,type_2) and 'STEEL' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FAIRY' in (type_1,type_2) and 'ICE' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FAIRY' in (type_1,type_2) and 'STEEL' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FIGHTING' in (type_1,type_2) and 'GRASS' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FIGHTING' in (type_1,type_2) and 'STEEL' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FIGHTING' in (type_1,type_2) and 'WATER' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FIRE' in (type_1,type_2) and 'GHOST' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FIRE' in (type_1,type_2) and 'ROCK' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FIRE' in (type_1,type_2) and 'STEEL' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FLYING' = type_1 and type_2 is null;
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FLYING' in (type_1,type_2) and 'ROCK' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'FLYING' in (type_1,type_2) and 'STEEL' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'GHOST' in (type_1,type_2) and 'ICE' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'GRASS' in (type_1,type_2) and 'GROUND' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'NORMAL' in (type_1,type_2) and 'PSYCHIC' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'NORMAL' in (type_1,type_2) and 'WATER' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'STEEL' in (type_1,type_2) and 'WATER' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'ELECTRIC' in (type_1,type_2) and 'FIRE' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'ELECTRIC' in (type_1,type_2) and 'GHOST' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'ELECTRIC' in (type_1,type_2) and 'GRASS' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'ELECTRIC' in (type_1,type_2) and 'ICE' in (type_1,type_2);
select * from pokemon A join localize_pokemon B on B.uid=A.uid where 'ELECTRIC' in (type_1,type_2) and 'PSYCHIC' in (type_1,type_2);



SURSKIT
select *
from calc_counter_combat('SURSKIT',1500,15,15,15,'BUBBLE','SIGNAL_BEAM') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;


HERACROSS
select *
from calc_counter_combat('HERACROSS',1500,15,15,15,'COUNTER','CLOSE_COMBAT') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;


CHANSEY
select *
from calc_counter_combat('CHANSEY',1500,15,15,15,'ZEN_HEADBUTT','PSYBEAM') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;
select *
from calc_counter_combat('CHANSEY',1500,15,15,15,'POUND','DAZZLING_GLEAM') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 50;
select *
from calc_counter_combat('CHANSEY',1500,15,15,15,'ZEN_HEADBUTT','PSYBEAM') 
order by kill
limit 50;

select *
from calc_counter_combat('CHANSEY',1500,15,15,15,'POUND','PSYBEAM') 
order by kill
limit 50;

select *
from calc_counter_combat('BLISSEY',1500,15,15,15,'ZEN_HEADBUTT','PSYCHIC') 
order by kill
limit 50;

select *
from calc_counter_combat('CHANSEY',5500,15,15,15,'POUND','PSYBEAM') 
order by kill
limit 50;

select *
from calc_counter_combat('CHANSEY',1500,15,15,15,'ZEN_HEADBUTT','PSYBEAM') 
where kill<death
order by kill/death, kill_b/death_b, kill_b, kill, index, dps desc
;

select count(*)
from calc_counter_combat('CHANSEY',1500,15,15,15,'ZEN_HEADBUTT','PSYBEAM') 
where kill<death
order by kill/death, kill_b/death_b, kill_b, kill, index, dps desc
;


select count(*)
from calc_counter_combat('METAGROSS',5500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
where kill<death



With A as(
    select * from pokemon_pattern_combat
), B as (
    select A.pokemon_uid, A.f_uid, A.c_uid, count(B.*) as cnt from A, calc_counter_combat(A.pokemon_uid,5500,15,15,15,A.f_uid,A.c_uid) B where B.kill<B.death
)
select A.pokemon_uid, A.f_uid, A.c_uid, * from B 


With A as(
    select A.*,B.jp as fastmove,C.jp as chargemove from pokemon_pattern_combat A 
    join localize_fastmove B on B.uid=A.f_uid
    join localize_chargemove C on C.uid=A.c_uid
)
select count(B.*) as cnt, B.* 
from A 
join calc_counter_combat(A.pokemon_uid,5500,15,15,15,A.f_uid,A.c_uid) B on B.uid=A.pokemon_uid and B.fastmove=A.fastmove and B.chargemove=A.chargemove
where B.kill<B.death
order by cnt
limit 100;


With A as(
    select A.*,B.jp as fastmove,C.jp as chargemove from pokemon_pattern_combat A 
    join localize_fastmove B on B.uid=A.f_uid
    join localize_chargemove C on C.uid=A.c_uid
    limit 5
)
, B as(
    select B.uid,B.fastmove,B.chargemove, count(*) as cnt
    from A, calc_counter_combat(A.pokemon_uid,5500,15,15,15,A.f_uid,A.c_uid) B
    where kill<death
    group by B.uid,B.fastmove,B.chargemove
)
select * from B;






drop function if exists count_win_lose_pattern(CAP_CP INTEGER);
create or replace function count_win_lose_pattern(CAP_CP INTEGER)
returns TABLE(
    pokemon TEXT,
    fastmove TEXT,
    chargemove TEXT,
    CAP_CP INTEGER,
    win INTEGER,
    lose INTEGER
) as'
DECLARE
    pattern record;
    total integer;
    cnt integer := 0;
BEGIN
    select count(*) into total from $TABLE_POKEMON_PATTERN_COMBAT;
    for pattern in select * from $TABLE_POKEMON_PATTERN_COMBAT loop
        return query
            select 
                pattern.pokemon_uid, 
                pattern.f_uid, 
                pattern.c_uid, 
                CAP_CP,
                count(*)::INTEGER,
                (total-count(*))::INTEGER
            from calc_counter_combat(pattern.pokemon_uid,CAP_CP,15,15,15,pattern.f_uid,pattern.c_uid)
            where kill<death;
        cnt := cnt + 1;
        IF cnt>10 
            THEN exit;
        END IF;
    end loop;
    RETURN;
END
' LANGUAGE 'plpgsql';


BEGIN;
drop table if exists win_lose_masterleague;
create table win_lose_masterleague as (select * from count_win_lose_pattern(5500));
COMMIT;

BEGIN;
drop table if exists win_lose_hyperleague;
create table win_lose_hyperleague as (select * from count_win_lose_pattern(2500));
COMMIT;

BEGIN;
drop table if exists win_lose_superleague;
create table win_lose_superleague as (select * from count_win_lose_pattern(1500));
COMMIT;


select A.*, B.move_uid as fastmove, C.move_uid as chargemove
from pokemon A 
join pokemon_fastmove_combat B on B.pokemon_uid=A.uid and A.index=B.index 
join pokemon_chargemove_combat C on C.pokemon_uid=A.uid and C.index=B.index 
where B.pokemon_uid='NIDORAN' order by A.index, fastmove, chargemove;




select A.rank, A.pokemon,A.fastmove,A.chargemove,B.jp, C.jp, D.jp, A.win 
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
order by win;


select A.rank, A.pokemon,A.fastmove,A.chargemove,B.jp, C.jp, D.jp, A.win 
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where pokemon='SNORLAX' order by win;

select A.rank, A.pokemon,A.fastmove,A.chargemove,B.jp, C.jp, D.jp, A.win 
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_hyperleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
order by win;

select A.rank, A.pokemon,A.fastmove,A.chargemove,B.jp, C.jp, D.jp, A.win 
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join (
    select min(win) as score, pokemon from win_lose_masterleague group by pokemon
) Z on Z.score=A.win and Z.pokemon=A.pokemon
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
order by win;


select A.rank, A.pokemon,A.fastmove,A.chargemove,B.jp, C.jp, D.jp, A.win 
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_hyperleague
) A 
join (
    select min(win) as score, pokemon from win_lose_hyperleague group by pokemon
) Z on Z.score=A.win and Z.pokemon=A.pokemon
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
order by win;

select A.rank, A.pokemon,A.fastmove,A.chargemove,B.jp, C.jp, D.jp, A.win 
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_superleague
) A 
join (
    select min(win) as score, pokemon from win_lose_superleague group by pokemon
) Z on Z.score=A.win and Z.pokemon=A.pokemon
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
order by win;




select A.rank, B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
order by win limit 100;

select A.rank, B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join (
    select min(win) as score, pokemon from win_lose_masterleague group by pokemon
) Z on Z.score=A.win and Z.pokemon=A.pokemon
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
order by win;



select A.rank, B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where pokemon='GIRATINA_ALTERED'
order by win;



select jp as pokemon,fastmove, chargemove, kill, death, kill_b, death_b
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW')
where kill<death and kill_b < death_b order by kill/death;

select jp as pokemon,fastmove, chargemove, kill, death, kill_b, death_b
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','DRAGON_CLAW')
where kill<death and kill_b < death_b order by kill/death;

select jp as pokemon,fastmove, chargemove, kill, death, kill_b, death_b
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','ANCIENT_POWER')
where kill<death and kill_b < death_b order by kill/death;

select jp as pokemon,fastmove, chargemove, kill, death, kill_b, death_b
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','ANCIENT_POWER')
where kill<death and kill_b < death_b order by kill/death;


select A.rank, B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where pokemon='LUGIA'
order by win;

select jp as pokemon,fastmove, chargemove, kill, death, kill_b, death_b
from calc_counter_combat('LUGIA',5500,15,15,15,'DRAGON_TAIL','FUTURESIGHT')
where kill<death and kill_b < death_b order by kill/death;

select jp as pokemon,fastmove, chargemove, kill, death, kill_b, death_b
from calc_counter_combat('LUGIA',5500,15,15,15,'EXTRASENSORY','SKY_ATTACK')
where kill<death and kill_b < death_b order by kill/death;



select A.rank, B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where pokemon='KYOGRE'
order by win;

select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('KYOGRE',5500,15,15,15,'DRAGON_TAIL','HYDRO_PUMP')
where kill<death and kill_b < death_b order by kill/death;


select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('KYOGRE',5500,15,15,15,'DRAGON_TAIL','BLIZZARD')
where kill<death and kill_b < death_b order by kill/death;

select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('KYOGRE',5500,15,15,15,'DRAGON_TAIL','THUNDER')
where kill<death and kill_b < death_b order by kill/death;

select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('KYOGRE',5500,15,15,15,'WATERFALL','HYDRO_PUMP')
where kill<death and kill_b < death_b order by kill/death;


MELMETAL
select A.rank, B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where pokemon='MELMETAL'
order by win;

select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','ROCK_SLIDE')
where kill<death and kill_b < death_b order by kill/death;
select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','HYPER_BEAM')
where kill<death and kill_b < death_b order by kill/death;
select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','FLASH_CANNON')
where kill<death and kill_b < death_b order by kill/death;

select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','THUNDERBOLT')
where kill<death and kill_b < death_b order by kill/death;




select A.rank, B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where pokemon='LATIAS'
order by win;

select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','THUNDER')
where kill<death and kill_b < death_b order by kill/death;
select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','OUTRAGE')
where kill<death and kill_b < death_b order by kill/death;

select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('LATIOS',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW')
where kill<death and kill_b < death_b order by kill/death;
select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('LATIOS',5500,15,15,15,'DRAGON_BREATH','SOLAR_BEAM')
where kill<death and kill_b < death_b order by kill/death;



select A.rank, B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where pokemon='SNORLAX'
order by win;

select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','HYPER_BEAM')
where kill<death and kill_b < death_b order by kill/death;


select A.rank, B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_hyperleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
order by win;

select A.rank, B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_superleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
order by win;


TYRANITAR

select jp as pokemon,fastmove, f_type, chargemove, c_type, kill, death, kill_b, death_b
from calc_counter_combat('TYRANITAR',5500,15,15,15,'BITE','CRUNCH')
where kill<death and kill_b < death_b order by kill/death;


select A.jp as pokemon,A.fastmove, A.f_type, A.chargemove, A.c_type, A.kill, A.death, A.kill_b, A.death_b
from calc_counter_combat('TYRANITAR',5500,15,15,15,'BITE','CRUNCH') A
join (select min(kill/death) as score, uid from calc_counter_combat('TYRANITAR',5500,15,15,15,'BITE','CRUNCH') where kill<death group by uid) Z on Z.uid=A.uid and Z.score=A.kill/A.death
where kill<death and kill_b < death_b order by kill/death;

select min(fastmove||chargemove), uid from calc_counter_combat('TYRANITAR',5500,15,15,15,'BITE','CRUNCH') where kill<death group by uid;


select min(kill/death) as score, uid from calc_counter_combat('TYRANITAR',5500,15,15,15,'BITE','CRUNCH') where kill<death group by uid;

select min(kill/death) as score, uid from calc_counter_combat('TYRANITAR',5500,15,15,15,'BITE','CRUNCH') where kill<death group by uid;

select distinct jp
from calc_counter_combat('TYRANITAR',5500,15,15,15,'BITE','CRUNCH')
where kill<death and kill_b<death_b;


select A.rank, 
A.pokemon as uid,A.fastmove,A.chargemove,
B.jp as pokemon, C.jp as fastmove, D.jp as chargemove, A.win as defeat
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where pokemon='GIRATINA_ALTERED'
order by win;


select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','ANCIENT_POWER')
where kill<death and kill_b<death_b


select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','DRAGON_CLAW')
where kill<death and kill_b<death_b


select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','SHADOW_SNEAK')
where kill<death and kill_b<death_b


select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','ANCIENT_POWER')
where kill<death and kill_b<death_b



select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW')
where kill<death and kill_b<death_b;

select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','SHADOW_SNEAK')
where kill<death and kill_b<death_b;





select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','ANCIENT_POWER')
where kill<death and kill_b<death_b
union
select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','DRAGON_CLAW')
where kill<death and kill_b<death_b
union
select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','SHADOW_SNEAK')
where kill<death and kill_b<death_b
union
select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','ANCIENT_POWER')
where kill<death and kill_b<death_b
union
select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW')
where kill<death and kill_b<death_b
union
select distinct jp
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','SHADOW_SNEAK')
where kill<death and kill_b<death_b
;



select index,jp,fastmove,f_type,chargemove,c_type
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','ANCIENT_POWER')
where kill<death and kill_b<death_b
intersect
select index,jp,fastmove,f_type,chargemove,c_type
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','DRAGON_CLAW')
where kill<death and kill_b<death_b
intersect
select index,jp,fastmove,f_type,chargemove,c_type
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','SHADOW_SNEAK')
where kill<death and kill_b<death_b
intersect
select index,jp,fastmove,f_type,chargemove,c_type
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','ANCIENT_POWER')
where kill<death and kill_b<death_b
intersect
select index,jp,fastmove,f_type,chargemove,c_type
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW')
where kill<death and kill_b<death_b
intersect
select index,jp,fastmove,f_type,chargemove,c_type
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','SHADOW_SNEAK')
where kill<death and kill_b<death_b
;


select concat(
    'select index,jp,fastmove,f_type,chargemove,c_type from calc_counter_combat(''',
    A.pokemon,
    ''',5500,15,15,15,''',
    A.fastmove,
    ''',''',
    A.chargemove,
    ''') where kill<death and kill_b<death_b intersect'
)::TEXT as sql
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
where pokemon='LUGIA'
;
select * from(
select index,jp,fastmove,f_type,chargemove,c_type from calc_counter_combat('LUGIA',5500,15,15,15,'EXTRASENSORY','FUTURESIGHT') where kill<death and kill_b<death_b intersect
 select index,jp,fastmove,f_type,chargemove,c_type from calc_counter_combat('LUGIA',5500,15,15,15,'EXTRASENSORY','SKY_ATTACK') where kill<death and kill_b<death_b intersect
 select index,jp,fastmove,f_type,chargemove,c_type from calc_counter_combat('LUGIA',5500,15,15,15,'EXTRASENSORY','HYDRO_PUMP') where kill<death and kill_b<death_b intersect
 select index,jp,fastmove,f_type,chargemove,c_type from calc_counter_combat('LUGIA',5500,15,15,15,'DRAGON_TAIL','FUTURESIGHT') where kill<death and kill_b<death_b intersect
 select index,jp,fastmove,f_type,chargemove,c_type from calc_counter_combat('LUGIA',5500,15,15,15,'DRAGON_TAIL','SKY_ATTACK') where kill<death and kill_b<death_b intersect
 select index,jp,fastmove,f_type,chargemove,c_type from calc_counter_combat('LUGIA',5500,15,15,15,'DRAGON_TAIL','HYDRO_PUMP') where kill<death and kill_b<death_b
)A order by index;


select concat(
    'select index,jp,fastmove,f_type,chargemove,c_type from calc_counter_combat(''',
    A.pokemon,
    ''',5500,15,15,15,''',
    A.fastmove,
    ''',''',
    A.chargemove,
    ''') where kill<death and kill_b<death_b intersect'
)::TEXT as sql
from (
    select *, 
    rank() OVER (ORDER BY win) AS rank
    from win_lose_masterleague
) A 
where pokemon='KYOGRE';





