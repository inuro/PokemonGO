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
    join localize_pokemon B on B.uid=A.pokemon
    join localize_fastmove C on C.uid=A.fastmove
    join localize_chargemove D on D.uid=A.chargemove
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
from calc_counter_combat('DIALGA',5500,15,15,15,'DRAGON_BREATH','DRACO_METEOR') A
join pokemon F on F.uid=A.uid
where kill/death < 1.0 and kill_b/death_b<1.0
)
select * from A where rnk<3 order by kill/death * kill_b/death_b;

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
from calc_counter_combat('DIALGA',5500,15,15,15,'DRAGON_BREATH','IRON_HEAD') A
join pokemon F on F.uid=A.uid
where death > kill and death_b > kill_b
)
select * from A order by kill/death * kill_b/death_b;



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
from calc_counter_combat('DIALGA',5500,15,15,15,'DRAGON_BREATH','DRACO_METEOR') A
join pokemon F on F.uid=A.uid
where A.uid=puid('メタグロス')
--where death > kill and death_b > kill_b
)
select * from A order by kill/death * kill_b/death_b;


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
from calc_counter_combat('DIALGA',5500,15,15,15,'DRAGON_BREATH','DRACO_METEOR') A
join pokemon F on F.uid=A.uid
where A.uid=puid('マンムー')
--where death > kill and death_b > kill_b
)
select * from A order by kill/death * kill_b/death_b;



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
    --A.kill_b, 
    --A.death_b,
    --ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('カビゴン',5500,15,15,15,'しねんのずつき','ヘビーボンバー') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk=1 order by kill/death;





-- PvPで、1サイクルの時間とDPSでの順位

--　能力値考慮せず技性能のみ
with a as(select A.*,round((c_ene::numeric/f_ene)*f_dur,1) as time,round(((c_ene::numeric/f_ene)*f_stab_pow+c_stab_pow)/((c_ene::numeric/f_ene)*f_dur),2) as dps from pokemon_pattern_combat A left join _not_yet B on B.uid=A.pokemon_uid where B.uid is null) select * from A order by dps desc, time;

-- 能力値を考慮した値（青天井：マスターリーグ向き）
with A as(
    select 
        A.*, B.hp,B.at,B.df,C.jp
    from pokemon_pattern_combat A 
    left join pokemon B on B.uid=A.pokemon_uid
    left join localize_pokemon C on C.uid=A.pokemon_uid
    where B.available=true
),
B as(
    select
        *,
        round((c_ene::numeric/f_ene)*f_dur,1) as cycle,
        round(at * ((c_ene::numeric/f_ene)*f_stab_pow+c_stab_pow) / ((c_ene::numeric/f_ene)*f_dur),2) as dps
    from A
)
select
    index,pokemon_uid,jp,type_1,type_2,f_uid,f_type,f_dur,f_ene,f_stab_pow,c_uid,c_type,c_ene,c_stab_pow,cycle,dps
from B
order by dps desc, cycle;

 index |    pokemon_uid    |                jp                 |  type_1  |  type_2  |     f_uid     |  f_type  | f_dur | f_ene | f_stab_pow |       c_uid        |  c_type  | c_ene | c_stab_pow | cycle |   dps   
-------+-------------------+-----------------------------------+----------+----------+---------------+----------+-------+-------+------------+--------------------+----------+-------+------------+-------+---------
   386 | DEOXYS_ATTACK     | デオキシス (アタックフォルム)     | PSYCHIC  |          | POISON_JAB    | POISON   |   1.0 |     7 |        6.0 | PSYCHO_BOOST       | PSYCHIC  |    40 |       84.0 |   5.7 | 8569.80
   150 | MEWTWO_NORMAL     | ミュウツー                        | PSYCHIC  |          | PSYCHO_CUT    | PSYCHIC  |   1.0 |     9 |        3.6 | PSYSTRIKE          | PSYCHIC  |    45 |      108.0 |   5.0 | 7560.00
   386 | DEOXYS_NORMAL     | デオキシス (ノーマルフォルム)     | PSYCHIC  |          | CHARGE_BEAM   | ELECTRIC |   1.5 |    11 |        5.0 | PSYCHO_BOOST       | PSYCHIC  |    40 |       84.0 |   5.5 | 6463.00
   473 | MAMOSWINE         | マンムー                          | ICE      | GROUND   | POWDER_SNOW   | ICE      |   1.0 |     8 |        4.8 | AVALANCHE          | ICE      |    45 |      108.0 |   5.6 | 5928.00
   260 | SWAMPERT_NORMAL   | ラグラージ                        | WATER    | GROUND   | MUD_SHOT      | GROUND   |   1.0 |     9 |        3.6 | HYDRO_CANNON       | WATER    |    40 |      108.0 |   4.4 | 5803.20


