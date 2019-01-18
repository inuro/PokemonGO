


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


ALTER table win_lose_masterleague rename to win_lose;

BEGIN;
drop table if exists win_lose;
create table win_lose_masterleague as (select * from count_win_lose_pattern(5500));
COMMIT;

BEGIN;
insert into win_lose select * from count_win_lose_pattern(2500);
COMMIT;

BEGIN;
insert into win_lose select * from count_win_lose_pattern(1500);
COMMIT;


select A.*, B.move_uid as fastmove, C.move_uid as chargemove
from pokemon A 
join pokemon_fastmove_combat B on B.pokemon_uid=A.uid and A.index=B.index 
join pokemon_chargemove_combat C on C.pokemon_uid=A.uid and C.index=B.index 
where B.pokemon_uid='NIDORAN' order by A.index, fastmove, chargemove;




select A.rank, A.pokemon,A.fastmove,A.chargemove,B.jp, C.jp, D.jp, A.win, A.win_unique 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
order by win_unique;

-- マスターリーグのランキング
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where rank<=100
order by win_unique;

-- ハイパーリーグのランキング
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=2500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where rank<=100
order by win_unique;

-- スーパーリーグのランキング
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=1500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where rank<=100
order by win_unique;


select 
    distinct B.jp as "ポケモン"
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where rank<=100

drop function if exists type_markup(type_uid TEXT);
create or replace function type_markup(type_uid TEXT)
returns TEXT as '
BEGIN
    RETURN ''{{< type '' || type_uid || '' >}}'';
END
' LANGUAGE 'plpgsql';


-- ギラティナ

select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon='GIRATINA_ALTERED'
order by win_unique;


select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','DRAGON_CLAW') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b 
order by A.index, kill/death;

select A.* 
from (select distinct jp,fastmove,chargemove from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW') where kill<death or kill_b < death_b) A
join (select distinct jp,fastmove,chargemove from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','ANCIENT_POWER') where kill<death or kill_b < death_b) B on B.jp=A.jp and B.fastmove=A.fastmove and B.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','SHADOW_SNEAK') where kill<death or kill_b < death_b) C on C.jp=A.jp and C.fastmove=A.fastmove and C.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','DRAGON_CLAW') where kill<death or kill_b < death_b) D on D.jp=A.jp and D.fastmove=A.fastmove and D.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','ANCIENT_POWER') where kill<death or kill_b < death_b) E on E.jp=A.jp and E.fastmove=A.fastmove and E.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','SHADOW_SNEAK') where kill<death or kill_b < death_b) F on F.jp=A.jp and F.fastmove=A.fastmove and F.chargemove=A.chargemove
order by A.jp
;



-- ルギア
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon='LUGIA'
order by win_unique;

select * from pokemon_pattern_combat where pokemon_uid='LUGIA';

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('LUGIA',5500,15,15,15,'DRAGON_TAIL','SKY_ATTACK') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b 
order by A.index, kill/death;

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('LUGIA',5500,15,15,15,'DRAGON_TAIL','HYDRO_PUMP') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b 
order by A.index, kill/death;

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('LUGIA',5500,15,15,15,'DRAGON_TAIL','FUTURESIGHT') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b 
order by A.index, kill/death;



select A.* 
from (select distinct jp,fastmove,chargemove from calc_counter_combat('LUGIA',5500,15,15,15,'DRAGON_TAIL','FUTURESIGHT') where kill<death and kill_b < death_b) A
join (select distinct jp,fastmove,chargemove from calc_counter_combat('LUGIA',5500,15,15,15,'DRAGON_TAIL','HYDRO_PUMP') where kill<death and kill_b < death_b) B on B.jp=A.jp and B.fastmove=A.fastmove and B.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('LUGIA',5500,15,15,15,'DRAGON_TAIL','SKY_ATTACK') where kill<death and kill_b < death_b) C on C.jp=A.jp and C.fastmove=A.fastmove and C.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('LUGIA',5500,15,15,15,'EXTRASENSORY','FUTURESIGHT') where kill<death and kill_b < death_b) D on D.jp=A.jp and D.fastmove=A.fastmove and D.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('LUGIA',5500,15,15,15,'EXTRASENSORY','HYDRO_PUMP') where kill<death and kill_b < death_b) E on E.jp=A.jp and E.fastmove=A.fastmove and E.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('LUGIA',5500,15,15,15,'EXTRASENSORY','SKY_ATTACK') where kill<death and kill_b < death_b) F on F.jp=A.jp and F.fastmove=A.fastmove and F.chargemove=A.chargemove
order by A.jp
;




