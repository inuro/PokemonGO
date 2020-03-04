select B.pokemon_id, B.form_id, B.uid, '322' as move, false::boolean as legacy from _stats A join _stats B on B.uid=concat(substring(A.uid for position('_' in A.uid)),'NORMAL') where A.uid~'_SHADOW'



select C.uid, B.*, A.power,A.duration,A.energy, 
COALESCE(Round(A.power::numeric/A.duration*1000,1),0) as dps,  
COALESCE(Round(A.energy::numeric/A.duration*1000,1),0) as eps
from _fastmove A left join localize_fastmove B using (uid) join localize_type C on C.index=A.type;



select C.uid, B.*, A.power,A.duration,A.energy, 
COALESCE(Round(A.power::numeric/((A.duration+1)*0.5),1),0) as dps,  
COALESCE(Round(A.energy::numeric/((A.duration+1)*0.5),1),0) as eps
from _fastmove_combat A left join localize_fastmove B using (uid) join localize_type C on C.index=A.type
--where c.uid='WATER' 
order by dps desc
;

select C.uid, B.*, A.power,A.energy
from _chargemove_combat A left join localize_chargemove B using (uid) join localize_type C on C.index=A.type
where energy % 9 = 0;


select C.uid, B.*, A.power,A.duration,A.energy, 
COALESCE(Round(A.power::numeric/((A.duration+1)*0.5),1),0) as dps,  
COALESCE(Round(A.energy::numeric/((A.duration+1)*0.5),1),0) as eps
from _fastmove_combat A left join localize_fastmove B using (uid) join localize_type C on C.index=A.type 
order by eps desc
;
select C.uid, B.*, A.power,A.energy
from _chargemove_combat A left join localize_chargemove B using (uid) join localize_type C on C.index=A.type
where energy % 8 = 0;

   uid    | index |     uid      |       jp       |      en      | power | duration | energy | dps | eps 
 ICE      | 244   | POWDER_SNOW   | こなゆき       | Powder Snow   |     4 |        1 |      8 |  4.0 | 8.0
 BUG      | 200   | FURY_CUTTER   | れんぞくぎり   | Fury Cutter   |     2 |        0 |      4 |  4.0 | 8.0
 GRASS    | 214   | VINE_WHIP     | つるのムチ     | Vine Whip     |     5 |        1 |      8 |  5.0 | 8.0
 NORMAL   | 291   | PRESENT       | プレゼント     | Present       |     3 |        2 |     12 |  2.0 | 8.0
 GHOST    | 213   | SHADOW_CLAW   | シャドークロー | Shadow Claw   |     6 |        1 |      8 |  6.0 | 8.0
 ELECTRIC | 206   | SPARK         | スパーク       | Spark         |     4 |        1 |      8 |  4.0 | 8.0


   uid    | index |         uid          |              jp              |          en           | power | energy 
 ICE      | 33    | ICE_PUNCH            | れいとうパンチ               | Ice Punch             |    55 |     40
 GRASS    | 312   | LEAF_TORNADO         | グラスミキサー               | Leaf Tornado          |    45 |     40
 GRASS    | 116   | SOLAR_BEAM           | ソーラービーム               | Solar Beam            |   150 |     80
 GRASS    | 59    | SEED_BOMB            | タネばくだん                 | Seed Bomb             |    55 |     40
 GRASS    | 114   | GIGA_DRAIN           | ギガドレイン                 | Giga Drain            |    50 |     80
 NORMAL   | 323   | RETURN               | おんがえし                   | Return                |    50 |     40
 NORMAL   | 322   | FRUSTRATION          | やつあたり                   | Frustration           |    10 |     40
 NORMAL   | 20    | VICE_GRIP            | はさむ                       | Vice Grip             |    40 |     40
 NORMAL   | 127   | STOMP                | ふみつけ                     | Stomp                 |    55 |     40
 NORMAL   | 14    | HYPER_BEAM           | はかいこうせん               | Hyper Beam            |   150 |     80
 GHOST    | 69    | OMINOUS_WIND         | あやしいかぜ                 | Ominous Wind          |    50 |     40
 ELECTRIC | 252   | ZAP_CANNON           | でんじほう                   | Zap Cannon            |   150 |     80
 ELECTRIC | 77    | THUNDER_PUNCH        | かみなりパンチ               | Thunder Punch         |    55 |     40


[EPS=9]
でんきショック＋ほうでん -> ピカチュウ、コイル、レアコイル、サンダース、サンダー（レガシー）、メリープ、エレキッド

[EPS=8]
こなゆき＋れいとうパンチ -> ムチュール
つるのムチ＋タネばくだん -> フシギダネ
つるのムチ＋ソーラービーム -> フシギバナ、フシギソウ、モンジャラ、メガニウム、モジャンボ
シャドークロー＋あやしいかぜ -> ギラティナ（オリジンフォーム）
スパーク＋かみなりパンチ -> ライチュウ、ライチュウ（アローラのすがた）、パチリス
スパーク＋でんじほう -> レアコイル、ジバコイル