-- 能力値を考慮した値（相対値：ハイパー・スーパーリーグ向き）
with A as(
    select 
        A.*, B.hp,B.at,B.df,C.jp
    ,   B.at::numeric/(B.hp+B.at+B.df)*100 as at_percentage
    from pokemon_pattern_combat A 
    left join pokemon B on B.uid=A.pokemon_uid
    left join localize_pokemon C on C.uid=A.pokemon_uid
    where B.available=true
),
B as(
    select
        *,
        round((c_ene::numeric/f_ene)*f_dur,1) as cycle,
        round(ceil(c_ene::numeric/f_ene)*f_dur,1) as cycle_t,
        round(at_percentage * ((c_ene::numeric/f_ene)*f_stab_pow+c_stab_pow) / ((c_ene::numeric/f_ene)*f_dur),0) as dps
    from A
)
select
    index,pokemon_uid,jp,type_1,type_2,f_uid,f_type,f_dur,f_ene,f_stab_pow,c_uid,c_type,c_ene,c_stab_pow,cycle,cycle_t,dps
from B
where cycle<8.0
order by dps desc, cycle;



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
from calc_counter_combat('ハクリュー',1500,15,15,15,'りゅうのいぶき','りゅうのはどう') A
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
from calc_counter_combat('テラキオン',5500,15,15,15,'しねんのずつき','CLOSE_COMBAT') A
join pokemon F on F.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
)
select * from A where rnk=1 order by kill/death * kill_b/death_b;



WITH A as(
select 
    A.index,
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
from calc_counter_combat('ラプラス',1500,15,15,15,'こおりのいぶき','ハイドロポンプ') A
join pokemon F on F.uid=A.uid
)
select * from A where true 
order by kill/death * kill_b/death_b;


WITH A as(
select 
    A.index,
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
from calc_counter_combat('VICTREEBEL_NORMAL',1500,15,15,15,'RAZOR_LEAF','LEAF_BLADE') A
join pokemon F on F.uid=A.uid
)
select * from A where true 
order by kill/death * kill_b/death_b;




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
from calc_counter_combat('KINGDRA',1500,15,15,15,'DRAGON_BREATH','OUTRAGE') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A order by kill/death * kill_b/death_b;

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
from calc_counter_combat('KINGDRA',1500,15,15,15,'DRAGON_BREATH','OCTAZOOKA') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A order by kill/death * kill_b/death_b;



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
from calc_counter_combat('KINGDRA',1500,15,15,15,'DRAGON_BREATH','BLIZZARD') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A order by kill/death * kill_b/death_b;




select 
B.jp,C.jp,D.jp,
A.* 
from win_lose_fusion A
join localize_pokemon B on B.uid=A.pokemon
join localize_fastmove C on C.uid=A.fastmove
join localize_chargemove D on D.uid=A.chargemove
order by win_unique desc;



-- チルタリス
--　キュウコン（アローラ）
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
from calc_counter_combat('ALTARIA',1500,15,15,15,'DRAGON_BREATH','SKY_ATTACK') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A where rnk=1
order by kill/death * kill_b/death_b;



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
from calc_counter_combat('ALTARIA',1500,15,15,15,'DRAGON_BREATH','DAZZLING_GLEAM') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A where rnk=1
order by kill/death * kill_b/death_b;



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
from calc_counter_combat('ALTARIA',1500,15,15,15,'DRAGON_BREATH','DRAGON_PULSE') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A where rnk=1
order by kill/death * kill_b/death_b;