-- カイオーガ

select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon='KYOGRE'
order by win_unique;

select * from pokemon_pattern_combat where pokemon_uid='KYOGRE';

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('KYOGRE',5500,15,15,15,'DRAGON_TAIL','HYDRO_PUMP') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b 
order by A.index, kill/death;

select A.* 
from (select distinct jp,fastmove,chargemove from calc_counter_combat('KYOGRE',5500,15,15,15,'DRAGON_TAIL','THUNDER') where kill<death and kill_b < death_b) A
join (select distinct jp,fastmove,chargemove from calc_counter_combat('KYOGRE',5500,15,15,15,'DRAGON_TAIL','HYDRO_PUMP') where kill<death and kill_b < death_b) B on B.jp=A.jp and B.fastmove=A.fastmove and B.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('KYOGRE',5500,15,15,15,'DRAGON_TAIL','BLIZZARD') where kill<death and kill_b < death_b) C on C.jp=A.jp and C.fastmove=A.fastmove and C.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('KYOGRE',5500,15,15,15,'WATERFALL','THUNDER') where kill<death and kill_b < death_b) D on D.jp=A.jp and D.fastmove=A.fastmove and D.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('KYOGRE',5500,15,15,15,'WATERFALL','HYDRO_PUMP') where kill<death and kill_b < death_b) E on E.jp=A.jp and E.fastmove=A.fastmove and E.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('KYOGRE',5500,15,15,15,'WATERFALL','BLIZZARD') where kill<death and kill_b < death_b) F on F.jp=A.jp and F.fastmove=A.fastmove and F.chargemove=A.chargemove
order by A.jp
;


-- メルメタル
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon='MELMETAL'
order by win_unique;

select * from pokemon_pattern_combat where pokemon_uid='MELMETAL';

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','ROCK_SLIDE') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b 
order by A.index, kill/death;

select A.* 
from (select distinct jp,fastmove,chargemove from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','ROCK_SLIDE') where kill<death and kill_b < death_b) A
join (select distinct jp,fastmove,chargemove from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','FLASH_CANNON') where kill<death and kill_b < death_b) B on B.jp=A.jp and B.fastmove=A.fastmove and B.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','THUNDERBOLT') where kill<death and kill_b < death_b) C on C.jp=A.jp and C.fastmove=A.fastmove and C.chargemove=A.chargemove
join (select distinct jp,fastmove,chargemove from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','HYPER_BEAM') where kill<death and kill_b < death_b) D on D.jp=A.jp and D.fastmove=A.fastmove and D.chargemove=A.chargemove
order by A.jp
;



-- ラティアス
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon='LATIAS'
order by win_unique;

WITH
Z as (select get_pokemon_uid('ラティアス') as uid),
A as(select pokemon_uid, f_uid, c_uid, rank() over (ORDER BY f_uid || c_uid) as rank from pokemon_pattern_combat,Z where pokemon_uid=Z.uid),
B as (select count(*) as count from pokemon_pattern_combat,Z where pokemon_uid=Z.uid)
select
    case 
    when rank=1 then 'select A.jp as "ポケモン", type_markup(F.type_1) as "タイプ1",type_markup(F.type_2) as "タイプ2",A.fastmove as "通常技",type_markup(E.f_type) as "タイプ",A.chargemove as "必殺技",type_markup(E.c_type) as "タイプ" from (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',5500,15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) A'
    when rank=count then 'join (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',5500,15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) Q' || rank || ' on Q' || rank || '.jp=A.jp and Q' || rank || '.fastmove=A.fastmove and Q' || rank || '.chargemove=A.chargemove join localize_pokemon B on B.jp=A.jp join localize_fastmove C on C.jp=A.fastmove join localize_chargemove D on D.jp=A.chargemove join pokemon_pattern_combat E on E.pokemon_uid=B.uid and E.f_uid=C.uid and E.c_uid=D.uid join pokemon F on F.uid=B.uid order by B.index;'
    else 'join (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',5500,15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) Q' || rank || ' on Q' || rank || '.jp=A.jp and Q' || rank || '.fastmove=A.fastmove and Q' || rank || '.chargemove=A.chargemove'
    end as query
