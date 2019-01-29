-- タイプ別、リーグ別の上位


WITH A as (
    select A.*
    ,   rank() over (order by counter_unique) rnk
    ,   B.jp as pokemon
    ,   C.jp as fastmove
    ,   D.jp as chargemove
    from win_lose A
    join localize_pokemon B on B.uid=A.uid
    join localize_fastmove C on C.uid=A.f_uid
    join localize_chargemove D on D.uid=A.c_uid
    where cap=1500
)
select 
    rnk, pokemon, 
    case when B.legacy then '▲' else '' end || fastmove ||  case when B.type in (type_1,type_2) then '☆' else '' end as fastmove,
    case when C.legacy then '▲' else '' end || chargemove || case when C.type in (type_1,type_2) then '☆' else '' end as chargemove,
    win, lose, win_b, lose_b, counter, counter_unique
from A
join pokemon_fastmove_combat B on B.pokemon_uid=A.uid and B.move_uid=A.f_uid
join pokemon_chargemove_combat C on C.pokemon_uid=A.uid and C.move_uid=A.c_uid
where true
--and 'WATER' in (type_1,type_2)
--and 'STEEL' in (f_type,c_type)
order by rnk limit 100;


WITH A as (
    select A.*
    ,   rank() over (order by counter_unique) rnk
    ,   B.jp as pokemon
    ,   C.jp as fastmove
    ,   D.jp as chargemove
    from win_lose A
    join localize_pokemon B on B.uid=A.uid
    join localize_fastmove C on C.uid=A.f_uid
    join localize_chargemove D on D.uid=A.c_uid
    where cap=2500
)
select 
    rnk, pokemon, 
    case when B.legacy then '▲' else '' end || fastmove ||  case when B.type in (type_1,type_2) then '☆' else '' end as fastmove,
    case when C.legacy then '▲' else '' end || chargemove || case when C.type in (type_1,type_2) then '☆' else '' end as chargemove,
    win, lose, win_b, lose_b, counter, counter_unique
from A
join pokemon_fastmove_combat B on B.pokemon_uid=A.uid and B.move_uid=A.f_uid
join pokemon_chargemove_combat C on C.pokemon_uid=A.uid and C.move_uid=A.c_uid
where true
--and 'WATER' in (type_1,type_2)
--and 'STEEL' in (f_type,c_type)
order by rnk limit 100;

WITH A as (
    select A.*
    ,   rank() over (order by counter_unique) rnk
    ,   B.jp as pokemon
    ,   C.jp as fastmove
    ,   D.jp as chargemove
    from win_lose A
    join localize_pokemon B on B.uid=A.uid
    join localize_fastmove C on C.uid=A.f_uid
    join localize_chargemove D on D.uid=A.c_uid
    where cap=5500
)
select 
    rnk, pokemon, 
    case when B.legacy then '▲' else '' end || fastmove ||  case when B.type in (type_1,type_2) then '☆' else '' end as fastmove,
    case when C.legacy then '▲' else '' end || chargemove || case when C.type in (type_1,type_2) then '☆' else '' end as chargemove,
    win, lose, win_b, lose_b, counter, counter_unique
from A
join pokemon_fastmove_combat B on B.pokemon_uid=A.uid and B.move_uid=A.f_uid
join pokemon_chargemove_combat C on C.pokemon_uid=A.uid and C.move_uid=A.c_uid
where true
--and 'WATER' in (type_1,type_2)
--and 'STEEL' in (f_type,c_type)
order by rnk limit 100;


WITH A as (
    select A.*
    ,   rank() over (order by counter_unique) rnk
    ,   B.jp as pokemon
    ,   C.jp as fastmove
    ,   D.jp as chargemove
    from win_lose A
    join localize_pokemon B on B.uid=A.uid
    join localize_fastmove C on C.uid=A.f_uid
    join localize_chargemove D on D.uid=A.c_uid
    where cap=1500
)
select 
    rnk, pokemon, 
    case when B.legacy then '▲' else '' end || fastmove ||  case when B.type in (type_1,type_2) then '☆' else '' end as fastmove,
    case when C.legacy then '▲' else '' end || chargemove || case when C.type in (type_1,type_2) then '☆' else '' end as chargemove,
    win, lose, win_b, lose_b, counter, counter_unique
from A
join pokemon_fastmove_combat B on B.pokemon_uid=A.uid and B.move_uid=A.f_uid
join pokemon_chargemove_combat C on C.pokemon_uid=A.uid and C.move_uid=A.c_uid
where true
and 'NORMAL' in (type_1,type_2)
and 'NORMAL' in (f_type,c_type)
order by rnk limit 20;