[Chargemove: Damage per Energy]
select C.uid, B.*, A.power,A.energy
, Round(A.power::numeric/A.energy,2) as DPE     
from _chargemove_combat A left join localize_chargemove B using (uid) join localize_type C on C.index=A.type
--order by energy
order by A.power::numeric/A.energy desc
;

[ハイドロカノン]
たきのぼり＋ハイドロカノン -> オーダイル
select * from pokemon_pattern_combat where f_uid='WATERFALL' and c_uid='HYDRO_CANNON';


select C.uid, B.*, A.power,A.duration,A.energy, 
COALESCE(Round(A.power::numeric/((A.duration+1)*0.5),1),0) as dps,  
COALESCE(Round(A.energy::numeric/((A.duration+1)*0.5),1),0) as eps
from _fastmove_combat A left join localize_fastmove B using (uid) join localize_type C on C.index=A.type 
where energy in (3,5,9)
order by C.uid   
;




select 
A.pokemon_uid,A.type_1,A.type_2,floor((B.at+15) * 0.79030001)::INTEGER as at,
A.f_uid,A.f_type,A.f_pow,A.f_dur,A.f_ene,A.f_leg,A.f_stab_pow*at
floor((B.at+15) * 0.79030001)::INTEGER as at
from pokemon_pattern_combat A
join pokemon B on A.pokemon_uid=B.uid

where c_uid='LEAF_BLADE';



With A as(
    select A.*, floor((B.at+15) * 0.79030001)::INTEGER as at, C.jp as jp
    from pokemon_pattern_combat A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
)
, B as(
    select *, 
    case when A.f_leg then 'T' else null end as f_l, 
    (A.f_stab_pow*A.at) as f_dmg,
    case when A.c_leg then 'T' else null end as c_l, 
    (A.c_stab_pow*A.at) as c_dmg,
    Ceil(c_ene::numeric / f_ene) as f_cnt
    from A
)
, C as(
    select *,
    Round(f_dmg/f_dur, 1) as f_dps,
    f_cnt * f_dmg + c_dmg as t_dmg,
    f_cnt * f_dur as t_time,
    Round((f_cnt * f_dmg + c_dmg) / (f_cnt * f_dur), 1) as t_dps
    from B
)
select 
pokemon_uid, jp, type_1,type_2,at,
f_uid,f_type,f_pow,f_dur,f_ene, f_l, f_dmg, f_dps,
c_uid,c_type,c_pow,c_ene, c_l, c_dmg,
f_cnt, t_dmg, t_time,t_dps
from C
where c_uid='LEAF_BLADE'
;



[LV40:100% わざの強さ 対戦]

With A as(
    select A.*, 
    floor((B.at+15) * 0.79030001)::INTEGER as at, 
    floor((B.df+15) * 0.79030001)::INTEGER as df, 
    floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
    C.jp as jp
    from pokemon_pattern_combat A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    where B.available=true
)
, B as(
    select *, 
    case when A.f_leg then 'T' else null end as f_l, 
    (A.f_stab_pow*A.at) as f_dmg,
    case when A.c_leg then 'T' else null end as c_l, 
    (A.c_stab_pow*A.at) as c_dmg,
    Ceil(c_ene::numeric / f_ene) as f_cnt,
    df * hp as ac
    from A
)
, C as(
    select *,
    Round(f_dmg/f_dur, 1) as f_dps,
    f_cnt * f_dmg + c_dmg as t_dmg,
    f_cnt * f_dur as t_time,
    Round((f_cnt * f_dmg + c_dmg) / (f_cnt * f_dur), 1) as t_dps
    from B
)
select 
pokemon_uid, jp, type_1,type_2,at,ac,
f_uid,f_type,f_pow,f_dur,f_ene, f_l, f_dmg, f_dps,
c_uid,c_type,c_pow,c_ene, c_l, c_dmg,
f_cnt, t_dmg, t_time,t_dps
, Round((ac::numeric*t_dps)/100000) as score
from C
where c_type='WATER' and 'WATER' in (type_1,type_2)
--order by t_dps desc
order by ac*t_dps desc
;



With A as(
    select A.*, 
    floor((B.at+15) * 0.79030001)::INTEGER as at, 
    floor((B.df+15) * 0.79030001)::INTEGER as df, 
    floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
    C.jp as jp
    from pokemon_pattern_combat A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    where B.available=true
)
, B as(
    select *, 
    case when A.f_leg then 'T' else null end as f_l, 
    (A.f_stab_pow*A.at) as f_dmg,
    case when A.c_leg then 'T' else null end as c_l, 
    (A.c_stab_pow*A.at) as c_dmg,
    Ceil(c_ene::numeric / f_ene) as f_cnt,
    df * hp as ac
    from A
)
, C as(
    select *,
    Round(f_dmg/f_dur, 1) as f_dps,
    f_cnt * f_dmg + c_dmg as t_dmg,
    f_cnt * f_dur as t_time,
    Round((f_cnt * f_dmg + c_dmg) / (f_cnt * f_dur), 1) as t_dps
    from B
)
select 
pokemon_uid, jp, type_1,type_2,at,ac,
f_uid,f_type,f_pow,f_dur,f_ene, f_l, f_dmg, f_dps,
c_uid,c_type,c_pow,c_ene, c_l, c_dmg,
f_cnt, t_dmg, t_time,t_dps
, Round((ac::numeric*t_dps)/100000) as score
from C
where c_type='FIRE' 
and 'FIRE' in (type_1,type_2)
--order by t_dps desc
order by ac*t_dps desc
;