from A join B on true;

 select A.* from (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','OUTRAGE') where kill<death and kill_b < death_b) A
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','PSYCHIC') where kill<death and kill_b < death_b) Q2 on Q2.jp=A.jp and Q2.fastmove=A.fastmove and Q2.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','THUNDER') where kill<death and kill_b < death_b) Q3 on Q3.jp=A.jp and Q3.fastmove=A.fastmove and Q3.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIAS',5500,15,15,15,'ZEN_HEADBUTT','OUTRAGE') where kill<death and kill_b < death_b) Q4 on Q4.jp=A.jp and Q4.fastmove=A.fastmove and Q4.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIAS',5500,15,15,15,'ZEN_HEADBUTT','PSYCHIC') where kill<death and kill_b < death_b) Q5 on Q5.jp=A.jp and Q5.fastmove=A.fastmove and Q5.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIAS',5500,15,15,15,'ZEN_HEADBUTT','THUNDER') where kill<death and kill_b < death_b) Q6 on Q6.jp=A.jp and Q6.fastmove=A.fastmove and Q6.chargemove=A.chargemove order by A.jp;

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','OUTRAGE') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b 
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;




-- ラティオス
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon='LATIOS'
order by win_unique;

WITH A as(select pokemon_uid, f_uid, c_uid, rank() over (ORDER BY f_uid || c_uid) as rank from pokemon_pattern_combat where pokemon_uid='LATIOS'),
B as (select count(*) as count from pokemon_pattern_combat where pokemon_uid='LATIOS')
select
    case 
    when rank=1 then 'select A.jp as "ポケモン", type_markup(F.type_1) as "タイプ1",type_markup(F.type_2) as "タイプ2",A.fastmove as "通常技",type_markup(E.f_type) as "タイプ",A.chargemove as "必殺技",type_markup(E.c_type) as "タイプ" from (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',5500,15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) A'
    when rank=count then 'join (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',5500,15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) Q' || rank || ' on Q' || rank || '.jp=A.jp and Q' || rank || '.fastmove=A.fastmove and Q' || rank || '.chargemove=A.chargemove join localize_pokemon B on B.jp=A.jp join localize_fastmove C on C.jp=A.fastmove join localize_chargemove D on D.jp=A.chargemove join pokemon_pattern_combat E on E.pokemon_uid=B.uid and E.f_uid=C.uid and E.c_uid=D.uid join pokemon F on F.uid=B.uid order by B.index;'
    else 'join (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',5500,15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) Q' || rank || ' on Q' || rank || '.jp=A.jp and Q' || rank || '.fastmove=A.fastmove and Q' || rank || '.chargemove=A.chargemove'
    end as query
from A join B on true;