WITH A as (
    select A.*
    ,   rank() over (order by counter_unique) rnk
    ,   B.jp as pokemon
    ,   C.jp as fastmove
    ,   D.jp as chargemove
    from win_lose A
    join localize_pokemon B on B.uid=A.uid
    join localize_fastmove C on C.uid=A.f_uid
    join localize_chargemove D on D.uid=A.c_uid
    where cap=2500
)
select 
    rnk, pokemon, 
    case when B.legacy then '▲' else '' end || fastmove ||  case when B.type in (type_1,type_2) then '☆' else '' end as fastmove,
    case when C.legacy then '▲' else '' end || chargemove || case when C.type in (type_1,type_2) then '☆' else '' end as chargemove,
    win, lose, win_b, lose_b, counter, counter_unique
from A
join pokemon_fastmove_combat B on B.pokemon_uid=A.uid and B.move_uid=A.f_uid
join pokemon_chargemove_combat C on C.pokemon_uid=A.uid and C.move_uid=A.c_uid
where true
and 'FLYING' in (type_1,type_2)
and 'FLYING' in (f_type,c_type)
order by rnk limit 20;

WITH A as (
    select A.*
    ,   rank() over (order by counter_unique) rnk
    ,   B.jp as pokemon
    ,   C.jp as fastmove
    ,   D.jp as chargemove
    from win_lose A
    join localize_pokemon B on B.uid=A.uid
    join localize_fastmove C on C.uid=A.f_uid
    join localize_chargemove D on D.uid=A.c_uid
    where cap=1500
)
select 
    rnk, pokemon, 
    case when B.legacy then '▲' else '' end || fastmove ||  case when B.type in (type_1,type_2) then '☆' else '' end as fastmove,
    case when C.legacy then '▲' else '' end || chargemove || case when C.type in (type_1,type_2) then '☆' else '' end as chargemove,
    win, lose, win_b, lose_b, counter, counter_unique
from A
join pokemon_fastmove_combat B on B.pokemon_uid=A.uid and B.move_uid=A.f_uid
join pokemon_chargemove_combat C on C.pokemon_uid=A.uid and C.move_uid=A.c_uid
where true
and 'POISON' in (type_1,type_2)
and 'POISON' in (f_type,c_type)
order by rnk limit 20;


WITH A as (
    select A.*
    ,   rank() over (order by counter_unique) rnk
    ,   B.jp as pokemon
    ,   C.jp as fastmove
    ,   D.jp as chargemove
    from win_lose A
    join localize_pokemon B on B.uid=A.uid
    join localize_fastmove C on C.uid=A.f_uid
    join localize_chargemove D on D.uid=A.c_uid
    where cap=1500
)
select 
    rnk, pokemon, 
    case when B.legacy then '▲' else '' end || fastmove ||  case when B.type in (type_1,type_2) then '☆' else '' end as fastmove,
    case when C.legacy then '▲' else '' end || chargemove || case when C.type in (type_1,type_2) then '☆' else '' end as chargemove,
    win, lose, win_b, lose_b, counter, counter_unique
from A
join pokemon_fastmove_combat B on B.pokemon_uid=A.uid and B.move_uid=A.f_uid
join pokemon_chargemove_combat C on C.pokemon_uid=A.uid and C.move_uid=A.c_uid
where true
and 'STEEL' in (type_1,type_2)
--and 'STEEL' in (f_type,c_type)
order by rnk limit 20;


-- マスターリーグWATERトップティア
WITH A as (
    select A.*
    ,   rank() over (order by counter_unique) rnk
    ,   B.jp as pokemon
    ,   C.jp as fastmove
    ,   D.jp as chargemove
    from win_lose A
    join localize_pokemon B on B.uid=A.uid
    join localize_fastmove C on C.uid=A.f_uid
    join localize_chargemove D on D.uid=A.c_uid
    where cap=5500
)
select 
    rnk, pokemon, 
    case when B.legacy then '▲' else '' end || fastmove ||  case when B.type in (type_1,type_2) then '☆' else '' end as fastmove,
    case when C.legacy then '▲' else '' end || chargemove || case when C.type in (type_1,type_2) then '☆' else '' end as chargemove,
    win, lose, win_b, lose_b, counter, counter_unique
from A
join pokemon_fastmove_combat B on B.pokemon_uid=A.uid and B.move_uid=A.f_uid
join pokemon_chargemove_combat C on C.pokemon_uid=A.uid and C.move_uid=A.c_uid
where true
and 'WATER' in (type_1,type_2)
--and 'STEEL' in (f_type,c_type)
order by rnk limit 20;
 rnk |  pokemon   |    fastmove     |    chargemove    | win  | lose | win_b | lose_b | counter | counter_unique 