With A as(
    select A.*, 
    floor((B.at+15) * 0.79030001)::INTEGER as at, 
    floor((B.df+15) * 0.79030001)::INTEGER as df, 
    floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
    C.jp as jp
    from pokemon_pattern_combat A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    where B.available=true
)
, B as(
    select *, 
    case when A.f_leg then 'T' else null end as f_l, 
    (A.f_stab_pow*A.at) as f_dmg,
    case when A.c_leg then 'T' else null end as c_l, 
    (A.c_stab_pow*A.at) as c_dmg,
    Ceil(c_ene::numeric / f_ene) as f_cnt,
    df * hp as ac
    from A
)
, C as(
    select *,
    Round(f_dmg/f_dur, 1) as f_dps,
    f_cnt * f_dmg + c_dmg as t_dmg,
    f_cnt * f_dur as t_time,
    Round((f_cnt * f_dmg + c_dmg) / (f_cnt * f_dur), 1) as t_dps
    from B
)
select 
pokemon_uid, jp, type_1,type_2,at,ac,
f_uid,f_type,f_pow,f_dur,f_ene, f_l, f_dmg, f_dps,
c_uid,c_type,c_pow,c_ene, c_l, c_dmg,
f_cnt, t_dmg, t_time,t_dps
, Round((ac::numeric*t_dps)/100000) as score
from C
where c_type='GRASS' 
and 'GRASS' in (type_1,type_2)
--order by t_dps desc
order by ac*t_dps desc
;



With A as(
    select A.*, 
    floor((B.at+15) * 0.79030001)::INTEGER as at, 
    floor((B.df+15) * 0.79030001)::INTEGER as df, 
    floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
    C.jp as jp
    from pokemon_pattern_combat A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    where B.available=true
)
, B as(
    select *, 
    case when A.f_leg then 'T' else null end as f_l, 
    (A.f_stab_pow*A.at) as f_dmg,
    case when A.c_leg then 'T' else null end as c_l, 
    (A.c_stab_pow*A.at) as c_dmg,
    Ceil(c_ene::numeric / f_ene) as f_cnt,
    df * hp as ac
    from A
)
, C as(
    select *,
    Round(f_dmg/f_dur, 1) as f_dps,
    f_cnt * f_dmg + c_dmg as t_dmg,
    f_cnt * f_dur as t_time,
    Round((f_cnt * f_dmg + c_dmg) / (f_cnt * f_dur), 1) as t_dps
    from B
)
select 
pokemon_uid, jp, type_1,type_2,at,ac,
f_uid,f_type,f_pow,f_dur,f_ene, f_l, f_dmg, f_dps,
c_uid,c_type,c_pow,c_ene, c_l, c_dmg,
f_cnt, t_dmg, t_time,t_dps
, Round((ac::numeric*t_dps)/100000) as score
from C
where true
--and c_type='GRASS' 
--and 'GRASS' in (type_1,type_2)
--order by t_dps desc
--order by ac*t_dps desc
order by t_time,score desc, t_dps desc
;


-- [対戦相手なしで技の火力を調べる：バトル]
With A as(
    select A.*, 
    floor((B.at+15) * 0.79030001)::INTEGER as at, 
    floor((B.df+15) * 0.79030001)::INTEGER as df, 
    floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
    C.jp as jp
    from pokemon_pattern_combat A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    where B.available=true
)
, B as(
    select *, 
    case when A.f_leg then 'T' else null end as f_l, 
    (A.f_stab_pow*A.at) as f_dmg,
    case when A.c_leg then 'T' else null end as c_l, 
    (A.c_stab_pow*A.at) as c_dmg,
    Ceil(c_ene::numeric / f_ene) as f_cnt,
    df * hp as ac
    from A
)
, C as(
    select *,
    Round(f_dmg/f_dur, 1) as f_dps,
    f_cnt * f_dmg + c_dmg as t_dmg,
    f_cnt * f_dur as t_time,
    Round((f_cnt * f_dmg + c_dmg) / (f_cnt * f_dur), 1) as t_dps
    from B
)
select 
pokemon_uid, jp, type_1,type_2,at,ac,
f_uid,f_type,f_pow,f_dur,f_ene, f_l, f_dmg, f_dps,
c_uid,c_type,c_pow,c_ene, c_l, c_dmg,
f_cnt, t_dmg, t_time,t_dps
, Round((ac::numeric*t_dps)/100000) as score
from C
where c_type='ELECTRIC' 
and 'ELECTRIC' in (type_1,type_2)
order by ac*t_dps desc
;