select A.jp as "ポケモン", type_markup(F.type_1) as "タイプ1",type_markup(F.type_2) as "タイプ2",A.fastmove as "通常技",type_markup(E.f_type) as "タイプ",A.chargemove as "必殺技",type_markup(E.c_type) as "タイプ" from (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIOS',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW') where kill<death and kill_b < death_b) A
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIOS',5500,15,15,15,'DRAGON_BREATH','PSYCHIC') where kill<death and kill_b < death_b) Q2 on Q2.jp=A.jp and Q2.fastmove=A.fastmove and Q2.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIOS',5500,15,15,15,'DRAGON_BREATH','SOLAR_BEAM') where kill<death and kill_b < death_b) Q3 on Q3.jp=A.jp and Q3.fastmove=A.fastmove and Q3.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIOS',5500,15,15,15,'ZEN_HEADBUTT','DRAGON_CLAW') where kill<death and kill_b < death_b) Q4 on Q4.jp=A.jp and Q4.fastmove=A.fastmove and Q4.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIOS',5500,15,15,15,'ZEN_HEADBUTT','PSYCHIC') where kill<death and kill_b < death_b) Q5 on Q5.jp=A.jp and Q5.fastmove=A.fastmove and Q5.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('LATIOS',5500,15,15,15,'ZEN_HEADBUTT','SOLAR_BEAM') where kill<death and kill_b < death_b) Q6 on Q6.jp=A.jp and Q6.fastmove=A.fastmove and Q6.chargemove=A.chargemove join localize_pokemon B on B.jp=A.jp join localize_fastmove C on C.jp=A.fastmove join localize_chargemove D on D.jp=A.chargemove join pokemon_pattern_combat E on E.pokemon_uid=B.uid and E.f_uid=C.uid and E.c_uid=D.uid join pokemon F on F.uid=B.uid 
 order by B.index;

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('LATIOS',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;



-- カビゴン
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon='SNORLAX'
order by win_unique;

WITH
Z as (select get_pokemon_uid('カビゴン') as uid),
A as(select pokemon_uid, f_uid, c_uid, rank() over (ORDER BY f_uid || c_uid) as rank from pokemon_pattern_combat,Z where pokemon_uid=Z.uid),
B as (select count(*) as count from pokemon_pattern_combat,Z where pokemon_uid=Z.uid)
select
    case 
    when rank=1 then 'select A.jp as "ポケモン", type_markup(F.type_1) as "タイプ1",type_markup(F.type_2) as "タイプ2",A.fastmove as "通常技",type_markup(E.f_type) as "タイプ",A.chargemove as "必殺技",type_markup(E.c_type) as "タイプ" from (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',5500,15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) A'
    when rank=count then 'join (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',5500,15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) Q' || rank || ' on Q' || rank || '.jp=A.jp and Q' || rank || '.fastmove=A.fastmove and Q' || rank || '.chargemove=A.chargemove join localize_pokemon B on B.jp=A.jp join localize_fastmove C on C.jp=A.fastmove join localize_chargemove D on D.jp=A.chargemove join pokemon_pattern_combat E on E.pokemon_uid=B.uid and E.f_uid=C.uid and E.c_uid=D.uid join pokemon F on F.uid=B.uid order by B.index;'
    else 'join (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',5500,15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) Q' || rank || ' on Q' || rank || '.jp=A.jp and Q' || rank || '.fastmove=A.fastmove and Q' || rank || '.chargemove=A.chargemove'
    end as query
from A join B on true;