-----+------------+-----------------+------------------+------+------+-------+--------+---------+----------------
  27 | ギャラドス | ▲りゅうのいぶき | かみくだく       | 3709 |  266 |  3789 |    186 |     117 |             27
  35 | ミロカロス | ドラゴンテール  | なみのり☆        | 3760 |  215 |  3857 |    118 |      80 |             32
  38 | カイオーガ | たきのぼり☆     | かみなり         | 3791 |  184 |  3723 |    252 |     121 |             33
  47 | ギャラドス | ▲りゅうのいぶき | ハイドロポンプ☆  | 3710 |  265 |  3552 |    423 |     118 |             35
  47 | ギャラドス | ▲りゅうのいぶき | げきりん         | 3657 |  318 |  3665 |    310 |     197 |             35
  52 | ギャラドス | かみつく        | げきりん         | 3534 |  441 |  3733 |    242 |     165 |             37
  52 | シャワーズ | みずでっぽう☆   | アクアテール☆    | 3684 |  291 |  3838 |    137 |     129 |             37
  58 | オーダイル | ▲みずでっぽう☆  | ▲ハイドロカノン☆ | 3709 |  266 |  3789 |    186 |     124 |             38
  64 | カイオーガ | たきのぼり☆     | ふぶき           | 3738 |  237 |  3665 |    310 |     118 |             39
  64 | カイオーガ | たきのぼり☆     | ハイドロポンプ☆  | 3712 |  263 |  3665 |    310 |     149 |             39
  69 | ギャラドス | ▲りゅうのいぶき | ▲たつまき        | 3415 |  560 |  3709 |    266 |     246 |             40
  72 | キングドラ | りゅうのいぶき☆ | げきりん☆        | 3547 |  428 |  3576 |    399 |     271 |             41
  72 | キングドラ | りゅうのいぶき☆ | ハイドロポンプ☆  | 3545 |  430 |  3476 |    499 |     250 |             41
  77 | ギャラドス | かみつく        | ▲りゅうのはどう  | 3508 |  467 |  3733 |    242 |     177 |             42
  77 | ギャラドス | ▲りゅうのいぶき | ▲りゅうのはどう  | 3543 |  432 |  3646 |    329 |     259 |             42
  92 | シャワーズ | みずでっぽう☆   | ▲とっておき      | 3608 |  367 |  3681 |    294 |     185 |             45
  96 | カメックス | みずでっぽう☆   | ▲ハイドロカノン☆ | 3564 |  411 |  3693 |    282 |     180 |             46
 102 | ギャラドス | たきのぼり☆     | げきりん         | 3565 |  410 |  3390 |    585 |     271 |             47
 102 | ラグラージ | マッドショット☆ | なみのり☆        | 3611 |  364 |  3769 |    206 |     168 |             47
 114 | ギャラドス | かみつく        | かみくだく       | 3575 |  400 |  3757 |    218 |     190 |             48

カイオーガに対するカウンター

WITH A as(
select 
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('カイオーガ',5500,15,15,15,'たきのぼり','かみなり') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk=1 order by kill/death * kill_b/death_b;

WITH A as(
select 
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('カイオーガ',5500,15,15,15,'たきのぼり','ふぶき') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk=1 order by kill/death * kill_b/death_b;

WITH A as(
select 
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('カイオーガ',5500,15,15,15,'たきのぼり','ハイドロポンプ') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk=1 order by kill/death * kill_b/death_b;



WITH A as(
select 
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('メルメタル',5500,15,15,15,'でんきショック','１０まんボルト') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk=1 order by kill/death * kill_b/death_b;

WITH A as(
select 
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('メルメタル',5500,15,15,15,'でんきショック','いわなだれ') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk=1 order by kill/death * kill_b/death_b;




WITH A as(
select 
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('バンギラス',5500,15,15,15,'かみつく','かみくだく') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk=1 order by kill/death * kill_b/death_b;


WITH A as(
select 
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('バンギラス',5500,15,15,15,'うちおとす','ストーンエッジ') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk=1 order by kill/death * kill_b/death_b;


WITH A as(
select 
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('ニョロボン',5500,15,15,15,'あわ','ばくれつパンチ') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk=1 order by kill/death * kill_b/death_b;

WITH A as(
select 
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('トゲキッス',5500,15,15,15,'エアスラッシュ','マジカルシャイン') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk<3 order by kill/death * kill_b/death_b;