-- [対戦相手なしで技の火力を調べる：レイド＆ジム]
With A as(
    select A.*, 
    floor((B.at+15) * 0.79030001)::INTEGER as at, 
    floor((B.df+15) * 0.79030001)::INTEGER as df, 
    floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
    C.jp as jp
    from pokemon_pattern A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    where B.available=true
)
, B as(
    select *, 
    case when A.f_leg then 'T' else null end as f_l, 
    (A.f_stab_pow*A.at) as f_dmg,
    case when A.c_leg then 'T' else null end as c_l, 
    (A.c_stab_pow*A.at) as c_dmg,
    ceil(c_ene::numeric / f_ene) as f_cnt,
    df * hp as ac
    from A
)
, C as(
    select *,
    Round(f_dmg/f_dur, 1) as f_dps,
    f_cnt * f_dmg + c_dmg as t_dmg,
    Round(f_cnt * f_dur + c_dur, 1) as t_time,
    Round((f_cnt * f_dmg + c_dmg) / (f_cnt * f_dur + c_dur), 1) as t_dps
    from B
)
select 
pokemon_uid, jp, type_1,type_2,at,ac,
f_uid,f_type,f_pow,Round(f_dur,1) as f_dur,f_ene, f_l, f_dmg, f_dps,
c_uid,c_type,c_pow,c_ene, c_l, c_dmg,
f_cnt, t_dmg, t_time,t_dps
, Round((ac::numeric*t_dps)/100000) as score
from C
where true
--and pokemon_uid~'SNORLAX'
--and c_type='ICE' 
--and 'ICE' in (type_1,type_2)
--order by t_dps desc
order by ac*t_dps desc
;






-- [あるポケモンに対して、全ポケモンパターンでバトルのDPSなどを調べる]

With  X as(
-- Target Pokemon
    select
        B.uid as x_uid, A.type_1 as x_type_1, A.type_2 as x_type_2, 
        A.f_type as x_f_type, A.f_stab_pow as x_f_stab_pow, A.f_dur as x_f_dur, A.f_ene as x_f_ene,
        A.c_type as x_c_type, A.c_stab_pow as x_c_stab_pow, A.c_ene as x_c_ene,
        floor((B.at+15) * 0.79030001)::INTEGER as x_at, 
        floor((B.df+15) * 0.79030001)::INTEGER as x_df, 
        floor((B.hp+15) * 0.79030001)::INTEGER as x_hp
    from pokemon_pattern_combat A 
    join pokemon B on A.pokemon_uid=B.uid
--    where B.uid=puid('カビゴン') and A.f_uid=get_move_uid('しねんのずつき') and A.c_uid=get_move_uid('はかいこうせん')
    where B.uid=puid('カビゴン') and A.f_uid=get_move_uid('したでなめる') and A.c_uid=get_move_uid('はかいこうせん')
--    where B.uid=puid('DIALGA') and A.f_uid=get_move_uid('りゅうのいぶき') and A.c_uid=get_move_uid('りゅうせいぐん')
)
,A as(
-- Challenger Pokemon and effectiveness
    select 
        A.*, 
        floor((B.at+15) * 0.79030001)::INTEGER as at, 
        floor((B.df+15) * 0.79030001)::INTEGER as df, 
        floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
        C.jp as jp,
        X.*,
        EF1.mlp * (case when EF2.mlp is null then 1.0 else EF2.mlp end) as ef_f,
        EC1.mlp * (case when EC2.mlp is null then 1.0 else EC2.mlp end) as ef_c,
        XEF1.mlp * (case when XEF2.mlp is null then 1.0 else XEF2.mlp end) as x_ef_f,
        XEC1.mlp * (case when XEC2.mlp is null then 1.0 else XEC2.mlp end) as x_ef_c
    from pokemon_pattern_combat A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    join X on true
    left join effectiveness EF1 on EF1.attacker=A.f_type and EF1.defender=X.x_type_1
    left join effectiveness EF2 on EF2.attacker=A.f_type and EF2.defender=X.x_type_2
    left join effectiveness EC1 on EC1.attacker=A.c_type and EC1.defender=X.x_type_1
    left join effectiveness EC2 on EC2.attacker=A.c_type and EC2.defender=X.x_type_2
    left join effectiveness XEF1 on XEF1.attacker=X.x_f_type and XEF1.defender=A.type_1
    left join effectiveness XEF2 on XEF2.attacker=X.x_f_type and XEF2.defender=A.type_2
    left join effectiveness XEC1 on XEC1.attacker=X.x_c_type and XEC1.defender=A.type_1
    left join effectiveness xEC2 on XEC2.attacker=X.x_c_type and XEC2.defender=A.type_2
    where B.available=true
)
, B as(
-- damage calculate
    select *, 
    (A.f_stab_pow * A.at * A.ef_f * 0.5 / A.x_df) + 1 as f_dmg,
    (A.c_stab_pow * A.at * A.ef_c * 0.5 / A.x_df) + 1 as c_dmg,
    (A.x_f_stab_pow * A.x_at * A.x_ef_f * 0.5 / A.df) + 1 as x_f_dmg,
    (A.x_c_stab_pow * A.x_at * A.x_ef_c * 0.5 / A.df) + 1 as x_c_dmg,
    Ceil(c_ene::numeric / f_ene) as f_cnt,
    Ceil(x_c_ene::numeric / x_f_ene) as x_f_cnt,
    case when A.f_leg then 'T' else null end as f_l, 
    case when A.c_leg then 'T' else null end as c_l, 
    df * hp as ac
    from A
)
, C as(
-- dps calculate
    select *,
    Round((100 * f_dmg / x_hp) / f_dur, 1) as f_dps,
    Round(100 * (f_cnt * f_dmg + c_dmg) / x_hp, 1) as t_dmg,
    f_cnt * f_dur as t_time,
    Round((100 * (f_cnt * f_dmg + c_dmg) / x_hp) / (f_cnt * f_dur), 1) as t_dps,

    Round((100 * x_f_dmg / hp) /x_f_dur, 1) as x_f_dps,
    Round(100 * (x_f_cnt * x_f_dmg + x_c_dmg) / hp, 1) as x_t_dmg,
    x_f_cnt * x_f_dur as x_t_time,
    Round((100 * (x_f_cnt * x_f_dmg + x_c_dmg) / hp) / (x_f_cnt * x_f_dur), 1) as x_t_dps

    from B
)
select 
    pokemon_uid,f_uid,c_uid,
    C.jp,FM.jp,CM.jp,
    f_dps,t_dps,t_dmg,t_time,
    x_f_dps,x_t_dps, 
    Round(f_dps / x_f_dps, 1) as scr_ff,
    Round(t_dps / x_f_dps, 1) as scr_tf,
    Round(t_dps / x_t_dps, 1) as scr_tt
