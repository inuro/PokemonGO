-- latest version(3/3/2020)

-- latest version
select now();
BEGIN;
drop table if exists win_lose;
create table win_lose as (
WITH 
-- eligible Pokemon uid/types
AAA as(
    select 
        B.uid,b.hpt,b.atk,b.def,
        A.type_1,A.type_2 
    from top_IV B
    join pokemon A on A.uid=B.uid
    where
    B.cap=1500
    and B.cp>1200
    --and B.uid in (select uid from cup_toxic)
),
-- eligible Pokemon all patterns
-- 3/3/2020 support Shadow Bonus
AA as(
    select
        B.pokemon_uid as uid, 
        --B.type_1, B.type_2, 
        B.f_uid, B.f_type, B.f_dur, B.f_ene, 
        --B.f_stab_pow,
        (0.5 * 1.3 * B.f_stab_pow * AAA.atk * (case when B.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end)) as f_pow,
        B.c_uid, B.c_type, B.c_ene, 
        --B.c_stab_pow,
        (0.5 * 1.3 * B.c_stab_pow * AAA.atk * (case when B.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end)) as c_pow,
        AAA.hpt,
        --AAA.atk,
        AAA.def / (case when B.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end) as def
    from AAA
    join pokemon_pattern_combat B on B.pokemon_uid=AAA.uid
),
-- moves efficiencies
EFFE as(
    select 
        PLAYER.uid,PLAYER.f_uid,PLAYER.f_type,PLAYER.c_uid,PLAYER.c_type,
        OPPONENT.uid as o_uid,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff
    from AA as PLAYER
    join AAA as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
), 
C as(
    select
        PLAYER.uid, PLAYER.f_uid, PLAYER.f_type, PLAYER.c_uid, PLAYER.c_type,
        OPPONENT.uid as o_uid, OPPONENT.f_uid as o_f_uid, OPPONENT.f_type as o_f_type, OPPONENT.c_uid as o_c_uid, OPPONENT.c_type as o_c_type,
        calc_killtime_combat(OPPONENT.hpt, (FLOOR(EF_P.f_eff * PLAYER.f_pow / OPPONENT.def) + 1), PLAYER.f_ene, PLAYER.f_dur, (FLOOR(EF_P.c_eff * PLAYER.c_pow / OPPONENT.def) + 1), PLAYER.c_ene, 0) as kill0,
        calc_killtime_combat(OPPONENT.hpt, (FLOOR(EF_P.f_eff * PLAYER.f_pow / OPPONENT.def) + 1), PLAYER.f_ene, PLAYER.f_dur, (FLOOR(EF_P.c_eff * PLAYER.c_pow / OPPONENT.def) + 1), PLAYER.c_ene, 2) as kill2,
        calc_killtime_combat(PLAYER.hpt, (FLOOR(EF_O.f_eff * OPPONENT.f_pow / PLAYER.def) + 1), OPPONENT.f_ene, OPPONENT.f_dur, (FLOOR(EF_O.c_eff * OPPONENT.c_pow / PLAYER.def) + 1), OPPONENT.c_ene, 0) as death0,
        calc_killtime_combat(PLAYER.hpt, (FLOOR(EF_O.f_eff * OPPONENT.f_pow / PLAYER.def) + 1), OPPONENT.f_ene, OPPONENT.f_dur, (FLOOR(EF_O.c_eff * OPPONENT.c_pow / PLAYER.def) + 1), OPPONENT.c_ene, 2) as death2
    --    (FLOOR(EF_P.f_eff * PLAYER.f_pow / OPPONENT.def) + 1)::numeric as f_dmg,
    --    (FLOOR(EF_P.c_eff * PLAYER.c_pow / OPPONENT.def) + 1)::numeric as c_dmg,
    --    (FLOOR(EF_O.f_eff * OPPONENT.f_pow / PLAYER.def) + 1)::numeric as o_f_dmg,
    --    (FLOOR(EF_O.c_eff * OPPONENT.c_pow / PLAYER.def) + 1)::numeric as o_c_dmg
    --    EF_P.f_eff as f_eff, EF_P.c_eff as c_eff,
    --    EF_O.f_eff as o_f_eff, EF_O.c_eff as o_c_eff
    from AA as PLAYER
    join AA as OPPONENT on true
    left join EFFE as EF_P on EF_P.uid=PLAYER.uid and EF_P.f_uid=PLAYER.f_uid and EF_P.f_type=PLAYER.f_type and EF_P.c_uid=PLAYER.c_uid and EF_P.o_uid=OPPONENT.uid
    left join EFFE as EF_O on EF_O.uid=OPPONENT.uid and EF_O.f_uid=OPPONENT.f_uid and EF_O.f_type=OPPONENT.f_type and EF_O.c_uid=OPPONENT.c_uid and EF_O.o_uid=PLAYER.uid
)
, E as(
    select 
        *,
        sum(case when kill0 < death0 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as win0,
        sum(case when kill2 < death2 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as win2,
        sum(case when kill0 < death0 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, o_uid) as win0_u,
        sum(case when kill0 >= death0 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, o_uid) as lose0_u,
        sum(case when kill2 < death2 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, o_uid) as win2_u,
        sum(case when kill2 >= death2 then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, o_uid) as lose2_u
    from C
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
    group by uid, f_uid, f_type, c_uid, c_type, o_uid, lose0_u, lose2_u
)
-- zero win
,G as(
    select distinct
        uid, f_uid, f_type, c_uid, 
        --c_type, opponent_uid, win0_u, win2_u,
        sum(case when win0_u = 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as victim0,
        sum(case when win2_u = 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as victim2
    from E
    group by uid, f_uid, f_type, c_uid, c_type, o_uid, win0_u, win2_u
)
, Z as(
    select count(*) as total, count(distinct uid) as total_unique from AA
)
, H as(
select
    1500 as cap,
    uid, 
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
group by E.uid, E.f_uid, E.f_type, E.c_uid, E.c_type, E.win0, E.win2, Z.total, Z.total_unique
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













-- latest version

select now();
BEGIN;
drop table if exists win_lose;
create table win_lose as (
WITH A as (
    select *
    from pokemon_pattern_combat A
    left join top_IV B on B.uid=A.pokemon_uid and B.cap=1500
--    where A.pokemon_uid in ('GOLEM_NORMAL','UMBREON','MANDIBUZZ')
--    where A.pokemon_uid ~ 'BULBASAUR'
--    where A.pokemon_uid in ('AZUMARILL','WHISCASH','ALTARIA','POLIWRATH_NORMAL')
--    where A.pokemon_uid in ('AZUMARILL','ALTARIA','BULBASAUR_NORMAL')
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


--2500
select now();
BEGIN;
insert into win_lose
WITH A as (
    select *
    from pokemon_pattern_combat A
    left join top_IV B on B.uid=A.pokemon_uid and B.cap=2500
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
        2500 as cap,
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
;
COMMIT;
select now();


--5500
select now();
BEGIN;
insert into win_lose
WITH A as (
    select *
    from pokemon_pattern_combat A
    join top_IV B on B.uid=A.pokemon_uid and B.cap=5500
    --limit 200
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
        5500 as cap,
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
;
COMMIT;
select now();











--overall list 1500
With A as(
    select A.*, 
    (c_ene::numeric/f_ene)*f_dur as charge_time,
    f_stab_pow / f_dur as f_dps,
    ((c_ene::numeric/f_ene) * f_stab_pow + c_stab_pow) / ((c_ene::numeric/f_ene)*f_dur) as t_dps,
    rank() over (order by win0+win2 desc) rnk_all,
--    rank() over (partition by uid order by counter0+counter2 desc) rnk_each
    rank() over (partition by uid order by win0+win2 desc) rnk_each
    from win_lose A
    join pokemon_pattern_combat B on B.pokemon_uid=A.uid and B.f_uid=A.f_uid and B.f_type=A.f_type and B.c_uid=A.c_uid
    where A.cap=1500
)
select 
    A.uid,
    AA.jp,B.jp,C.jp,
    D.cp,D.lv,D.hpt,
    --D.atk,D.def,
    Round(charge_time,1) as chg,
    Round(f_dps,1) as f_dps,
    Round(t_dps,1) as t_dps,
    win0,lose0,win2,lose2,counter0 as ctr0, counter2 as ctr2,victim0 as vtm0, victim2 as vtm2,rnk_all as rnk
from A 
join localize_pokemon AA on AA.uid=A.uid 
join localize_fastmove B on B.uid=A.f_uid 
join localize_chargemove C on C.uid=A.c_uid 
join top_iv D on D.uid=A.uid and D.cap=1500
where rnk_each=1 order by rnk_all;



--overall list 2500
With A as(
    select B.jp,A.*, 
    rank() over (order by win0+win2 desc) rnk_all,
--    rank() over (partition by uid order by counter0+counter2 desc) rnk_each
    rank() over (partition by uid order by win0+win2 desc) rnk_each
    from win_lose A join localize_pokemon B using(uid)
    where A.cap=2500
)
select A.jp,B.jp,C.jp,D.cp,D.lv,D.hpt,D.atk,D.def,win0,lose0,win2,lose2,counter0 as ctr0, counter2 as ctr2,victim0 as vtm0, victim2 as vtm2,rnk_all as rnk
from A 
join localize_fastmove B on B.uid=A.f_uid 
join localize_chargemove C on C.uid=A.c_uid 
join top_iv D on D.uid=A.uid and D.cap=2500
where rnk_each=1 order by rnk_all;










--old

select now();
BEGIN;
insert into win_lose
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 2500, 15,15,15) B on true
--    where A.pokemon_uid in ('GIRATINA_ALTERED','LATIAS','MUK_ALOLA','TYRANITAR')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.type_1 as type_1,
        PLAYER.type_2 as type_2,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
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
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        uid,type_1,type_2,f_uid,f_type,c_uid,c_type,
        opponent_uid,opponent_f_uid,opponent_c_uid,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), E as(
    select 
        *,
        sum(case when death>=kill then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as win,
        sum(case when death<kill then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as lose,
        sum(case when death_b>=kill_b then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as win_b,
        sum(case when death_b<kill_b then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as lose_b,
        sum(case when death<kill and death_b<kill_b then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as num_of_counter_unique
    from D
)
select distinct
    2500 as cap,
    uid,type_1,type_2,f_uid,f_type,c_uid,c_type,
    win,lose,win_b,lose_b,
    sum(num_of_counter_unique) over (partition by uid,f_uid,f_type,c_uid) as counter,
    sum(case when num_of_counter_unique > 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as counter_unique
from E
group by uid,type_1,type_2,f_uid,f_type,c_uid,c_type,lose,win,lose_b,win_b,opponent_uid,num_of_counter_unique
;
COMMIT;
select now();

select now();
BEGIN;
insert into win_lose
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 1500, 15,15,15) B on true
--    where A.pokemon_uid in ('GIRATINA_ALTERED','LATIAS','MUK_ALOLA','TYRANITAR')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.type_1 as type_1,
        PLAYER.type_2 as type_2,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
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
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        uid,type_1,type_2,f_uid,f_type,c_uid,c_type,
        opponent_uid,opponent_f_uid,opponent_c_uid,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), E as(
    select 
        *,
        sum(case when death>=kill then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as win,
        sum(case when death<kill then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as lose,
        sum(case when death_b>=kill_b then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as win_b,
        sum(case when death_b<kill_b then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as lose_b,
        sum(case when death<kill and death_b<kill_b then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as num_of_counter_unique
    from D
)
select distinct
    1500 as cap,
    uid,type_1,type_2,f_uid,f_type,c_uid,c_type,
    win,lose,win_b,lose_b,
    sum(num_of_counter_unique) over (partition by uid,f_uid,f_type,c_uid) as counter,
    sum(case when num_of_counter_unique > 0 then 1 else 0 end) over (partition by uid,f_uid,f_type,c_uid) as counter_unique
from E
group by uid,type_1,type_2,f_uid,f_type,c_uid,c_type,lose,win,lose_b,win_b,opponent_uid,num_of_counter_unique
;
COMMIT;
select now();









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
create table win_lose as (select * from count_win_lose_pattern(5500));
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
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','ANCIENT_POWER') A
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
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW') A
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
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','ANCIENT_POWER') A
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
--and kill/death < 0.9 and kill_b/death_b<0.9
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
from calc_counter_combat('SNORLAX',5500,15,15,15,'LICK','OUTRAGE') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
--and kill/death < 0.9 and kill_b/death_b<0.9
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
from calc_counter_combat('キノガッサ',2500,15,15,15,'カウンター','くさむすび') A
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
from calc_counter_combat('マニューラ',2500,15,15,15,'こおりのつぶて','ゆきなだれ') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;




drop function if exists calc_cost(current_lv numeric, target_lv numeric);
create function calc_cost(current_lv numeric, target_lv numeric)
returns table (stardust integer, candy integer) as '
DECLARE
    row record;
    _candy integer := 0;
    _stardust integer := 0;
BEGIN
    FOR row in select * from stardust_candy loop
        CONTINUE WHEN row.lv < current_lv;
        EXIT WHEN row.lv=target_lv;
        _candy := _candy + row.candy;
        _stardust := _stardust + row.stardust;
    end loop;
    return query select _stardust, _candy;
    return;
END
' LANGUAGE 'plpgsql';


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
from calc_counter_combat('カメックス',1500,15,15,15,'みずでっぽう','ハイドロカノン') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.85 and kill_b/death_b<0.85
order by kill/death * kill_b/death_b;



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
from calc_counter_combat('パルキア',5500,15,15,15,'りゅうのいぶき','ハイドロポンプ') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
--and kill/death < 0.9 and kill_b/death_b<0.9
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
from calc_counter_combat('パルキア',5500,15,15,15,'りゅうのいぶき','だいもんじ') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
--and kill/death < 0.9 and kill_b/death_b<0.9
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
from calc_counter_combat('パルキア',5500,15,15,15,'りゅうのいぶき','りゅうせいぐん') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
--and kill/death < 0.9 and kill_b/death_b<0.9
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
from calc_counter_combat('バシャーモ',5500,15,15,15,'カウンター','きあいだま') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by A.index, kill/death;



select *
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap=5500
) A 
order by counter_unique;



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
from calc_counter_combat('TANGROWTH',5500,15,15,15,'VINE_WHIP','SOLAR_BEAM') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
and kill/death < 0.9 and kill_b/death_b<0.9
order by kill/death;



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
from calc_counter_combat('ゲンガー',5500,15,15,15,'シャドークロー','シャドーボール') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by kill/death * kill_b/death_b;

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
from calc_counter_combat('ギャラドス',1500,15,15,15,'たきのぼり','ハイドロポンプ') A
join pokemon F on F.uid=A.uid
where kill<death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by kill/death * kill_b/death_b;


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
from calc_counter_combat('RAIKOU',5500,15,15,15,'THUNDER_SHOCK','SHADOW_BALL') A
join pokemon F on F.uid=A.uid
where true
--and kill<death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
and A.uid in ('GIRATINA_ALTERED','LATIOS','LATIAS','MEWTWO','KYOGRE','PALKIA')
order by A.index, kill/death * kill_b/death_b;

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
from calc_counter_combat('RAIKOU',5500,15,15,15,'THUNDER_SHOCK','SHADOW_BALL') A
join pokemon F on F.uid=A.uid
where true
and kill<death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED','LATIOS','LATIAS','MEWTWO','KYOGRE','PALKIA')
order by A.index, kill/death * kill_b/death_b;



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
from calc_counter_combat('DIALGA',5500,15,15,15,'DRAGON_BREATH','IRON_HEAD') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED','LATIOS','LATIAS','MEWTWO','KYOGRE','PALKIA')
order by kill/death * kill_b/death_b;


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
from calc_counter_combat('DIALGA',5500,15,15,15,'DRAGON_BREATH','THUNDER') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED','LATIOS','LATIAS','MEWTWO','KYOGRE','PALKIA')
order by kill/death * kill_b/death_b;



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
from calc_counter_combat('DIALGA',5500,15,15,15,'DRAGON_BREATH','DRACO_METEOR') A
join pokemon F on F.uid=A.uid
where true
--and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
and A.uid in ('GIRATINA_ALTERED')
order by kill/death * kill_b/death_b;


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
from calc_counter_combat('ギラティナ',5500,15,15,15,'シャドークロー','ドラゴンクロー') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED','LATIOS','LATIAS','MEWTWO','KYOGRE','PALKIA')
order by kill/death * kill_b/death_b;


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
from calc_counter_combat('DIALGA',5500,15,15,15,'DRAGON_BREATH','IRON_HEAD') A
join pokemon F on F.uid=A.uid
where true
--and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
and A.uid in ('GIRATINA_ALTERED')
order by kill/death * kill_b/death_b;



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
from calc_counter_combat('AZUMARILL',1500,15,15,15,'BUBBLE','PLAY_ROUGH') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by kill/death * kill_b/death_b;

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
from calc_counter_combat('AZUMARILL',1500,15,15,15,'BUBBLE','HYDRO_PUMP') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by kill/death * kill_b/death_b;


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
from calc_counter_combat('ジュカイン',1500,15,15,15,'れんぞくぎり','リーフブレード') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by kill/death * kill_b/death_b;

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
from calc_counter_combat('ルンパッパ',1500,15,15,15,'はっぱカッター','れいとうビーム') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by kill/death * kill_b/death_b;

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
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by kill/death * kill_b/death_b;



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
from calc_counter_combat('カビゴン',5500,15,15,15,'LICK','OUTRAGE') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by A.index, kill/death * kill_b/death_b;

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
from calc_counter_combat('カビゴン',5500,15,15,15,'LICK','BODY_SLAM') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by A.index, kill/death * kill_b/death_b;




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
from calc_counter_combat('マリルリ',1500,15,15,15,'あわ','ICE_BEAM') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by A.index, kill/death * kill_b/death_b;

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
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by A.index, kill/death * kill_b/death_b;

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
from calc_counter_combat('ゴウカザル',2500,15,15,15,'FIRE_SPIN','CLOSE_COMBAT') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by kill/death, A.index;

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
from calc_counter_combat('ゴウカザル',2500,15,15,15,'FIRE_SPIN','CLOSE_COMBAT') A
join pokemon F on F.uid=A.uid
where true
and kill > death and kill_b > death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
--and A.uid in ('GIRATINA_ALTERED')
order by hpt*atk*def desc;


select B.jp,A.* from win_lose A join localize_pokemon B on B.uid=A.uid where cap='2500' order by counter_unique;


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
from calc_counter_combat('パルキア',5500,15,15,15,'DRAGON_BREATH','DRACO_METEOR') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by A.index, kill/death * kill_b/death_b;


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
from calc_counter_combat('パルキア',5500,15,15,15,'DRAGON_BREATH','FIRE_BLAST') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by A.index, kill/death * kill_b/death_b;

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
from calc_counter_combat('パルキア',5500,15,15,15,'DRAGON_BREATH','HYDRO_PUMP') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by A.index, kill/death * kill_b/death_b;


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
from calc_counter_combat('MAMOSWINE',5500,15,15,15,'POWDER_SNOW','AVALANCHE') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by A.index, kill/death * kill_b/death_b;


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
from calc_counter_combat('MAMOSWINE',5500,15,15,15,'POWDER_SNOW','ANCIENT_POWER') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by A.index, kill/death * kill_b/death_b;

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
from calc_counter_combat('MAMOSWINE',5500,15,15,15,'POWDER_SNOW','STONE_EDGE') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by A.index, kill/death * kill_b/death_b;


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
from calc_counter_combat('カビゴン',5500,15,15,15,'LICK','HEAVY_SLAM') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by kill/death;


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
from calc_counter_combat('カビゴン',5500,15,15,15,'ZEN_HEADBUTT','HEAVY_SLAM') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by kill/death;


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
from calc_counter_combat('チルタリス',1500,15,15,15,'DRAGON_BREATH','SKY_ATTACK') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by kill/death;

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
from calc_counter('ハピナス',1500,15,15,15,'はたく','マジカルシャイン') A
join pokemon F on F.uid=A.uid
where true
and kill < death and kill_b < death_b
--and kill/death < 0.85 and kill_b/death_b<0.85
order by kill/death;






With Z as(
    select 'VIGOROTH' as pokemon_uid, 'COUNTER' as f_uid, 'BODY_SLAM' as c_uid
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
firstdmg,
Round(f_dps / o_f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
where true
and kill0<death0
and kill2<death2
order by kill2 / death0, charge;




-- https://www.evernote.com/shard/s114/client/snv?fbclid=IwAR0NQ_is_iKFZzZZdn4x6XYw6Z6VLpFVgjbK3Zb1-zQIfGwe8ErblnjPM-c&noteGuid=51035b72-13a5-464e-a7ff-1bdd6586e75b&noteKey=0b8ddda62c0e951d9f837ded50e74d46&sn=https%3A%2F%2Fwww.evernote.com%2Fshard%2Fs114%2Fsh%2F51035b72-13a5-464e-a7ff-1bdd6586e75b%2F0b8ddda62c0e951d9f837ded50e74d46&title=%25E3%2580%2590%25E3%2583%259D%25E3%2582%25B1%25E3%2583%25A2%25E3%2583%25B3GO%25E3%2580%2591PvP%25E3%2583%25A9%25E3%2583%25B3%25E3%2582%25AD%25E3%2583%25B3%25E3%2582%25B0%2B%25E4%25BA%25BA%25E6%25B0%2597%25E3%2583%259D%25E3%2582%25B1%25E3%2583%25A2%25E3%2583%25B3%25E3%2583%25AA%25E3%2583%25BC%25E3%2582%25B0%25E5%2588%25A5

\a
\pset fieldsep ','
WITH A as (
    select *
    from pokemon_pattern_combat A
    left join top_IV B on B.uid=A.pokemon_uid and B.cap=5500
    where A.pokemon_uid in (puid('ディアルガ'),puid('ヒードラン'),puid('メタグロス'),puid('ミュウツー'),puid('カイリュー'),puid('トゲキッス'),puid('カイオーガ'),puid('バンギラス'),puid('ライコウ'),puid('カイリキー'),puid('GIRATINA_ALTERED'),puid('GIRATINA_ORIGIN'),puid('ラグラージ'),puid('カビゴン'),puid('グラードン'),puid('ルギア'),puid('ギャラドス'),puid('ローブシン'),puid('ルカリオ'),puid('サーナイト'),puid('レックウザ'),puid('ドリュウズ'),puid('ダークライ'),puid('ラティオス'),puid('ドサイドン'),puid('ガブリアス'),puid('ボーマンダ'),puid('メルメタル'))
    and A.f_uid not in ('YAWN')
    and A.c_uid not in ('FRUSTRATION')
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
        5500 as cap,
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
    L1.jp,L2.jp,f_type,L3.jp,c_type,
    win0,lose0,win2,lose2,
    F.counter0, F.counter2,
    G.victim0, G.victim2
from H
left join F using(uid,f_uid,f_type,c_uid)
left join G using(uid,f_uid,f_type,c_uid)
join localize_pokemon L1 on L1.uid=H.uid join localize_fastmove L2 on L2.uid=H.f_uid join localize_chargemove L3 on L3.uid=H.c_uid

order by win0*win2 desc
;




-- カウンター
\a
\pset fieldsep ','
    select 'VIGOROTH' as pokemon_uid, 'COUNTER' as f_uid, 'BODY_SLAM' as c_uid
    select 'MAROWAK_ALOLA' as pokemon_uid, 'ROCK_SMASH' as f_uid, 'BONE_CLUB' as c_uid
    select 'MEDICHAM' as pokemon_uid, 'COUNTER' as f_uid, 'POWER_UP_PUNCH' as c_uid
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'ICE_BEAM' as c_uid
    select 'AZUMARILL' as pokemon_uid, 'BUBBLE' as f_uid, 'PLAY_ROUGH' as c_uid
    select 'AZUMARILL' as pokemon_uid, 'BUBBLE' as f_uid, 'ICE_BEAM' as c_uid
    select 'SWAMPERT_NORMAL' as pokemon_uid, 'MUD_SHOT' as f_uid, 'HYDRO_CANNON' as c_uid
    select 'EMPOLEON' as pokemon_uid, 'WATERFALL' as f_uid, 'HYDRO_CANNON' as c_uid
    select 'NOCTOWL' as pokemon_uid, 'WING_ATTACK' as f_uid, 'SKY_ATTACK' as c_uid
    select 'MUK_ALOLA' as pokemon_uid, 'SNARL' as f_uid, 'DARK_PULSE' as c_uid
    select 'ALTARIA' as pokemon_uid, 'DRAGON_BREATH' as f_uid, 'SKY_ATTACK' as c_uid
    select 'DEOXYS_DEFENSE' as pokemon_uid, 'COUNTER' as f_uid, 'PSYCHO_BOOST' as c_uid
    select 'FROSLASS' as pokemon_uid, 'POWDER_SNOW' as f_uid, 'AVALANCHE' as c_uid
    select 'TROPIUS' as pokemon_uid, 'AIR_SLASH' as f_uid, 'LEAF_BLADE' as c_uid
    select 'TROPIUS' as pokemon_uid, 'AIR_SLASH' as f_uid, 'AERIAL_ACE' as c_uid
    select 'WHISCASH' as pokemon_uid, 'MUD_SHOT' as f_uid, 'MUD_BOMB' as c_uid
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'PLAY_ROUGH' as c_uid
    select 'BASTIODON' as pokemon_uid, 'SMACK_DOWN' as f_uid, 'STONE_EDGE' as c_uid
    select 'BASTIODON' as pokemon_uid, 'SMACK_DOWN' as f_uid, 'FLASH_CANNON' as c_uid
    select 'SKARMORY' as pokemon_uid, 'AIR_SLASH' as f_uid, 'SKY_ATTACK' as c_uid
    select 'HYPNO_NORMAL' as pokemon_uid, 'CONFUSION' as f_uid, 'SHADOW_BALL' as c_uid
    select 'REGISTEEL' as pokemon_uid, 'LOCK_ON' as f_uid, 'FLASH_CANNON' as c_uid
    select 'PROBOPASS' as pokemon_uid, 'ROCK_THROW' as f_uid, 'ROCK_SLIDE' as c_uid

With Z as(
    select 'PROBOPASS' as pokemon_uid, 'ROCK_THROW' as f_uid, 'ROCK_SLIDE' as c_uid
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
firstdmg,
Round(f_dps / o_f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
where true
--and C.pokemon_uid in ('VIGOROTH','NOCTOWL','MUK_ALOLA','ALTARIA','PROBOPASS','GLIGAR','UMBREON')
and C.pokemon_uid in ('ALOMOMOLA','ALTARIA','AZUMARILL','BASTIODON','BLASTOISE_NORMAL','CASTFORM_RAINY','CLEFABLE','CRESSELIA','DEOXYS_DEFENSE','DEWOTT','DRAGONAIR_NORMAL','DRAGONITE_NORMAL','DRAPION','DUNSPARCE','EMPOLEON','FORRETRESS','GLIGAR','HARIYAMA','HITMONTOP','HYDREIGON','JIRACHI','KINGDRA','LANTURN','LAPRAS_NORMAL','LATIAS','LINOONE_NORMAL','LUMINEON','MANDIBUZZ','MARSHTOMP_NORMAL','MEDICHAM','MELMETAL','MEWTWO_A','MILOTIC','MUK_ALOLA','MUNCHLAX','NOCTOWL','POLITOED_NORMAL','PROBOPASS','QUAGSIRE','RATICATE_ALOLA','REGIROCK','REGISTEEL','RELICANTH','RESHIRAM','SABLEYE_NORMAL','SCRAFTY','SEALEO','SHELGON_NORMAL','SKARMORY','SKUNTANK','SNORLAX_NORMAL','STEELIX_NORMAL','STUNFISK','SWAMPERT_NORMAL','TROPIUS','UMBREON','VIGOROTH','WAILMER','WHISCASH','WORMADAM_TRASH')
--and C.pokemon_uid='MEDICHAM'
--and kill0<death0
--and kill2<death2
--and 'FIGHTING' in (type_1,type_2)
and C.pokemon_uid='DRAPION'
order by kill0/death0 * kill2/death2, charge;



-- ハイパーリーグ
    select 'GIRATINA_ALTERED' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'DRAGON_CLAW' as c_uid
    select 'GIRATINA_ALTERED' as pokemon_uid, 'DRAGON_BREATH' as f_uid, 'DRAGON_CLAW' as c_uid
    select 'DIALGA' as pokemon_uid, 'DRAGON_BREATH' as f_uid, 'IRON_HEAD' as c_uid

With Z as(
    select 'GIRATINA_ALTERED' as pokemon_uid, 'DRAGON_BREATH' as f_uid, 'DRAGON_CLAW' as c_uid
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
    where b.cap=2500
    and a.c_uid != 'FRUSTRATION'
    and B.cp>2000
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
    where b.cap=2500 
    --and H.uid is not null
    and a.c_uid != 'FRUSTRATION'
    and B.cp>2000
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
and pokemon_uid='POLIWRATH_NORMAL'
--and kill0<death0
--and kill2<death2
order by o_chg_dmg, kill2 / death0, charge;




-- ハイパーリーグ
    select 'GIRATINA_ALTERED' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'DRAGON_CLAW' as c_uid
    select 'DIALGA' as pokemon_uid, 'DRAGON_BREATH' as f_uid, 'IRON_HEAD' as c_uid

With Z as(
    select 'REGISTEEL' as pokemon_uid, 'LOCK_ON' as f_uid, 'FLASH_CANNON' as c_uid
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
    where b.cap=2500
    and a.c_uid != 'FRUSTRATION'
    --and B.cp>2400
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
    where b.cap=2500 
    --and H.uid is not null
    and a.c_uid != 'FRUSTRATION'
    --and B.cp>2500
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
and kill0<death0
and kill2<death2
order by kill2 / death0, charge;



-- ハイパーリーグ、overallの確認用
with a as(
    select 
        rank() over(order by win0*win2 desc) as rnk_a, 
        rank() over(partition by uid order by win0*win2 desc) as rnk_e, 
        *
    from win_lose A join top_iv B using(uid,cap) 
    where cap=2500 order by win0*win2 desc
)
select b.jp, a.* from a
join localize_pokemon b using(uid)
where rnk_e=1 and cp>1900 and rnk_a<1000
order by rnk_a;







case when charge>o_charge
    then o_cycle_dmg + (charge-o_charge)*o_f_dps
    else o_

    select 'VIGOROTH' as pokemon_uid, 'COUNTER' as f_uid, 'BODY_SLAM' as c_uid
    select 'UMBREON' as pokemon_uid, 'SNARL' as f_uid, 'FOUL_PLAY' as c_uid

    select 'TOGEKISS' as pokemon_uid, 'CHARM' as f_uid, 'ANCIENT_POWER' as c_uid
    select 'MELMETAL' as pokemon_uid, 'THUNDER_SHOCK' as f_uid, 'ROCK_SLIDE' as c_uid
    select 'METAGROSS' as pokemon_uid, 'BULLET_PUNCH' as f_uid, 'METEOR_MASH' as c_uid
    select 'GROUDON' as pokemon_uid, 'MUD_SHOT' as f_uid, 'EARTHQUAKE' as c_uid
    select 'DARKRAI' as pokemon_uid, 'SNARL' as f_uid, 'DARK_PULSE' as c_uid
    select 'DIALGA' as pokemon_uid, 'DRAGON_BREATH' as f_uid, 'IRON_HEAD' as c_uid
    select 'GIRATINA_ORIGIN' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'DRAGON_PULSE' as c_uid

With Z as(
    select 'GIRATINA_ORIGIN' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'DRAGON_PULSE' as c_uid
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
    where b.cap=5500
    and a.c_uid != 'FRUSTRATION'
    and B.cp>2500
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
    where b.cap=5500 
    --and H.uid is not null
    and a.c_uid != 'FRUSTRATION'
    and B.cp>2500
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
Round(f_dps / o_f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
where true
order by kill0/death0 * kill2/death2, charge;
order by cycle_dmg desc;




