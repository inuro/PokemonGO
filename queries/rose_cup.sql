-- Rose cup (2020 Feb) 

-- Rose cup eligible pokemons
DROP TABLE if exists cup_rose;
CREATE TABLE cup_rose(
    uid text
);
INSERT INTO cup_rose(uid)
select uid from localize_pokemon where en in ('Accelgor','Aerodactyl','Aggron','Aipom','Ambipom','Anorith','Arbok','Ariados','Armaldo','Aron','Blaziken','Blissey','Camerupt','Cascoon','Castform','Castform (Sunny Form)','Chansey','Charizard','Charmander','Charmeleon','Cherrim (Overcast)','Cherrim (Sunny)','Cherubi','Clefable','Clefairy','Cleffa','Combusken','Crobat','Crustle','Delcatty','Delibird','Donphan','Drapion','Drifblim','Drifloon','Drilbur','Durant','Dwebble','Ekans','Electrode','Emboar','Escavalier','Espeon','Excadrill','Exeggcute','Ferroseed','Ferrothorn','Flaaffy','Flareon','Forretress','Gastly','Gengar','Alolan Geodude','Glalie','Glameow','Gligar','Gliscor','Golbat','Alolan Golem','Granbull','Alolan Graveler','Grimer','Grumpig','Gurdurr','Happiny','Haunter','Heatmor','Herdier','Hoppip','Igglybuff','Illumise','Jigglypuff','Jynx','Klang','Klink','Klinklang','Koffing','Kricketot','Kricketune','Lairon','Ledian','Ledyba','Lickilicky','Lickitung','Liepard','Lileep','Machamp','Machoke','Machop','Magby','Magcargo','Magmar','Magmortar','Magnemite','Magneton','Magnezone','Alolan Marowak','Medicham','Mightyena','Miltank','Mime Jr.','Misdreavus','Mismagius','Mr. Mime','Muk','Nidoking','Nidoran♂','Nidorino','Nincada','Nosepass','Onix','Pansear','Paras','Parasect','Pidove','Pignite','Pineco','Poochyena','Porygon','Porygon-Z','Porygon2','Probopass','Pupitar','Purrloin','Purugly','Rattata','Rhydon','Rhyhorn','Rhyperior','Sableye','Scizor','Scolipede','Shelmet','Shieldon','Simisear','Skarmory','Skitty','Skorupi','Skuntank','Slugma','Smoochum','Snorunt','Snubbull','Solrock','Spiritomb','Steelix','Stoutland','Stunky','Swalot','Tepig','Throh','Timburr','Torchic','Tranquill','Tyrogue','Unfezant','Venipede','Venomoth','Venonat','Vileplume','Volbeat','Voltorb','Weezing','Galarian Weezing','Whirlipede','Whismur','Wigglytuff','Wormadam (Trash Cloak)','Wurmple','Yanma','Zubat');