from C
join localize_fastmove FM on FM.uid=f_uid
join localize_chargemove CM on CM.uid=c_uid
order by t_dps / x_f_dps desc
--order by t_dps / x_t_dps desc
;




-- [レイド版]
-- レイドランクによって、HPが[600,1800,3600,9000,15000]、MLPが[0.61,0.67,0.73,0.79,0.79]
With  X as(
-- Target Pokemon
    select
        B.uid as x_uid, A.type_1 as x_type_1, A.type_2 as x_type_2, 
        A.f_type as x_f_type, A.f_stab_pow as x_f_stab_pow, A.f_dur as x_f_dur, A.f_ene as x_f_ene,
        A.c_type as x_c_type, A.c_stab_pow as x_c_stab_pow, A.c_dur as x_c_dur, A.c_ene as x_c_ene,
        floor((B.at+15) * 0.79030001)::INTEGER as x_at, 
        floor((B.df+15) * 0.79030001)::INTEGER as x_df, 
        15000::numeric as x_hp
        --floor((B.hp+15) * 0.79030001)::INTEGER as x_hp
    from pokemon_pattern A 
    join pokemon B on A.pokemon_uid=B.uid
--    where B.uid=puid('カビゴン') and A.f_uid=get_move_uid('したでなめる') and A.c_uid=get_move_uid('はかいこうせん')
    where B.uid=puid('ミュウツー') and A.f_uid=get_move_uid('サイコカッター') and A.c_uid=get_move_uid('サイコブレイク')
)
,A as(
-- Challenger Pokemon and effectiveness
    select 
        A.*, 
        floor((B.at+15) * 0.79030001)::INTEGER as at, 
        floor((B.df+15) * 0.79030001)::INTEGER as df, 
        floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
        C.jp as jp,
        X.*,
        EF1.mlp * (case when EF2.mlp is null then 1.0 else EF2.mlp end) as ef_f,
        EC1.mlp * (case when EC2.mlp is null then 1.0 else EC2.mlp end) as ef_c,
        XEF1.mlp * (case when XEF2.mlp is null then 1.0 else XEF2.mlp end) as x_ef_f,
        XEC1.mlp * (case when XEC2.mlp is null then 1.0 else XEC2.mlp end) as x_ef_c
    from pokemon_pattern A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    join X on true
    left join effectiveness EF1 on EF1.attacker=A.f_type and EF1.defender=X.x_type_1
    left join effectiveness EF2 on EF2.attacker=A.f_type and EF2.defender=X.x_type_2
    left join effectiveness EC1 on EC1.attacker=A.c_type and EC1.defender=X.x_type_1
    left join effectiveness EC2 on EC2.attacker=A.c_type and EC2.defender=X.x_type_2
    left join effectiveness XEF1 on XEF1.attacker=X.x_f_type and XEF1.defender=A.type_1
    left join effectiveness XEF2 on XEF2.attacker=X.x_f_type and XEF2.defender=A.type_2
    left join effectiveness XEC1 on XEC1.attacker=X.x_c_type and XEC1.defender=A.type_1
    left join effectiveness xEC2 on XEC2.attacker=X.x_c_type and XEC2.defender=A.type_2
    where B.available=true
)
, B as(
-- damage calculate
    select *, 
    (A.f_stab_pow * A.at * A.ef_f * 0.5 / A.x_df) + 1 as f_dmg,
    (A.c_stab_pow * A.at * A.ef_c * 0.5 / A.x_df) + 1 as c_dmg,
    (A.x_f_stab_pow * A.x_at * A.x_ef_f * 0.5 / A.df) + 1 as x_f_dmg,
    (A.x_c_stab_pow * A.x_at * A.x_ef_c * 0.5 / A.df) + 1 as x_c_dmg,
    (c_ene::numeric / f_ene) as f_cnt,
    (x_c_ene::numeric / x_f_ene) as x_f_cnt,
    case when A.f_leg then 'T' else null end as f_l, 
    case when A.c_leg then 'T' else null end as c_l, 
    df * hp as ac
    from A
)
, C as(
-- dps calculate
    select *,
    Round((100 * f_dmg / x_hp) / f_dur, 3) as f_dps,
    Round(100 * (f_cnt * f_dmg + c_dmg) / x_hp, 3) as t_dmg,
    Round(f_cnt * f_dur + c_dur, 1) as t_time,
    Round((100 * (f_cnt * f_dmg + c_dmg) / x_hp) / (f_cnt * f_dur + c_dur), 3) as t_dps,

    Round((100 * x_f_dmg / hp) /x_f_dur, 3) as x_f_dps,
    Round(100 * (x_f_cnt * x_f_dmg + x_c_dmg) / hp, 3) as x_t_dmg,
    Round(x_f_cnt * x_f_dur + x_c_dur, 1) as x_t_time,
    Round((100 * (x_f_cnt * x_f_dmg + x_c_dmg) / hp) / (x_f_cnt * x_f_dur + x_c_dur), 3) as x_t_dps

    from B
)
select 
    pokemon_uid,f_uid,c_uid,