select A.jp as "ポケモン", type_markup(F.type_1) as "タイプ1",type_markup(F.type_2) as "タイプ2",A.fastmove as "通常技",type_markup(E.f_type) as "タイプ",A.chargemove as "必殺技",type_markup(E.c_type) as "タイプ" from (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','BODY_SLAM') where kill<death and kill_b < death_b) A
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','EARTHQUAKE') where kill<death and kill_b < death_b) Q2 on Q2.jp=A.jp and Q2.fastmove=A.fastmove and Q2.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','HEAVY_SLAM') where kill<death and kill_b < death_b) Q3 on Q3.jp=A.jp and Q3.fastmove=A.fastmove and Q3.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','HYPER_BEAM') where kill<death and kill_b < death_b) Q4 on Q4.jp=A.jp and Q4.fastmove=A.fastmove and Q4.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'ZEN_HEADBUTT','BODY_SLAM') where kill<death and kill_b < death_b) Q5 on Q5.jp=A.jp and Q5.fastmove=A.fastmove and Q5.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'ZEN_HEADBUTT','EARTHQUAKE') where kill<death and kill_b < death_b) Q6 on Q6.jp=A.jp and Q6.fastmove=A.fastmove and Q6.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'ZEN_HEADBUTT','HEAVY_SLAM') where kill<death and kill_b < death_b) Q7 on Q7.jp=A.jp and Q7.fastmove=A.fastmove and Q7.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'ZEN_HEADBUTT','HYPER_BEAM') where kill<death and kill_b < death_b) Q8 on Q8.jp=A.jp and Q8.fastmove=A.fastmove and Q8.chargemove=A.chargemove join localize_pokemon B on B.jp=A.jp join localize_fastmove C on C.jp=A.fastmove join localize_chargemove D on D.jp=A.chargemove join pokemon_pattern_combat E on E.pokemon_uid=B.uid and E.f_uid=C.uid and E.c_uid=D.uid join pokemon F on F.uid=B.uid;


select A.jp as "ポケモン", type_markup(F.type_1) as "タイプ1",type_markup(F.type_2) as "タイプ2",A.fastmove as "通常技",type_markup(E.f_type) as "タイプ",A.chargemove as "必殺技",type_markup(E.c_type) as "タイプ" from (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','EARTHQUAKE') where kill<death and kill_b < death_b) A
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','HEAVY_SLAM') where kill<death and kill_b < death_b) Q3 on Q3.jp=A.jp and Q3.fastmove=A.fastmove and Q3.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','HYPER_BEAM') where kill<death and kill_b < death_b) Q4 on Q4.jp=A.jp and Q4.fastmove=A.fastmove and Q4.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'ZEN_HEADBUTT','EARTHQUAKE') where kill<death and kill_b < death_b) Q6 on Q6.jp=A.jp and Q6.fastmove=A.fastmove and Q6.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'ZEN_HEADBUTT','HEAVY_SLAM') where kill<death and kill_b < death_b) Q7 on Q7.jp=A.jp and Q7.fastmove=A.fastmove and Q7.chargemove=A.chargemove
 join (select distinct jp,fastmove,chargemove from calc_counter_combat('SNORLAX',5500,15,15,15,'ZEN_HEADBUTT','HYPER_BEAM') where kill<death and kill_b < death_b) Q8 on Q8.jp=A.jp and Q8.fastmove=A.fastmove and Q8.chargemove=A.chargemove join localize_pokemon B on B.jp=A.jp join localize_fastmove C on C.jp=A.fastmove join localize_chargemove D on D.jp=A.chargemove join pokemon_pattern_combat E on E.pokemon_uid=B.uid and E.f_uid=C.uid and E.c_uid=D.uid join pokemon F on F.uid=B.uid;




select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','BODY_SLAM') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','HYPER_BEAM') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;


select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','EARTHQUAKE') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;








-- キングドラ（ハイパーリーグ）
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=2500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon=get_pokemon_uid('キングドラ')
order by win_unique;