WITH A1 as(
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
from calc_counter_combat('ALTARIA',1500,15,15,15,'DRAGON_BREATH','DRAGON_PULSE') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
A2 as(
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
from calc_counter_combat('ALTARIA',1500,15,15,15,'DRAGON_BREATH','DAZZLING_GLEAM') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
A3 as(
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
from calc_counter_combat('ALTARIA',1500,15,15,15,'DRAGON_BREATH','SKY_ATTACK') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
B as (
    select * from A1 where rnk=1
    union all
    select * from A2 where rnk=1
    union all
    select * from A3 where rnk=1
)
select distinct * from B;
order by kill/death * kill_b/death_b;



-- KINGDRA
WITH A1 as(
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
from calc_counter_combat('KINGDRA',1500,15,15,15,'DRAGON_BREATH','OCTAZOOKA') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
A2 as(
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
from calc_counter_combat('KINGDRA',1500,15,15,15,'DRAGON_BREATH','OUTRAGE') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
A3 as(
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
from calc_counter_combat('KINGDRA',1500,15,15,15,'DRAGON_BREATH','BLIZZARD') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
B as (
    select * from A1 where rnk=1
    union all
    select * from A2 where rnk=1
    union all
    select * from A3 where rnk=1
)
select distinct * from B;
order by kill/death * kill_b/death_b;




-- WIGGLYTUFF
WITH A1 as(
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
from calc_counter_combat('WIGGLYTUFF',1500,15,15,15,'CHARM','PLAY_ROUGH') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
A2 as(
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
from calc_counter_combat('WIGGLYTUFF',1500,15,15,15,'CHARM','ICE_BEAM') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
A3 as(
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
from calc_counter_combat('WIGGLYTUFF',1500,15,15,15,'CHARM','HYPER_BEAM') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
B as (
    select * from A1 where rnk=1
    union all
    select * from A2 where rnk=1
    union all
    select * from A3 where rnk=1
)
select distinct * from B;
order by kill/death * kill_b/death_b;



-- NINETALES_ALOLA
WITH A1 as(
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
from calc_counter_combat('NINETALES_ALOLA',1500,15,15,15,'POWDER_SNOW','ICE_BEAM') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
A2 as(
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
from calc_counter_combat('NINETALES_ALOLA',1500,15,15,15,'POWDER_SNOW','DAZZLING_GLEAM') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
A3 as(
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
from calc_counter_combat('NINETALES_ALOLA',1500,15,15,15,'POWDER_SNOW','PSYSHOCK') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
),
B as (
    select * from A1 where rnk=1
    union all
    select * from A2 where rnk=1
    union all
    select * from A3 where rnk=1
)
select distinct * from B;
order by kill/death * kill_b/death_b;






-- SANDSLASH_ALOLA
WITH A1 as(
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
from calc_counter_combat('SANDSLASH_ALOLA',1500,15,15,15,'POWDER_SNOW','ICE_PUNCH') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A1
order by kill/death;


-- FARFETCHD
WITH A1 as(
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
from calc_counter_combat('FARFETCHD',1500,15,15,15,'AIR_SLASH','LEAF_BLADE') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A1
order by kill/death;


WITH A1 as(
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
from calc_counter_combat('RATICATE_ALOLA',1500,15,15,15,'BITE','HYPER_FANG') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A1
order by kill/death;


 BRONZONG           | CONFUSION     | PSYCHIC   


 WITH A1 as(
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
from calc_counter_combat('BRONZONG',1500,15,15,15,'CONFUSION','PSYCHIC') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A1
order by kill/death;


 WITH A1 as(
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
from calc_counter_combat('WHISCASH',1500,15,15,15,'MUD_SHOT','BLIZZARD') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A1
order by kill/death;



 select B.jp,C.jp,D.jp,A.* from win_lose_fusion A join localize_pokemon B on B.uid=A.pokemon join localize_fastmove C on C.uid=A.fastmove join localize_chargemove D on D.uid=A.chargemove 
 join pokemon_fastmove_combat E on E.pokemon_uid=A.pokemon and E.move_uid=A.fastmove
 where E.type='GRASS'
 order by win desc;



WITH A1 as(
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
from calc_counter_combat('RATICATE_ALOLA',1500,15,15,15,'BITE','CRUNCH') A
join pokemon F on F.uid=A.uid
join localize_pokemon G on G.uid=A.uid
join fusion_cup H on H.en=G.en
where kill/death < 0.80 and kill_b/death_b<0.80
and H.en is not null
)
select * from A1
order by kill/death;