--    C.jp,FM.jp,CM.jp,
    Round(f_dmg,1), Round(c_dmg,1),
    f_dps,t_dps,t_dmg,t_time,
    Round((100.0/t_dps),0) as killtime,
    x_f_dps,x_t_dps, 
--    Round(100 * f_dps / x_f_dps, 1) as scr_ff,
--    Round(100 * t_dps / x_f_dps, 1) as scr_tf,
    Round(100 * t_dps / x_t_dps, 1) as score
from C
join localize_fastmove FM on FM.uid=f_uid
join localize_chargemove CM on CM.uid=c_uid
where t_dps is not null
order by t_dps / x_t_dps desc
--order by t_dps desc
;


-- [ジム版]
With  X as(
-- Target Pokemon
    select
        B.uid as x_uid, A.type_1 as x_type_1, A.type_2 as x_type_2, 
        A.f_type as x_f_type, A.f_stab_pow as x_f_stab_pow, A.f_dur as x_f_dur, A.f_ene as x_f_ene,
        A.c_type as x_c_type, A.c_stab_pow as x_c_stab_pow, A.c_dur as x_c_dur, A.c_ene as x_c_ene,
        floor((B.at+15) * 0.79030001)::INTEGER as x_at, 
        floor((B.df+15) * 0.79030001)::INTEGER as x_df, 
        floor((B.hp+15) * 0.79030001)::INTEGER as x_hp
    from pokemon_pattern A 
    join pokemon B on A.pokemon_uid=B.uid
--    where B.uid=puid('カビゴン') and A.f_uid=get_move_uid('したでなめる') and A.c_uid=get_move_uid('はかいこうせん')
    where B.uid=puid('BLISSEY') and A.f_uid=get_move_uid('POUND') and A.c_uid=get_move_uid('DAZZLING_GLEAM')
)
,A as(
-- Challenger Pokemon and effectiveness
    select 
        A.*, 
        floor((B.at+15) * 0.79030001)::INTEGER as at, 
        floor((B.df+15) * 0.79030001)::INTEGER as df, 
        floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
        C.jp as jp,
        X.*,
        EF1.mlp * (case when EF2.mlp is null then 1.0 else EF2.mlp end) as ef_f,
        EC1.mlp * (case when EC2.mlp is null then 1.0 else EC2.mlp end) as ef_c,
        XEF1.mlp * (case when XEF2.mlp is null then 1.0 else XEF2.mlp end) as x_ef_f,
        XEC1.mlp * (case when XEC2.mlp is null then 1.0 else XEC2.mlp end) as x_ef_c
    from pokemon_pattern A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    join X on true
    left join effectiveness EF1 on EF1.attacker=A.f_type and EF1.defender=X.x_type_1
    left join effectiveness EF2 on EF2.attacker=A.f_type and EF2.defender=X.x_type_2
    left join effectiveness EC1 on EC1.attacker=A.c_type and EC1.defender=X.x_type_1
    left join effectiveness EC2 on EC2.attacker=A.c_type and EC2.defender=X.x_type_2
    left join effectiveness XEF1 on XEF1.attacker=X.x_f_type and XEF1.defender=A.type_1
    left join effectiveness XEF2 on XEF2.attacker=X.x_f_type and XEF2.defender=A.type_2
    left join effectiveness XEC1 on XEC1.attacker=X.x_c_type and XEC1.defender=A.type_1
    left join effectiveness xEC2 on XEC2.attacker=X.x_c_type and XEC2.defender=A.type_2
    where B.available=true
)
, B as(
-- damage calculate
    select *, 
    (A.f_stab_pow * A.at * A.ef_f * 0.5 / A.x_df) + 1 as f_dmg,
    (A.c_stab_pow * A.at * A.ef_c * 0.5 / A.x_df) + 1 as c_dmg,
    (A.x_f_stab_pow * A.x_at * A.x_ef_f * 0.5 / A.df) + 1 as x_f_dmg,
    (A.x_c_stab_pow * A.x_at * A.x_ef_c * 0.5 / A.df) + 1 as x_c_dmg,
    (c_ene::numeric / f_ene) as f_cnt,
    (x_c_ene::numeric / x_f_ene) as x_f_cnt,
    case when A.f_leg then 'T' else null end as f_l, 
    case when A.c_leg then 'T' else null end as c_l, 
    df * hp as ac
    from A
)
, C as(
-- dps calculate
    select *,
    Round((100 * f_dmg / x_hp) / f_dur, 3) as f_dps,
    Round(100 * (f_cnt * f_dmg + c_dmg) / x_hp, 3) as t_dmg,
    Round(f_cnt * f_dur + c_dur, 1) as t_time,
    Round((100 * (f_cnt * f_dmg + c_dmg) / x_hp) / (f_cnt * f_dur + c_dur), 3) as t_dps,

    Round((100 * x_f_dmg / hp) /x_f_dur, 3) as x_f_dps,
    Round(100 * (x_f_cnt * x_f_dmg + x_c_dmg) / hp, 3) as x_t_dmg,
    Round(x_f_cnt * x_f_dur + x_c_dur, 1) as x_t_time,
    Round((100 * (x_f_cnt * x_f_dmg + x_c_dmg) / hp) / (x_f_cnt * x_f_dur + x_c_dur), 3) as x_t_dps

    from B
)
select 
    pokemon_uid,f_uid,c_uid,
    C.jp,FM.jp,CM.jp,
    Round(f_dmg,1), Round(c_dmg,1),
    f_dps,t_dps,t_dmg,t_time,
    x_f_dps,x_t_dps, 