WITH
Z as (select get_pokemon_uid('キングドラ') as uid, 2500 as cap),
A as(select pokemon_uid, f_uid, c_uid, rank() over (ORDER BY f_uid || c_uid) as rank from pokemon_pattern_combat,Z where pokemon_uid=Z.uid),
B as (select count(*) as count from pokemon_pattern_combat,Z where pokemon_uid=Z.uid)
select
    case 
    when rank=1 then 'select A.jp as "ポケモン", type_markup(F.type_1) as "タイプ1",type_markup(F.type_2) as "タイプ2",A.fastmove as "通常技",type_markup(E.f_type) as "タイプ",A.chargemove as "必殺技",type_markup(E.c_type) as "タイプ" from (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',' || Z.cap || ',15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) A'
    when rank=count then 'join (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',' || Z.cap || ',15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) Q' || rank || ' on Q' || rank || '.jp=A.jp and Q' || rank || '.fastmove=A.fastmove and Q' || rank || '.chargemove=A.chargemove join localize_pokemon B on B.jp=A.jp join localize_fastmove C on C.jp=A.fastmove join localize_chargemove D on D.jp=A.chargemove join pokemon_pattern_combat E on E.pokemon_uid=B.uid and E.f_uid=C.uid and E.c_uid=D.uid join pokemon F on F.uid=B.uid order by B.index;'
    else 'join (select distinct jp,fastmove,chargemove from calc_counter_combat(''' || pokemon_uid || ''',' || Z.cap || ',15,15,15,''' || f_uid || ''',''' || c_uid || ''') where kill<death and kill_b < death_b) Q' || rank || ' on Q' || rank || '.jp=A.jp and Q' || rank || '.fastmove=A.fastmove and Q' || rank || '.chargemove=A.chargemove'
    end as query
from A,B,Z;

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('キングドラ',2500,15,15,15,'りゅうのいぶき','ふぶき') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;








-- ヤルキモノ（スーパーリーグ）
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=1500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon=get_pokemon_uid('ヤルキモノ')
order by win_unique;

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('ヤルキモノ',1500,15,15,15,'カウンター','のしかかり') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;




-- エビワラー（ハイパーリーグ）
select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('エビワラー',2500,15,15,15,'カウンター','かみなりパンチ') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;



-- ブラッキー（スーパーリーグ）
select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('ブラッキー',1500,15,15,15,'バークアウト','あくのはどう') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;


-- マリルリ（スーパーリーグ）
select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=1500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon=get_pokemon_uid('マリルリ')
order by win_unique;

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('マリルリ',1500,15,15,15,'あわ','じゃれつく') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;


-- ヤミラミ（スーパーリーグ）
select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('ヤミラミ',1500,15,15,15,'シャドークロー','イカサマ') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;

-- チャーレム （スーパーリーグ）
select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('チャーレム',1500,15,15,15,'カウンター','れいとうパンチ') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;






select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=2500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon=get_pokemon_uid('オムスター')
order by win_unique;





select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=1500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon=get_pokemon_uid('サメハダー')
order by win_unique;




select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=2500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon=get_pokemon_uid('フシギバナ')
order by win_unique;


-- ハッサム （ハイパーリーグ）
select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('ハッサム',2500,15,15,15,'バレットパンチ','シザークロス') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;


select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('ヤミラミ',1500,15,15,15,'シャドークロー','イカサマ') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;














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





select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=1500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon=get_pokemon_uid('ダーテング')
order by win_unique


select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
select * from calc_counter_combat('ヤミラミ',2500,15,15,15,'シャドークロー','イカサマ') where uid=get_pokemon_uid('ダーテング');


select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=1500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon=get_pokemon_uid('ヤルキモノ')
order by win_unique

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('ヤルキモノ',1500,15,15,15,'カウンター','のしかかり') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;



select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=5500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon=get_pokemon_uid('トゲキッス')
order by win_unique;

select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('ヤルキモノ',1500,15,15,15,'カウンター','のしかかり') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;






select 
    A.rank as "ランク", 
    B.jp as "ポケモン", 
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    C.jp as "通常技", 
    type_markup(E.f_type) as "タイプ",
    D.jp as "必殺技", 
    type_markup(E.c_type) as "タイプ",
    A.win_unique as "苦手なポケモンの数" 
from (
    select *, 
    rank() OVER (ORDER BY win_unique) AS rank
    from win_lose
    where cap=2500
) A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
join pokemon_pattern_combat E on E.pokemon_uid=A.pokemon and E.f_uid=A.fastmove and E.c_uid=A.chargemove
join pokemon F on F.uid=A.pokemon
where pokemon=get_pokemon_uid('ファイヤー')
order by win_unique;


select 
    A.jp as "ポケモン",
    type_markup(F.type_1) as "タイプ1",
    type_markup(F.type_2) as "タイプ2",
    A.fastmove as "通常技", 
    type_markup(A.f_type) as "タイプ", 
    A.chargemove as "必殺技", 
    type_markup(A.c_type) as "タイプ", 
    A.kill as "倒す", 
    A.death as "倒され", 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b as "倒す(B)", 
    A.death_b as "倒され(B)",
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('オーダイル',1500,15,15,15,'かみつく','ハイドロカノン') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;


select * from calc_counter_combat('',5500,15,15,15,null,null) A
join pokemon F on F.uid=A.uid
order by A.index, kill/death;


select
A.index as "#", 
A.pokemon_uid as "Pokemon", 
C.jp as "ポケモン",
B.type_1,
B.type_2,
case when A.f_leg then '▲' else null end as "▲",
A.f_uid as "Fastmove",
D.jp as "通常技",
case when A.f_stab then '★' else null end as "★",
A.f_type as "type", 
A.f_stab_pow as "dmg",
A.f_dur as "dur", 
A.f_ene as "ene", 
ROUND(A.f_stab_pow / A.f_dur,1) as "DPS",
ROUND(A.f_ene / A.f_dur,1) as "EPS",
case when A.c_leg then '▲' else null end as "▲",
A.c_uid as "Chargemove", 
E.jp as "必殺技",
case when A.c_stab then '★' else null end as "★",
A.c_type as "type", 
A.c_ene as "ene",
A.c_stab_pow as "dmg",
ROUND(A.c_stab_pow / A.c_ene, 1) as "DPE",
CEIL(A.c_ene::NUMERIC / A.f_ene) as "x",
CEIL(A.c_ene::NUMERIC / A.f_ene) * A.f_dur as "time",
ROUND((CEIL(A.c_ene::NUMERIC / A.f_ene) * A.f_stab_pow + A.c_stab_pow) / (CEIL(A.c_ene::NUMERIC / A.f_ene) * A.f_dur), 2) as "TotalDPS"
from pokemon_pattern_combat A
join pokemon B on B.uid=A.pokemon_uid
join localize_pokemon C on C.uid=A.pokemon_uid
join localize_fastmove D on D.uid=A.f_uid
join localize_chargemove E on E.uid=A.c_uid
;
limit 3;




-- pokemon all pattern list combat
select
A.index as "#", 
A.pokemon_uid as "Pokemon", 
C.jp as "ポケモン",
B.type_1,
B.type_2,
case when A.f_leg then '▲' else null end as "▲",
A.f_uid as "Fastmove",
D.jp as "通常技",
case when A.f_stab then '★' else null end as "★",
A.f_type as "type", 
A.f_stab_pow as "dmg",
A.f_dur as "dur", 
A.f_ene as "ene", 
ROUND(A.f_stab_pow / A.f_dur,1) as "DPS",
ROUND(A.f_ene / A.f_dur,1) as "EPS",
case when A.c_leg then '▲' else null end as "▲",
A.c_uid as "Chargemove", 
E.jp as "必殺技",
case when A.c_stab then '★' else null end as "★",
A.c_type as "type", 
A.c_ene as "ene",
A.c_stab_pow as "dmg",
ROUND(A.c_stab_pow / A.c_ene, 1) as "DPE",
CEIL(A.c_ene::NUMERIC / A.f_ene) as "x",
CEIL(A.c_ene::NUMERIC / A.f_ene) * A.f_dur as "time",
ROUND((CEIL(A.c_ene::NUMERIC / A.f_ene) * A.f_stab_pow + A.c_stab_pow) / (CEIL(A.c_ene::NUMERIC / A.f_ene) * A.f_dur), 2) as "TotalDPS"
from pokemon_pattern_combat A
join pokemon B on B.uid=A.pokemon_uid
;