-- win_lose table building
-- tables required: cup_rose , top_IV
-- latest version
select now();
BEGIN;
drop table if exists win_lose_rose;
create table win_lose_rose as (
WITH AA as(
    select A.*
    from cup_rose R
    join pokemon_pattern_combat A on A.pokemon_uid=R.uid
--    where A.pokemon_uid in ('SKARMORY','PROBOPASS','STEELIX_NORMAL')
)
,A as (
    select *
    from AA
    left join top_IV B on B.uid=AA.pokemon_uid and B.cap=1500
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.type_1 as type_1,
        PLAYER.type_2 as type_2,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.f_ene as f_ene,
        PLAYER.f_dur as f_dur,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.c_ene as c_ene,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.f_type as opponent_f_type,
        OPPONENT.f_ene as opponent_f_ene,
        OPPONENT.f_dur as opponent_f_dur,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.c_ene as opponent_c_ene,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER 
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
    --where PLAYER.pokemon_uid='GOLEM_NORMAL'
), C as(
    select
        *, 
        (FLOOR(0.5 * (atk / opponent_def) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * (atk / opponent_def) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * (opponent_atk / def) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * (opponent_atk / def) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 0) as kill0,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_ene,opponent_f_dur,opponent_c_dmg,opponent_c_ene,0)as death0,
        calc_killtime_combat(opponent_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 2) as kill2,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_ene,opponent_f_dur,opponent_c_dmg,opponent_c_ene,2)as death2
    from C
)
-- select uid,f_uid,f_type,c_uid,opponent_uid,opponent_f_uid,opponent_f_type,opponent_c_uid, kill0,death0,kill2,death2 from D order by f_uid,c_uid,opponent_uid,opponent_f_uid,opponent_f_type,opponent_c_uid;
, E as(
    select 
        *,
        sum(case when kill0 < death0 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as win0,
        sum(case when kill2 < death2 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as win2,
        sum(case when kill0 < death0 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as win0_u,
        sum(case when kill0 >= death0 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as lose0_u,
        sum(case when kill2 < death2 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as win2_u,
        sum(case when kill2 >= death2 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as lose2_u
    from D
)
--select uid,f_uid,f_type,c_uid,win0,win2,win0_u,lose0_u,win2_u,lose2_u from E;
-- perfect win
,F as(
    select distinct
        uid, f_uid, f_type, c_uid, 
        --c_type, opponent_uid, lose0_u, lose2_u,
        sum(case when lose0_u = 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as counter0,
        sum(case when lose2_u = 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as counter2
    from E
    group by uid, f_uid, f_type, c_uid, c_type, opponent_uid, lose0_u, lose2_u
)
-- zero win
,G as(
    select distinct
        uid, f_uid, f_type, c_uid, 
        --c_type, opponent_uid, win0_u, win2_u,
        sum(case when win0_u = 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as victim0,
        sum(case when win2_u = 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as victim2
    from E
    group by uid, f_uid, f_type, c_uid, c_type, opponent_uid, win0_u, win2_u
)
, Z as(
    select count(*) as total, count(distinct pokemon_uid) as total_unique from A
)
, H as(
select
    1500 as cap,
    uid, 
    type_1,
    type_2,
    f_uid, 
    f_type,
    c_uid,
    c_type,
    win0,
    Z.total - win0 as lose0,
    win2,
    Z.total - win2 as lose2
from E
join Z on true
group by E.uid, E.type_1, E.type_2, E.f_uid, E.f_type, E.c_uid, E.c_type, E.win0, E.win2, Z.total, Z.total_unique
)
select
    H.*,
    F.counter0, F.counter2,
    G.victim0, G.victim2
from H
left join F using(uid,f_uid,f_type,c_uid)
left join G using(uid,f_uid,f_type,c_uid)


);
COMMIT;
select now();





-- win_lose top_tier only
select now();
BEGIN;
drop table if exists win_lose_rose_top;
create table win_lose_rose_top as (
WITH AA as(
    select A.*
    from cup_rose R
    join pokemon_pattern_combat A on A.pokemon_uid=R.uid
    where A.c_uid != 'FRUSTRATION'
--    where A.pokemon_uid in ('SKARMORY','PROBOPASS','STEELIX_NORMAL')
)
,A as (
    select *
    from AA
    join top_IV B on B.uid=AA.pokemon_uid and B.cap=1500 and (B.cp>1400 or B.uid='CHANSEY')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.type_1 as type_1,
        PLAYER.type_2 as type_2,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.f_ene as f_ene,
        PLAYER.f_dur as f_dur,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.c_ene as c_ene,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.f_type as opponent_f_type,
        OPPONENT.f_ene as opponent_f_ene,
        OPPONENT.f_dur as opponent_f_dur,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.c_ene as opponent_c_ene,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER 
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
    --where PLAYER.pokemon_uid='GOLEM_NORMAL'
), C as(
    select
        *, 
        (FLOOR(0.5 * (atk / opponent_def) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * (atk / opponent_def) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * (opponent_atk / def) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * (opponent_atk / def) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 0) as kill0,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_ene,opponent_f_dur,opponent_c_dmg,opponent_c_ene,0)as death0,
        calc_killtime_combat(opponent_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 2) as kill2,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_ene,opponent_f_dur,opponent_c_dmg,opponent_c_ene,2)as death2
    from C
)
-- select uid,f_uid,f_type,c_uid,opponent_uid,opponent_f_uid,opponent_f_type,opponent_c_uid, kill0,death0,kill2,death2 from D order by f_uid,c_uid,opponent_uid,opponent_f_uid,opponent_f_type,opponent_c_uid;
, E as(
    select 
        *,
        sum(case when kill0 < death0 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as win0,
        sum(case when kill2 < death2 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as win2,
        sum(case when kill0 < death0 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as win0_u,
        sum(case when kill0 >= death0 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as lose0_u,
        sum(case when kill2 < death2 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as win2_u,
        sum(case when kill2 >= death2 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as lose2_u
    from D
)
--select uid,f_uid,f_type,c_uid,win0,win2,win0_u,lose0_u,win2_u,lose2_u from E;
-- perfect win
,F as(
    select distinct
        uid, f_uid, f_type, c_uid, 
        --c_type, opponent_uid, lose0_u, lose2_u,
        sum(case when lose0_u = 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as counter0,
        sum(case when lose2_u = 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as counter2
    from E
    group by uid, f_uid, f_type, c_uid, c_type, opponent_uid, lose0_u, lose2_u
)
-- zero win
,G as(
    select distinct
        uid, f_uid, f_type, c_uid, 
        --c_type, opponent_uid, win0_u, win2_u,
        sum(case when win0_u = 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as victim0,
        sum(case when win2_u = 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as victim2
    from E
    group by uid, f_uid, f_type, c_uid, c_type, opponent_uid, win0_u, win2_u
)
, Z as(
    select count(*) as total, count(distinct pokemon_uid) as total_unique from A
)
, H as(
select
    1500 as cap,
    uid, 
    type_1,
    type_2,
    f_uid, 
    f_type,
    c_uid,
    c_type,
    win0,
    Z.total - win0 as lose0,
    win2,
    Z.total - win2 as lose2
from E
join Z on true
group by E.uid, E.type_1, E.type_2, E.f_uid, E.f_type, E.c_uid, E.c_type, E.win0, E.win2, Z.total, Z.total_unique
)
select
    H.*,
    F.counter0, F.counter2,
    G.victim0, G.victim2
from H
left join F using(uid,f_uid,f_type,c_uid)
left join G using(uid,f_uid,f_type,c_uid)


);
COMMIT;
select now();





-- 上位ランクの確認

\a
\pset fieldsep ','
\pset tuples_only t
With A as(
    select B.jp,A.*, 
    rank() over (order by win0+win2 desc) rnk_all,
--    rank() over (partition by uid order by counter0+counter2 desc) rnk_each
    rank() over (partition by uid order by win0+win2 desc) rnk_each
    from win_lose_rose_top A join localize_pokemon B using(uid)
)
select A.*
from A 
join localize_fastmove B on B.uid=A.f_uid 
join localize_chargemove C on C.uid=A.c_uid 
where rnk_each=1 order by rnk_all;


With A as(
    select B.jp,A.*, 
    rank() over (order by win0+win2 desc) rnk_all,
--    rank() over (partition by uid order by counter0+counter2 desc) rnk_each
    rank() over (partition by uid order by win0+win2 desc) rnk_each
    from win_lose_rose_top A join localize_pokemon B using(uid)
)
select A.jp,B.jp,C.jp,D.cp,D.lv,D.hpt,D.atk,D.def,win0,lose0,win2,lose2,counter0 as ctr0, counter2 as ctr2,victim0 as vtm0, victim2 as vtm2,rnk_all as rnk
from A 
join localize_fastmove B on B.uid=A.f_uid 
join localize_chargemove C on C.uid=A.c_uid 
join top_iv D on D.uid=A.uid and D.cap=1500
where rnk_each=1 order by rnk_all;


With A as(
    select A.*, 
    (c_ene::numeric/f_ene)*f_dur as charge_time,
    Ceil(c_ene::numeric/f_ene)*f_dur as charge_turn,
    f_stab_pow / f_dur as f_dps,
    ((c_ene::numeric/f_ene) * f_stab_pow + c_stab_pow) / ((c_ene::numeric/f_ene)*f_dur) as t_dps,
    c_stab_pow as c_dmg,
    rank() over (order by win0+win2 desc) rnk_all,
--    rank() over (partition by uid order by counter0+counter2 desc) rnk_each
    rank() over (partition by uid order by win0+win2 desc) rnk_each
    from win_lose_rose_top A
    join pokemon_pattern_combat B on B.pokemon_uid=A.uid and B.f_uid=A.f_uid and B.f_type=A.f_type and B.c_uid=A.c_uid
)
select 
    A.uid,AA.jp,A.type_1,A.type_2,
    B.jp,
    A.f_uid,
    A.f_type,
    C.jp,
    A.c_uid,
    A.c_type,
    D.cp,D.lv,D.hpt,
    --D.atk,D.def,
    --Round(charge_time,1) as chg,
    charge_turn as chg,
    c_dmg,
    --Round(f_dps,1) as f_dps,Round(t_dps,1) as t_dps,
    win0,lose0,win2,lose2,counter0 as ctr0, counter2 as ctr2,victim0 as vtm0, victim2 as vtm2,rnk_all as rnk
from A 
join localize_pokemon AA on AA.uid=A.uid 
join localize_fastmove B on B.uid=A.f_uid 
join localize_chargemove C on C.uid=A.c_uid 
join top_iv D on D.uid=A.uid and D.cap=1500
where rnk_each=1 order by rnk_all;


With A as(
    select B.jp,A.*, 
    rank() over (order by win0+win2 desc) rnk_all,
--    rank() over (partition by uid order by counter0+counter2 desc) rnk_each
    rank() over (partition by uid order by win0+win2 desc) rnk_each
    from win_lose_rose_top A join localize_pokemon B using(uid)
)
select A.*
from A 
join localize_fastmove B on B.uid=A.f_uid 
join localize_chargemove C on C.uid=A.c_uid 
where A.uid='PROBOPASS' order by rnk_all;











-- あるポケモンに対するカウンターROSE cup
    select 'CASTFORM_SUNNY' as pokemon_uid, 'EMBER' as f_uid, 'WEATHER_BALL_FIRE' as c_uid
    select 'DRAPION' as pokemon_uid, 'BITE' as f_uid, 'AQUA_TAIL' as c_uid
    select 'DRAPION' as pokemon_uid, 'BITE' as f_uid, 'SLUDGE_BOMB' as c_uid
    select 'PROBOPASS' as pokemon_uid, 'SPARK' as f_uid, 'ROCK_SLIDE' as c_uid
    select 'SABLEYE_NORMAL' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'FOUL_PLAY' as c_uid
    select 'ELECTRODE' as pokemon_uid, 'VOLT_SWITCH' as f_uid, 'FOUL_PLAY' as c_uid
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'NIGHT_SLASH' as c_uid
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'DIG' as c_uid
    select 'RHYDON_NORMAL' as pokemon_uid, 'MUD_SLAP' as f_uid, 'SURF' as c_uid
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'ICE_BEAM' as c_uid
    select 'CHARMELEON_NORMAL' as pokemon_uid, 'FIRE_FANG' as f_uid, 'FLAMETHROWER' as c_uid
    select 'MAGNETON_NORMAL' as pokemon_uid, 'THUNDER_SHOCK' as f_uid, 'MAGNET_BOMB' as c_uid

With Z as(
    select 'CASTFORM_SUNNY' as pokemon_uid, 'EMBER' as f_uid, 'WEATHER_BALL_FIRE' as c_uid
), O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from Z
    join pokemon_pattern_combat a using(pokemon_uid,f_uid,c_uid)
    join top_iv b on b.uid=Z.pokemon_uid
    where b.cap=1500
    and a.c_uid != 'FRUSTRATION'
    and (B.cp>1400 or B.uid='CHANSEY')
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    join cup_rose H on H.uid=a.pokemon_uid
    where b.cap=1500 and H.uid is not null
    --and a.pokemon_uid in ('GRAVELER_ALOLA','GOLEM_ALOLA') and a.f_uid='ROCK_THROW' and a.c_uid='ROCK_BLAST'
), B as(
    select *,
    Floor(1.3 * 0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(1.3 * 0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(1.3 * 0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(1.3 * 0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,type_1,type_2,f_uid,f_type,c_uid,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg,
    Round(100 * (Floor((Ceil(c_ene::numeric / f_ene) * f_dur) / o_f_dur) * o_f_dmg) / hpt, 1) as firstdmg
    from B
)
select 
C.pokemon_uid,D.jp,type_1,type_2,
--E.jp,F.jp,
--pokemon_uid,f_uid,c_uid,

--kill0,death0,
--kill1,death1,
--kill2,death2,
--f_dps,o_f_dps, 
Round(f_dps / o_f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=pokemon_uid
--join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
where true
--and f_dps > o_f_dps
--and f_dps/o_f_dps >=1.0
and kill0<death0
--and f_type = 'GROUND'
--and charge < o_charge
-- victim
--and firstdmg >= 100
order by kill2 / death0, charge;
--order by charge;




-- あるポケモンに対するカウンターROSE cup:GoogleSheets出力用
    select 'CASTFORM_SUNNY' as pokemon_uid, 'EMBER' as f_uid, 'WEATHER_BALL_FIRE' as c_uid
    select 'DRAPION' as pokemon_uid, 'BITE' as f_uid, 'AQUA_TAIL' as c_uid
    select 'DRAPION' as pokemon_uid, 'BITE' as f_uid, 'SLUDGE_BOMB' as c_uid
    select 'PROBOPASS' as pokemon_uid, 'SPARK' as f_uid, 'ROCK_SLIDE' as c_uid
    select 'SABLEYE_NORMAL' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'FOUL_PLAY' as c_uid
    select 'ELECTRODE' as pokemon_uid, 'VOLT_SWITCH' as f_uid, 'FOUL_PLAY' as c_uid
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'NIGHT_SLASH' as c_uid
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'DIG' as c_uid
    select 'RHYDON_NORMAL' as pokemon_uid, 'MUD_SLAP' as f_uid, 'SURF' as c_uid
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'ICE_BEAM' as c_uid
    select 'CHARMELEON_NORMAL' as pokemon_uid, 'FIRE_FANG' as f_uid, 'FLAMETHROWER' as c_uid
    select 'MAGNETON_NORMAL' as pokemon_uid, 'THUNDER_SHOCK' as f_uid, 'MAGNET_BOMB' as c_uid



\a
\pset fieldsep ','
With Z as(
    select 'PROBOPASS' as pokemon_uid, 'SPARK' as f_uid, 'ROCK_SLIDE' as c_uid
), O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from Z
    join pokemon_pattern_combat a using(pokemon_uid,f_uid,c_uid)
    join top_iv b on b.uid=Z.pokemon_uid
    where b.cap=1500
    and a.c_uid != 'FRUSTRATION'
    and (B.cp>1400 or B.uid='CHANSEY')
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    join cup_rose H on H.uid=a.pokemon_uid
    where b.cap=1500 and H.uid is not null
    and a.c_uid != 'FRUSTRATION'
    and (B.cp>1400 or B.uid='CHANSEY')
    --and a.pokemon_uid in ('GRAVELER_ALOLA','GOLEM_ALOLA') and a.f_uid='ROCK_THROW' and a.c_uid='ROCK_BLAST'
), B as(
    select *,
    Floor(1.3 * 0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(1.3 * 0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(1.3 * 0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(1.3 * 0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,type_1,type_2,f_uid,f_type,c_uid,c_type,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg,
    Round(100 * (Floor((Ceil(c_ene::numeric / f_ene) * f_dur) / o_f_dur) * o_f_dmg) / hpt, 1) as firstdmg
    from B
)
select 
D.jp,C.pokemon_uid,type_1,type_2,
E.jp,f_uid,f_type,
F.jp,c_uid,c_type,
f_dps,charge as chg,chg_dmg,c_dmg, cycle_dmg,
kill0,death0,kill1,death1,kill2,death2,
o_f_dps,o_charge as o_chg,o_chg_dmg,o_c_dmg, o_cycle_dmg,
firstdmg,
Round(f_dps / o_f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
where true
order by kill2 / death0, charge;











--appendix

-- rosecup 全パターンのパラメータ一覧
WITH AA as(
    select A.*
    from cup_rose R
    join pokemon_pattern_combat A on A.pokemon_uid=R.uid
--    where A.pokemon_uid ~ 'BULBASAUR'
--    where A.pokemon_uid in ('AZUMARILL','WHISCASH','ALTARIA','POLIWRATH_NORMAL')
--    where A.pokemon_uid in ('AZUMARILL','ALTARIA','BULBASAUR_NORMAL')
)
,A as (
    select *
    from AA
    left join top_IV B on B.uid=AA.pokemon_uid and B.cap=1500
)
select pokemon_uid, type_1,type_2,f_uid,f_type,f_dur,f_ene,f_stab_pow,c_uid,c_type,c_ene,c_stab_pow,cp,lv,hp,at,df,hpt,round(atk,2) as atk, round(def,2)as def from A;

-- rosecup 全パターンのうちHPやATKなど
WITH AA as(
    select A.*
    from cup_rose R
    join pokemon_pattern_combat A on A.pokemon_uid=R.uid
--    where A.pokemon_uid ~ 'BULBASAUR'
--    where A.pokemon_uid in ('AZUMARILL','WHISCASH','ALTARIA','POLIWRATH_NORMAL')
--    where A.pokemon_uid in ('AZUMARILL','ALTARIA','BULBASAUR_NORMAL')
)
,A as (
    select *
    from AA
    left join top_IV B on B.uid=AA.pokemon_uid and B.cap=1500
)
, B as(
    select distinct pokemon_uid, type_1,type_2,cp,lv,hp,at,df,hpt,round(atk,2) as atk, round(def,2)as def, Round(hpt*def) as AC from A
)
select
    C.jp, B.*
from B
join localize_pokemon C on C.uid=B.pokemon_uid
order by AC desc;








    left join cpm C on C.lv=40 where a.pokemon_uid=puid('GRAVELER_ALOLA') and a.f_uid=get_move_uid('ROCK_THROW') and a.c_uid=get_move_uid('ROCK_BLAST')
    left join cpm C on C.lv=40 where a.pokemon_uid=puid('GOLEM_ALOLA') and a.f_uid=get_move_uid('ROCK_THROW') and a.c_uid=get_move_uid('ROCK_BLAST')
    join calc_all_iv_pattern('CASTFORM_SUNNY',1500) B on true where a.pokemon_uid='CASTFORM_SUNNY' and a.f_uid='EMBER' and a.c_uid='WEATHER_BALL_FIRE'


with O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    --(B.at + 1) * C.mlp as o_atk,
    --(B.df + 15) * C.mlp as o_def,
    --(B.hp + 15) * C.mlp as o_hpt, 
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid and b.cap=1500
    --left join pokemon B on B.uid=A.pokemon_uid
    --left join cpm C on C.lv=40 
--    where a.pokemon_uid=puid('GOLEM_ALOLA') and a.f_uid=get_move_uid('ROCK_THROW') and a.c_uid=get_move_uid('ROCK_BLAST')
    where a.pokemon_uid=puid('CASTFORM_SUNNY') and a.f_uid=get_move_uid('EMBER') and a.c_uid=get_move_uid('WEATHER_BALL_FIRE')
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join O on true
    join top_iv b on b.uid=a.pokemon_uid and b.cap=1500
    where a.pokemon_uid=puid('GOLEM_ALOLA') and a.f_uid=get_move_uid('ROCK_THROW') and a.c_uid=get_move_uid('ROCK_BLAST')
--    where a.pokemon_uid=puid('GRAVELER_ALOLA') and a.f_uid=get_move_uid('ROCK_THROW') and a.c_uid=get_move_uid('ROCK_BLAST')
--    join calc_all_iv_pattern('GRAVELER_ALOLA',1500) B on true where a.pokemon_uid='GRAVELER_ALOLA' and a.f_uid='ROCK_THROW' and a.c_uid='ROCK_BLAST'
--    join calc_all_iv_pattern('GRAVELER_ALOLA',1500) B on true where a.pokemon_uid='GRAVELER_ALOLA' and a.f_uid='ROCK_THROW' and a.c_uid='ROCK_BLAST'
), B as(
    select
    hp,at,df,hpt,
    Floor(1.3 * 0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(1.3 * 0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(1.3 * 0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(1.3 * 0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
)
-- パターンの数
--select f_dmg,c_dmg,o_f_dmg,o_c_dmg,count(*) from B 
--group by f_dmg,c_dmg,o_f_dmg,o_c_dmg
-- 全パターン
select * from B
order by f_dmg desc;



-- Rose cup 頻出ポケモン

('MEDICHAM','MACHAMP','MAROWAK_ALOLA','PROBOPASS','STEELIX_NORMAL','SKARMORY','GOLBAT_NORMAL','SABLEYE_NORMAL','DRIFBLIM','HAUNTER','WIGGLYTUFF','CLEFABLE','GLIGAR','GLISCOR','NIDOKING','RHYPERIOR_NORMAL','SOLROCK','GLALIE','MAGCARGO','MUK_ALOLA','VILEPLUME_NORMAL','DRAPION','SKUNTANK','VENOMOTH_NORMAL','ESCAVALIER','FERROTHORN','WORMADAM_TRASH','BLAZIKEN','CHARIZARD_NORMAL','CASTFORM_SUNNY','GRAVELER_ALOLA','CRUSTLE','SCIZOR_NORMAL','EXCADRILL','ELECTRODE','AGGRON','GOLEM_ALOLA','FORRETRESS','MAGNEZONE_NORMAL')
    

    select 'PROBOPASS' as pokemon_uid, 'ROCK_THROW' as f_uid, 'ROCK_SLIDE' as c_uid
    select 'DRAPION' as pokemon_uid, 'BITE' as f_uid, 'AQUA_TAIL' as c_uid
    select 'DRAPION' as pokemon_uid, 'BITE' as f_uid, 'CRUNCH' as c_uid
    select 'DRAPION' as pokemon_uid, 'ICE_FANG' as f_uid, 'AQUA_TAIL' as c_uid
    select 'DRAPION' as pokemon_uid, 'ICE_FANG' as f_uid, 'CRUNCH' as c_uid
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'ICE_BEAM' as c_uid
    select 'CASTFORM_SUNNY' as pokemon_uid, 'EMBER' as f_uid, 'WEATHER_BALL_FIRE' as c_uid


With Z as(
    select 'DRAPION' as pokemon_uid, 'BITE' as f_uid, 'AQUA_TAIL' as c_uid
), O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from Z
    join pokemon_pattern_combat a using(pokemon_uid,f_uid,c_uid)
    join top_iv b on b.uid=Z.pokemon_uid
    where b.cap=1500
    and a.c_uid != 'FRUSTRATION'
    and B.cp>1400
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    --join cup_rose H on H.uid=a.pokemon_uid
    where b.cap=1500 
    --and H.uid is not null
    and a.c_uid != 'FRUSTRATION'
    and B.cp>1400
    --and a.pokemon_uid in ('GRAVELER_ALOLA','GOLEM_ALOLA') and a.f_uid='ROCK_THROW' and a.c_uid='ROCK_BLAST'
), B as(
    select *,
    Floor(1.3 * 0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(1.3 * 0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(1.3 * 0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(1.3 * 0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,type_1,type_2,f_uid,f_type,c_uid,c_type,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg,
    Round(100 * (Floor((Ceil(c_ene::numeric / f_ene) * f_dur) / o_f_dur) * o_f_dmg) / hpt, 1) as firstdmg
    from B
)
select 
D.jp,C.pokemon_uid,type_1,type_2,
E.jp,f_uid,f_type,
F.jp,c_uid,c_type,
f_dps,charge as chg,chg_dmg,c_dmg, cycle_dmg,
kill0,death0,kill1,death1,kill2,death2,
o_f_dps,o_charge as o_chg,o_chg_dmg,o_c_dmg, o_cycle_dmg,
--firstdmg,
Round(f_dps / o_f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
where true
--and C.pokemon_uid in ('VIGOROTH','NOCTOWL','MUK_ALOLA','ALTARIA','PROBOPASS','GLIGAR','UMBREON')
and C.pokemon_uid in ('MEDICHAM','MACHAMP','MAROWAK_ALOLA','PROBOPASS','STEELIX_NORMAL','SKARMORY','GOLBAT_NORMAL','SABLEYE_NORMAL','DRIFBLIM','HAUNTER','WIGGLYTUFF','CLEFABLE','GLIGAR','GLISCOR','NIDOKING','RHYPERIOR_NORMAL','SOLROCK','GLALIE','MAGCARGO','MUK_ALOLA','VILEPLUME_NORMAL','DRAPION','SKUNTANK','VENOMOTH_NORMAL','ESCAVALIER','FERROTHORN','WORMADAM_TRASH','BLAZIKEN','CHARIZARD_NORMAL','CASTFORM_SUNNY','GRAVELER_ALOLA','CRUSTLE','SCIZOR_NORMAL','EXCADRILL','ELECTRODE','AGGRON','GOLEM_ALOLA','FORRETRESS','MAGNEZONE_NORMAL')
--and C.pokemon_uid='MEDICHAM'
--and kill0<death0
--and kill2<death2
--and 'FIGHTING' in (type_1,type_2)
--and C.pokemon_uid='DRAPION'
--and f_dps / o_f_dps>1.0
order by 
kill0/death0 * kill2/death2, charge
;



-- ある属性のfastmoveを持つ組み合わせ
select
    pokemon_uid,type_1,type_2,
    f_uid,f_type,f_stab_pow as fpow, f_dur,f_ene,
    Round((c_ene::numeric/f_ene)*f_dur,1) as chg,
    c_uid,c_type,c_stab_pow as cpow, c_ene
from pokemon_pattern_combat A
where A.pokemon_uid in ('MEDICHAM','MACHAMP','MAROWAK_ALOLA','PROBOPASS','STEELIX_NORMAL','SKARMORY','GOLBAT_NORMAL','SABLEYE_NORMAL','DRIFBLIM','HAUNTER','WIGGLYTUFF','CLEFABLE','GLIGAR','GLISCOR','NIDOKING','RHYPERIOR_NORMAL','SOLROCK','GLALIE','MAGCARGO','MUK_ALOLA','VILEPLUME_NORMAL','DRAPION','SKUNTANK','VENOMOTH_NORMAL','ESCAVALIER','FERROTHORN','WORMADAM_TRASH','BLAZIKEN','CHARIZARD_NORMAL','CASTFORM_SUNNY','GRAVELER_ALOLA','CRUSTLE','SCIZOR_NORMAL','EXCADRILL','ELECTRODE','AGGRON','GOLEM_ALOLA','FORRETRESS','MAGNEZONE_NORMAL')
--and A.f_type='GROUND'
--and A.c_type='GROUND'
and A.pokemon_uid='ELECTRODE'
;


-- 順位の確認
With a as(
    select rank() over(order by win0*win2 desc) as rnk, *
    from win_lose_rose
)
select * from a
where true
and uid in ('ELECTRODE')
;



    select 'DRAPION' as pokemon_uid, 'BITE' as f_uid, 'AQUA_TAIL' as c_uid
    select 'DRAPION' as pokemon_uid, 'ICE_FANG' as f_uid, 'AQUA_TAIL' as c_uid
    select 'ELECTRODE' as pokemon_uid, 'VOLT_SWITCH' as f_uid, 'FOUL_PLAY' as c_uid
    select 'RHYPERIOR_NORMAL' as pokemon_uid, 'MUD_SLAP' as f_uid, 'SURF' as c_uid
    select 'CASTFORM_SUNNY' as pokemon_uid, 'EMBER' as f_uid, 'WEATHER_BALL_FIRE' as c_uid
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'NIGHT_SLASH' as c_uid
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'ICE_BEAM' as c_uid
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'PLAY_ROUGH' as c_uid
    select 'STEELIX_NORMAL' as pokemon_uid, 'IRON_TAIL' as f_uid, 'CRUNCH' as c_uid
    select 'MEDICHAM' as pokemon_uid, 'COUNTER' as f_uid, 'ICE_PUNCH' as c_uid
    select 'MEDICHAM' as pokemon_uid, 'COUNTER' as f_uid, 'DYNAMIC_PUNCH' as c_uid
    select 'PROBOPASS' as pokemon_uid, 'ROCK_THROW' as f_uid, 'ROCK_SLIDE' as c_uid
    select 'PROBOPASS' as pokemon_uid, 'ROCK_THROW' as f_uid, 'MAGNET_BOMB' as c_uid
    select 'PROBOPASS' as pokemon_uid, 'SPARK' as f_uid, 'ROCK_SLIDE' as c_uid
    select 'SABLEYE_NORMAL' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'FOUL_PLAY' as c_uid
    select 'SABLEYE_NORMAL' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'POWER_GEM' as c_uid
    select 'CHARIZARD_NORMAL' as pokemon_uid, 'FIRE_SPIN' as f_uid, 'BLAST_BURN' as c_uid
    select 'CHARIZARD_NORMAL' as pokemon_uid, 'WING_ATTACK' as f_uid, 'BLAST_BURN' as c_uid
    select 'MAROWAK_ALOLA' as pokemon_uid, 'HEX' as f_uid, 'SHADOW_BALL' as c_uid
    select 'MAROWAK_ALOLA' as pokemon_uid, 'FIRE_SPIN' as f_uid, 'SHADOW_BALL' as c_uid
    select 'MAROWAK_ALOLA' as pokemon_uid, 'FIRE_SPIN' as f_uid, 'BONE_CLUB' as c_uid
    select 'SKARMORY' as pokemon_uid, 'AIR_SLASH' as f_uid, 'SKY_ATTACK' as c_uid
    select 'SKARMORY' as pokemon_uid, 'AIR_SLASH' as f_uid, 'FLASH_CANNON' as c_uid

--相手へのカウンター
With Z as(
    select 'SABLEYE_NORMAL' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'RETURN' as c_uid
), O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from Z
    join pokemon_pattern_combat a using(pokemon_uid,f_uid,c_uid)
    join top_iv b on b.uid=Z.pokemon_uid
    where b.cap=1500
    and a.c_uid != 'FRUSTRATION'
    and B.cp>1400
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    --join cup_rose H on H.uid=a.pokemon_uid
    where b.cap=1500 
    --and H.uid is not null
    and a.c_uid != 'FRUSTRATION'
    and B.cp>1400
    --and a.pokemon_uid in ('GRAVELER_ALOLA','GOLEM_ALOLA') and a.f_uid='ROCK_THROW' and a.c_uid='ROCK_BLAST'
), B as(
    select *,
    Floor(1.3 * 0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(1.3 * 0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(1.3 * 0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(1.3 * 0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,type_1,type_2,f_uid,f_type,c_uid,c_type,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg,
    Round(100 * (Floor((Ceil(c_ene::numeric / f_ene) * f_dur) / o_f_dur) * o_f_dmg) / hpt, 1) as firstdmg
    from B
)
select 
    D.jp,
    --C.pokemon_uid,type_1,type_2,
    E.jp,
    --f_uid,
    --f_type,
    F.jp,
    --c_uid,
    --c_type,
    f_dps,charge as chg,chg_dmg,c_dmg, cycle_dmg,
    kill0,death0,kill1,death1,kill2,death2,
    o_f_dps,o_charge as o_chg,o_chg_dmg,o_c_dmg, o_cycle_dmg,
    --firstdmg,
    Round(cycle_dmg::numeric/charge, 1) as tdps,
    Round(o_cycle_dmg::numeric/o_charge, 1) as o_tdps,
    Round(f_dps / o_f_dps, 2) as f_ratio,
    Round((cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge),2) as dpsratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
where true
    and C.pokemon_uid in ('ELECTRODE','RHYPERIOR_NORMAL','CASTFORM_SUNNY','DRAPION','WIGGLYTUFF','GLIGAR')
--and C.pokemon_uid='DRAPION'
--and kill0<death0
--and kill2<death2
--and f_dps / o_f_dps>1.0
order by 
--f_dps / o_f_dps desc
(cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge) desc
--kill0/death0 * kill2/death2, charge
;






--こちらに対して相手
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'ICE_BEAM' as c_uid
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'PLAY_ROUGH' as c_uid
    select 'DRAPION' as pokemon_uid, 'ICE_FANG' as f_uid, 'AQUA_TAIL' as c_uid
    select 'DRAPION' as pokemon_uid, 'ICE_FANG' as f_uid, 'FELL_STINGER' as c_uid
    select 'DRAPION' as pokemon_uid, 'ICE_FANG' as f_uid, 'SLUDGE_BOMB' as c_uid
    select 'CASTFORM_SUNNY' as pokemon_uid, 'EMBER' as f_uid, 'WEATHER_BALL_FIRE' as c_uid
    select 'RHYPERIOR_NORMAL' as pokemon_uid, 'MUD_SLAP' as f_uid, 'SUPER_POWER' as c_uid
    select 'RHYPERIOR_NORMAL' as pokemon_uid, 'MUD_SLAP' as f_uid, 'SURF' as c_uid
    select 'ELECTRODE' as pokemon_uid, 'VOLT_SWITCH' as f_uid, 'FOUL_PLAY' as c_uid
    select 'ELECTRODE' as pokemon_uid, 'VOLT_SWITCH' as f_uid, 'DISCHARGE' as c_uid
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'NIGHT_SLASH' as c_uid
    select 'DRAPION' as pokemon_uid, 'ICE_FANG' as f_uid, 'AQUA_TAIL' as c_uid
With Z as(
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'NIGHT_SLASH' as c_uid
), O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from Z
    join pokemon_pattern_combat a using(pokemon_uid,f_uid,c_uid)
    join top_iv b on b.uid=Z.pokemon_uid
    where b.cap=1500
    and a.c_uid != 'FRUSTRATION'
    and B.cp>1400
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    --join cup_rose H on H.uid=a.pokemon_uid
    where b.cap=1500 
    --and H.uid is not null
    and a.c_uid != 'FRUSTRATION'
    and B.cp>1400
    --and a.pokemon_uid in ('GRAVELER_ALOLA','GOLEM_ALOLA') and a.f_uid='ROCK_THROW' and a.c_uid='ROCK_BLAST'
), B as(
    select *,
    Floor(1.3 * 0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(1.3 * 0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(1.3 * 0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(1.3 * 0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,type_1,type_2,f_uid,f_type,c_uid,c_type,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_ene, f_dur, c_dmg, c_ene, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_ene, o_f_dur, o_c_dmg, o_c_ene, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg,
    Round(100 * (Floor((Ceil(c_ene::numeric / f_ene) * f_dur) / o_f_dur) * o_f_dmg) / hpt, 1) as firstdmg
    from B
)
select 
    D.jp,
    --C.pokemon_uid,type_1,type_2,
    --E.jp,
    f_uid,f_type,
    --F.jp,
    c_uid,c_type,
    f_dps,charge as chg,chg_dmg,c_dmg, cycle_dmg,
    kill0,death0,kill1,death1,kill2,death2,
    o_f_dps,o_charge as o_chg,o_chg_dmg,o_c_dmg, o_cycle_dmg,
    --firstdmg,
    Round(o_f_dps / f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
where true
    and C.pokemon_uid in ('SABLEYE_NORMAL','MEDICHAM','PROBOPASS','SKARMORY','WIGGLYTUFF','MAROWAK_ALOLA')
--and kill0<death0
--and kill2<death2
--and 'FIGHTING' in (type_1,type_2)
--and C.pokemon_uid='DRAPION'
--and f_dps / o_f_dps>1.0
order by 
--f_dps / o_f_dps desc
kill0/death0 * kill2/death2, charge
;




--技の確認
select
    pokemon_uid,type_1,type_2,
    f_uid,f_type,f_stab_pow as fpow, f_dur,f_ene,
    Round((c_ene::numeric/f_ene)*f_dur,1) as chg,
    c_uid,c_type,c_stab_pow as cpow, c_ene
from pokemon_pattern_combat A
where true
-- and A.pokemon_uid in ('MEDICHAM','MACHAMP','MAROWAK_ALOLA','PROBOPASS','STEELIX_NORMAL','SKARMORY','GOLBAT_NORMAL','SABLEYE_NORMAL','DRIFBLIM','HAUNTER','WIGGLYTUFF','CLEFABLE','GLIGAR','GLISCOR','NIDOKING','RHYPERIOR_NORMAL','SOLROCK','GLALIE','MAGCARGO','MUK_ALOLA','VILEPLUME_NORMAL','DRAPION','SKUNTANK','VENOMOTH_NORMAL','ESCAVALIER','FERROTHORN','WORMADAM_TRASH','BLAZIKEN','CHARIZARD_NORMAL','CASTFORM_SUNNY','GRAVELER_ALOLA','CRUSTLE','SCIZOR_NORMAL','EXCADRILL','ELECTRODE','AGGRON','GOLEM_ALOLA','FORRETRESS','MAGNEZONE_NORMAL')
-- and A.f_type='GROUND'
-- and A.c_type='GROUND'
and A.pokemon_uid=puid('GIRATINA_ORIGIN')
order by f_uid, (c_ene::numeric/f_ene)*f_dur;