--    Round(f_dps / x_f_dps, 1) as scr_ff,
--    Round(t_dps / x_f_dps, 1) as scr_tf,
    Round(t_dps / x_t_dps, 1) as score
from C
join localize_fastmove FM on FM.uid=f_uid
join localize_chargemove CM on CM.uid=c_uid
where t_dps is not null
order by t_dps / x_t_dps desc
--order by t_dps desc
;


With  X as(
-- Target Pokemon
    select
        B.uid as x_uid, A.type_1 as x_type_1, A.type_2 as x_type_2, 
        A.f_type as x_f_type, A.f_stab_pow as x_f_stab_pow, A.f_dur as x_f_dur, A.f_ene as x_f_ene,
        A.c_type as x_c_type, A.c_stab_pow as x_c_stab_pow, A.c_dur as x_c_dur, A.c_ene as x_c_ene,
        floor((B.at+15) * 0.79030001)::INTEGER as x_at, 
        floor((B.df+15) * 0.79030001)::INTEGER as x_df, 
        floor((B.hp+15) * 0.79030001)::INTEGER as x_hp
    from pokemon_pattern A 
    join pokemon B on A.pokemon_uid=B.uid
--    where B.uid=puid('カビゴン') and A.f_uid=get_move_uid('したでなめる') and A.c_uid=get_move_uid('はかいこうせん')
    where B.uid=puid('BLISSEY') and A.f_uid=get_move_uid('POUND') and A.c_uid=get_move_uid('DAZZLING_GLEAM')
)
,A as(
-- Challenger Pokemon and effectiveness
    select 
        A.*, 
        floor((B.at+15) * 0.79030001)::INTEGER as at, 
        floor((B.df+15) * 0.79030001)::INTEGER as df, 
        floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
        C.jp as jp,
        X.*,
        EF1.mlp * (case when EF2.mlp is null then 1.0 else EF2.mlp end) as ef_f,
        EC1.mlp * (case when EC2.mlp is null then 1.0 else EC2.mlp end) as ef_c,
        XEF1.mlp * (case when XEF2.mlp is null then 1.0 else XEF2.mlp end) as x_ef_f,
        XEC1.mlp * (case when XEC2.mlp is null then 1.0 else XEC2.mlp end) as x_ef_c
    from pokemon_pattern A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    join X on true
    left join effectiveness EF1 on EF1.attacker=A.f_type and EF1.defender=X.x_type_1
    left join effectiveness EF2 on EF2.attacker=A.f_type and EF2.defender=X.x_type_2
    left join effectiveness EC1 on EC1.attacker=A.c_type and EC1.defender=X.x_type_1
    left join effectiveness EC2 on EC2.attacker=A.c_type and EC2.defender=X.x_type_2
    left join effectiveness XEF1 on XEF1.attacker=X.x_f_type and XEF1.defender=A.type_1
    left join effectiveness XEF2 on XEF2.attacker=X.x_f_type and XEF2.defender=A.type_2
    left join effectiveness XEC1 on XEC1.attacker=X.x_c_type and XEC1.defender=A.type_1
    left join effectiveness xEC2 on XEC2.attacker=X.x_c_type and XEC2.defender=A.type_2
    where B.available=true
)
, B as(
-- damage calculate
    select *, 
    (A.f_stab_pow * A.at * A.ef_f * 0.5 / A.x_df) + 1 as f_dmg,
    (A.c_stab_pow * A.at * A.ef_c * 0.5 / A.x_df) + 1 as c_dmg,
    (A.x_f_stab_pow * A.x_at * A.x_ef_f * 0.5 / A.df) + 1 as x_f_dmg,
    (A.x_c_stab_pow * A.x_at * A.x_ef_c * 0.5 / A.df) + 1 as x_c_dmg,
    (c_ene::numeric / f_ene) as f_cnt,
    (x_c_ene::numeric / x_f_ene) as x_f_cnt,
    case when A.f_leg then 'T' else null end as f_l, 
    case when A.c_leg then 'T' else null end as c_l, 
    df * hp as ac
    from A
)
, C as(
-- dps calculate
    select *,
    Round((100 * f_dmg / x_hp) / f_dur, 3) as f_dps,
    Round(100 * (f_cnt * f_dmg + c_dmg) / x_hp, 3) as t_dmg,
    Round(f_cnt * f_dur + c_dur, 1) as t_time,
    Round((100 * (f_cnt * f_dmg + c_dmg) / x_hp) / (f_cnt * f_dur + c_dur), 3) as t_dps,

    Round((100 * x_f_dmg / hp) /x_f_dur, 3) as x_f_dps,
    Round(100 * (x_f_cnt * x_f_dmg + x_c_dmg) / hp, 3) as x_t_dmg,
    Round(x_f_cnt * x_f_dur + x_c_dur, 1) as x_t_time,
    Round((100 * (x_f_cnt * x_f_dmg + x_c_dmg) / hp) / (x_f_cnt * x_f_dur + x_c_dur), 3) as x_t_dps

    from B
)
select 
--    pokemon_uid,
--    f_uid,
--    c_uid,
    C.jp,
    FM.jp,
    CM.jp,
    Round(f_dmg,1) as f_dmg, 
    Round(c_dmg,1) as c_dmg,
    f_dps,t_dps,t_dmg,t_time,
    x_f_dps,x_t_dps, 
--    Round(f_dps / x_f_dps, 1) as scr_ff,
--    Round(t_dps / x_f_dps, 1) as scr_tf,
    Round(t_dps / x_t_dps, 1) as score
from C
join localize_fastmove FM on FM.uid=f_uid
join localize_chargemove CM on CM.uid=c_uid
where t_dps is not null
and pokemon_uid in ('GROUDON','EXCADRILL')
order by t_dps / x_t_dps desc
--order by t_dps desc
;



-- [対戦相手なしで技の火力を調べる：レイド＆ジム]
With A as(
    select A.*, 
    floor((B.at+15) * 0.79030001)::INTEGER as at, 
    floor((B.df+15) * 0.79030001)::INTEGER as df, 
    floor((B.hp+15) * 0.79030001)::INTEGER as hp, 
    C.jp as jp
    from pokemon_pattern A 
    join pokemon B on A.pokemon_uid=B.uid
    join localize_pokemon C on A.pokemon_uid=C.uid
    where B.available=true
)
, B as(
    select *, 
    case when A.f_leg then 'T' else null end as f_l, 
    (A.f_stab_pow*A.at) as f_dmg,
    case when A.c_leg then 'T' else null end as c_l, 
    (A.c_stab_pow*A.at) as c_dmg,
    ceil(c_ene::numeric / f_ene) as f_cnt,
    df * hp as ac
    from A
)
, C as(
    select *,
    Round(f_dmg/f_dur, 1) as f_dps,
    f_cnt * f_dmg + c_dmg as t_dmg,
    Round(f_cnt * f_dur + c_dur, 1) as t_time,
    Round((f_cnt * f_dmg + c_dmg) / (f_cnt * f_dur + c_dur), 1) as t_dps
    from B
)
select 
pokemon_uid, jp, type_1,type_2,at,ac,
f_uid,f_type,f_pow,Round(f_dur,1) as f_dur,f_ene, f_l, f_dmg, f_dps,
c_uid,c_type,c_pow,c_ene, c_l, c_dmg,
f_cnt, t_dmg, t_time,t_dps
, Round((ac::numeric*t_dps)/100000) as score
from C
where true
--and pokemon_uid~'SNORLAX'
and c_type='GROUND' 
and 'GROUND' in (type_1,type_2)
--order by t_dps desc
order by ac*t_dps desc
;

