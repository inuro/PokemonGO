DROP TABLE if exists fusion_cup;
CREATE TABLE fusion_cup(
    en text
);
INSERT INTO fusion_cup(en)
VALUES
('Abomasnow'),('Aggron'),('Altaria'),('Amoonguss'),('Anorith'),('Ariados'),('Armaldo'),('Aron'),('Azurill'),('Baltoy'),('Barboach'),('Beautifly'),('Beedrill'),('Beldum'),('Bellsprout'),('Bibarel'),('Blaziken'),('Breloom'),('Bronzong'),('Bronzor'),('Budew'),('Bulbasaur'),('Butterfree'),('Cacturne'),('Camerupt'),('Carvanha'),('Charizard'),('Chinchou'),('Claydol'),('Cloyster'),('Combee'),('Combusken'),('Corsola'),('Cradily'),('Crawdaunt'),('Croagunk'),('Crobat'),('Alolan Diglett'),('Dodrio'),('Doduo'),('Alolan Dugtrio'),('Durant'),('Dustox'),('Emboar'),('Empoleon'),('Excadrill'),('Exeggcute'),('Exeggutor'),('Alolan Exeggutor'),('Farfetch''d'),('Fearow'),('Foongus'),('Froslass'),('Gastly'),('Gastrodon (East Sea)'),('Gastrodon (West Sea)'),('Gengar'),('Geodude'),('Alolan Geodude'),('Girafarig'),('Gloom'),('Golbat'),('Golem'),('Alolan Golem'),('Graveler'),('Alolan Graveler'),('Alolan Grimer'),('Gyarados'),('Haunter'),('Heracross'),('Honchkrow'),('Hoothoot'),('Hoppip'),('Houndoom'),('Houndour'),('Igglybuff'),('Infernape'),('Ivysaur'),('Jigglypuff'),('Jumpluff'),('Kakuna'),('Kingdra'),('Lairon'),('Lanturn'),('Ledian'),('Ledyba'),('Lileep'),('Lombre'),('Lotad'),('Ludicolo'),('Lunatone'),('Magcargo'),('Magnemite'),('Magneton'),('Magnezone'),('Mamoswine'),('Mantyke'),('Marill'),('Alolan Marowak'),('Marshtomp'),('Masquerain'),('Meditite'),('Mime Jr.'),('Monferno'),('Mothim'),('Alolan Muk'),('Murkrow'),('Natu'),('Nidoking'),('Nidoqueen'),('Alolan Ninetales'),('Noctowl'),('Numel'),('Nuzleaf'),('Oddish'),('Paras'),('Parasect'),('Pelipper'),('Pidgeot'),('Pidgeotto'),('Pidgey'),('Pidove'),('Pignite'),('Piloswine'),('Poliwrath'),('Probopass'),('Quagsire'),('Qwilfish'),('Alolan Raichu'),('Alolan Raticate'),('Alolan Rattata'),('Rhydon'),('Rhyhorn'),('Rhyperior'),('Roselia'),('Roserade'),('Alolan Sandshrew'),('Alolan Sandslash'),('Sealeo'),('Sharpedo'),('Shiftry'),('Shuckle'),('Skiploom'),('Skuntank'),('Slowbro'),('Slowking'),('Slowpoke'),('Smoochum'),('Sneasel'),('Snover'),('Solrock'),('Spearow'),('Spheal'),('Spinarak'),('Staraptor'),('Staravia'),('Starly'),('Starmie'),('Stunky'),('Surskit'),('Swablu'),('Swampert'),('Swellow'),('Swinub'),('Taillow'),('Tentacool'),('Tentacruel'),('Togekiss'),('Togetic'),('Torterra'),('Toxicroak'),('Tranquill'),('Unfezant'),('Venomoth'),('Venonat'),('Venusaur'),('Vespiquen'),('Victreebel'),('Vileplume'),('Walrein'),('Weavile'),('Weedle'),('Weepinbell'),('Galarian Weezing'),('Whiscash'),('Wigglytuff'),('Wingull'),('Wooper'),('Xatu'),('Yanma'),('Yanmega'),('Zubat')
;

drop table if exists win_lose_fusion;
create table win_lose_fusion as (
WITH AA as(
    select A.* 
    from pokemon_pattern_combat A
    join localize_pokemon B on B.uid=A.pokemon_uid
    join fusion_cup C on C.en=B.en
    where C.en is not null
),A as (
    select *
    from AA
    join calc_all(AA.pokemon_uid, 1500, 15,15,15) B on true
--    where A.pokemon_uid in ('GIRATINA_ALTERED','TYRANITAR','LATIAS','ABRA')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.c_uid as c_uid,
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
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), Z as(
    select count(*) as total, count(distinct pokemon_uid) as total_unique from A
)
select
    uid as pokemon, 
    f_uid as fastmove, 
    c_uid as chargemove,
    1500 as cap,
    Z.total - count(*) as win,
    count(*) as lose,
    Z.total_unique - count(distinct opponent_uid) as win_unique,
    count(distinct opponent_uid) as lose_unique
from D,Z
where kill > death and kill_b > death_b
group by uid, f_uid, c_uid, Z.total, Z.total_unique
);



-- Rose cup (2020 Feb) 
-- table building
BEGIN;
drop table if exists win_lose_rose;
create table win_lose_rose as (
WITH AA as(
    select A.* 
    from pokemon_pattern_combat A
    join cup_rose C on C.uid=A.pokemon_uid
    where C.uid is not null
    --limit 20
),A as (
    select AA.*, cp,lv,hpt,atk,def
    from AA
    join top_IV B on B.uid=AA.pokemon_uid where B.cap=1500
    -- join calc_all(AA.pokemon_uid, 1500, 15,15,15) B on true
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
        OPPONENT.f_type as o_f_type,
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
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), Z as(
    select count(*) as total, count(distinct pokemon_uid) as total_unique from A
)
select
    uid as pokemon, 
    type_1,
    type_2,
    f_uid as fastmove, 
    f_type as f_type,
    c_uid as chargemove,
    c_type as c_type,
    1500 as cap,
    Z.total - count(*) as win,
    count(*) as lose,
    Z.total_unique - count(distinct opponent_uid) as win_unique,
    count(distinct opponent_uid) as lose_unique
from D,Z
where kill > death and kill_b > death_b
group by uid, type_1, type_2, f_uid, f_type, c_uid, c_type, Z.total, Z.total_unique
);
COMMIT;





--test
WITH AA as(
    select A.* 
    from pokemon_pattern_combat A
    join cup_rose C on C.uid=A.pokemon_uid
    where C.uid is not null
    limit 20
),A as (
    select AA.*, cp,lv,hpt,atk,def
    from AA
    join top_IV B on B.uid=AA.pokemon_uid where B.cap=1500
    -- join calc_all(AA.pokemon_uid, 1500, 15,15,15) B on true
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.f_type,
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
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), Z as(
    select count(*) as total, count(distinct pokemon_uid) as total_unique from A
)
select
    uid as pokemon, 
    f_uid as fastmove, 
    f_type,
    c_uid as chargemove,
    1500 as cap,
    Z.total - count(*) as win,
    count(*) as lose,
    Z.total_unique - count(distinct opponent_uid) as win_unique,
    count(distinct opponent_uid) as lose_unique
from D,Z
where kill > death and kill_b > death_b
group by uid, f_uid, c_uid, Z.total, Z.total_unique
;




-- Rosecup overallランキング

select 
B.jp, 
A.type_1,A.type_2,
A.fastmove,A.f_type,
A.chargemove,A.c_type,
A.win, A.lose, A.win_unique,A.lose_unique
from win_lose_rose A 
left join localize_pokemon B on B.uid=A.pokemon 
order by win desc;

-- それぞれのポケモン種ごと
With A as(
select 
B.jp, 
A.type_1,A.type_2,
A.fastmove,A.f_type,
A.chargemove,A.c_type,
A.win, A.lose, A.win_unique,A.lose_unique,
rank() over (order by win desc) rnk_ttl,
rank() over (partition by A.pokemon order by win desc) rnk_each
from win_lose_rose A 
left join localize_pokemon B on B.uid=A.pokemon 
)
select jp,fastmove,chargemove,rnk_ttl from A
where rnk_each=1
order by win desc;


With A as(
select 
A.pokemon,
B.jp, 
A.type_1,A.type_2,
A.fastmove,
C.jp,
A.f_type,
A.chargemove,
D.jp,
A.c_type,
A.win, A.lose, A.win_unique,A.lose_unique,
rank() over (order by win desc) rnk_ttl,
rank() over (partition by A.pokemon order by win desc) rnk_each
from win_lose_rose A 
left join localize_pokemon B on B.uid=A.pokemon 
left join localize_fastmove C on C.uid=A.fastmove
left join localize_chargemove D on D.uid=A.chargemove
)
select * from A
order by win desc;



\a
\pset fieldsep ','

With A as(
    select 
    A.pokemon,
    B.jp as pokemon_jp, 
    A.type_1,A.type_2,
    A.fastmove,
    C.jp as fastmove_jp,
    A.f_type,
    A.chargemove,
    D.jp as chargemove_jp,
    A.c_type,
    A.win, A.lose, A.win_unique,A.lose_unique,
    rank() over (order by win desc) rnk_ttl,
    rank() over (partition by A.pokemon order by win desc) rnk_each
    from win_lose_rose A 
    left join localize_pokemon B on B.uid=A.pokemon 
    left join localize_fastmove C on C.uid=A.fastmove
    left join localize_chargemove D on D.uid=A.chargemove
), B as(
    select 
        A.*, 
        f_stab_pow,
        Ceil(c_ene::numeric / f_ene) * f_dur as chargetime,
        c_stab_pow
    from A
    join pokemon_pattern_combat B on B.pokemon_uid=A.pokemon and B.f_uid=A.fastmove and B.c_uid=A.chargemove and B.f_type=A.f_type
)
select * from B
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
from calc_counter_combat('BLAZIKEN',1500,15,15,15,'COUNTER','BLAST_BURN') A
join pokemon F on F.uid=A.uid
join cup_rose H on H.uid=A.uid
where kill/death < 0.80 and kill_b/death_b<0.80
and H.uid is not null
)
select * from A1
order by kill/death;






 MACHAMP           | COUNTER       | ROCK_SLIDE        | 1500 |   1686 |    67 |        148 |          23

    |    |    
    where a.pokemon_uid=puid('BLAZIKEN') and a.f_uid=get_move_uid('COUNTER') and a.c_uid=get_move_uid('BLAST_BURN')
    where a.pokemon_uid=puid('MACHAMP') and a.f_uid=get_move_uid('COUNTER') and a.c_uid=get_move_uid('ROCK_SLIDE')
    where a.pokemon_uid=puid('MACHAMP') and a.f_uid=get_move_uid('COUNTER') and a.c_uid=get_move_uid('DYNAMIC_PUNCH')
    where a.pokemon_uid=puid('SABLEYE_NORMAL') and a.f_uid=get_move_uid('SHADOW_CLAW') and a.c_uid=get_move_uid('FOUL_PLAY')

    select 'BLAZIKEN' as pokemon_uid, 'COUNTER' as f_uid, 'BLAST_BURN' as c_uid
    select 'SPIRITOMB' as pokemon_uid, 'SUCKER_PUNCH' as f_uid, 'SHADOW_BALL' as c_uid
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'NIGHT_SLASH' as c_uid
    select 'GLIGAR' as pokemon_uid, 'FURY_CUTTER' as f_uid, 'NIGHT_SLASH' as c_uid
    select 'KLINKLANG' as pokemon_uid, 'THUNDER_SHOCK' as f_uid, 'MIRROR_SHOT' as c_uid

-- あるポケモンに対するカウンターROSE cup
With Z as(
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'AERIAL_ACE' as c_uid
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
    and b.cap=1500
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
), B as(
    select *,
    Floor(0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,f_uid,c_uid,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg
    from B
)
select 
--D.jp,E.jp,F.jp,
--pokemon_uid,f_uid,c_uid,
C.*,
--kill0,death0,
--kill1,death1,
--kill2,death2,
--f_dps,o_f_dps, 
Round(f_dps / o_f_dps, 1) as f_ratio
from C 
--join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
where true
--and f_dps > o_f_dps
--and kill0 < death0
and kill2 < death0
order by kill2 / death0;
--order by f_dps / o_f_dps desc;
--order by charge, cycle_dmg desc;






--  特定のポケモン同士
with O as(
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
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    where a.pokemon_uid=puid('SABLEYE_NORMAL') and a.f_uid=get_move_uid('SHADOW_CLAW') and a.c_uid=get_move_uid('FOUL_PLAY')
    and b.cap=1500
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    --join top_iv b on b.uid=a.pokemon_uid
    join calc_all_iv_pattern('SKARMORY',1500) b on b.hp=14 and b.at=0 and b.df=15
    join O on true
    join cup_rose H on H.uid=a.pokemon_uid
    where H.uid is not null
), B as(
    select *,
    Floor(0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,f_uid,c_uid,
    f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg
    from B
)
select 
--D.jp,E.jp,F.jp,
--pokemon_uid,f_uid,c_uid,
C.*,
--kill0,death0,
--kill1,death1,
--kill2,death2,
--f_dps,o_f_dps, 
Round(f_dps / o_f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid
join localize_fastmove E on E.uid=C.f_uid
join localize_chargemove F on F.uid=C.c_uid
where true
and D.jp='エアームド' 
--and kill2 < death1
--and f_dps > o_f_dps
--and kill2 < death0
order by f_dps / o_f_dps desc;




エアームド  atk 103.68 def 168.83 
エアスラッシュ  STABPOW:10.8 
ゴッドバード    STABPOW:96.0

pokemongo=# select * from calc_all_iv_pattern('SKARMORY',1500) where hp=14 and at=0 and df=15; 
      iv       |  cp  |  lv  | hp | at | df | overall | hpt | atk | def | total | dust 
---------------+------+------+----+----+----+---------+-----+-----+-----+-------+------
 HP14/AT0/DF15 | 1500 | 27.5 | 14 |  0 | 15 | C       | 123 | 103 | 168 |   394 | 4500
(1 row)

ヤミラミ atk 124 def 120 hp 120
pokemongo=# select * from top_IV where uid=puid('ヤミラミ');
      uid       |  cp  | lv | hp | at | df | hpt | atk | def | cap  
----------------+------+----+----+----+----+-----+-----+-----+------
 SABLEYE_NORMAL | 1494 | 41 | 15 | 15 | 15 | 120 | 124 | 120 | 1500
(1 row)

103.68/122.29=0.847820753945539

エアスラッシュ
Floor(0.5 * 10.8 * (103.68/122.29) * 1.0)+1 = 5
Floor(0.5 * 10.8 * (103.68/120) * 1.0)+1
5回で25ダメージ

ゴッドバード
Floor(0.5 * 96 * (103.68/122.29) * 1.0)+1 = 41

25 + 25 + 25 + 41 = 

Floor(0.5 * 96 * (168.83/122.29)) + 1

9 * 1.2 * 0.847820753945539 * 0.5


    uid    |  cp  | lv |         hpt          |         atk         |         def          
-----------+------+----+----------------------+---------------------+----------------------
 AZUMARILL | 1500 | 40 | 189.6720027923584080 | 94.8360013961792040 | 131.9801019430160589

   uid   |  cp  | lv |         hpt          |         atk          |         def          
---------+------+----+----------------------+----------------------+----------------------
 ALTARIA | 1486 | 28 | 127.9460411667823771 | 110.2739360332488996 | 142.0837252736091591


Dragon_breath: 4 -> 4.8
efficiency: 0.391
Floor(0.5 * 4.8 * 0.391 * (110.2739360332488996/131.9801019430160589)) + 1



--　ある特定のポケモン同士で、fastmoveのダメージがどの個体値で切り替わるか、の計算
    join calc_all_iv_pattern('MIGHTYENA',1500) B on true where a.pokemon_uid='MIGHTYENA' and a.f_uid='FIRE_FANG' and a.c_uid='POISON_FANG'
    join calc_all_iv_pattern('SKARMORY',1500) B on true where a.pokemon_uid='SKARMORY' and a.f_uid='AIR_SLASH' and a.c_uid='SKY_ATTACK'
    where a.pokemon_uid=puid('SABLEYE_NORMAL') and a.f_uid=get_move_uid('SHADOW_CLAW') and a.c_uid=get_move_uid('FOUL_PLAY')

--  HP15/AT8/DF15  | 1500 |   40 | 15 |  8 | 15 | A       | 189 |  94 | 131 |   414 | 10000
    left join cpm C on C.lv=40 where a.pokemon_uid=puid('AZUMARILL') and a.f_uid=get_move_uid('BUBBLE') and a.c_uid=get_move_uid('ICE_BEAM')
    left join cpm C on C.lv=40 where a.pokemon_uid=puid('REGISTEEL') and a.f_uid=get_move_uid('LOCK_ON') and a.c_uid=get_move_uid('FLASH_CANNON')

with O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    (B.at + 1) * C.mlp as o_atk,
    (B.df + 15) * C.mlp as o_def,
    (B.hp + 15) * C.mlp as o_hpt, 
    --b.atk as o_atk,
    --b.def as o_def,
    --b.hpt as o_hpt,
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
    --join top_iv b on b.uid=a.pokemon_uid
    left join pokemon B on B.uid=A.pokemon_uid
    left join cpm C on C.lv=40 where a.pokemon_uid=puid('AZUMARILL') and a.f_uid=get_move_uid('BUBBLE') and a.c_uid=get_move_uid('ICE_BEAM')
    --and b.cap=1500
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join O on true
    join calc_all_iv_pattern('ALTARIA',1500) B on true where a.pokemon_uid='ALTARIA' and a.f_uid='DRAGON_BREATH' and a.c_uid='DAZZLING_GLEAM'
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



    select 'SPIRITOMB' as pokemon_uid, 'SUCKER_PUNCH' as f_uid, 'SHADOW_BALL' as c_uid
    select 'SABLEYE_NORMAL' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'FOUL_PLAY' as c_uid
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'ICE_BEAM' as c_uid

-- 自分がチャージがたまるまでに、相手の通常技だけでやられてしまうポケモン
-- firstdmgがそれ
With Z as(
    select 'WIGGLYTUFF' as pokemon_uid, 'CHARM' as f_uid, 'ICE_BEAM' as c_uid
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
    and b.cap=1500
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
), B as(
    select *,
    Floor(0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,f_uid,c_uid,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg,
    Round(100 * (Floor((Ceil(c_ene::numeric / f_ene) * f_dur) / o_f_dur) * o_f_dmg) / hpt, 1) as firstdmg
    from B
)
select 
--D.jp,E.jp,F.jp,
--pokemon_uid,f_uid,c_uid,
C.*,
Round(f_dps / o_f_dps, 1) as f_ratio
from C 
--join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
where true
and firstdmg >= 100
order by firstdmg desc;
--order by f_dps / o_f_dps desc;
--order by charge, cycle_dmg desc;





-- 林さん用

\a
\pset fieldsep ','

WITH AA as(
    select A.* 
    from pokemon_pattern_combat A
    --join cup_rose C on C.uid=A.pokemon_uid
    --where C.uid is not null
    --limit 20
),A as (
    select AA.*, cp,lv,hpt,atk,def
    from AA
    join top_IV B on B.uid=AA.pokemon_uid where B.cap=1500
    -- join calc_all(AA.pokemon_uid, 1500, 15,15,15) B on true
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
        OPPONENT.f_type as o_f_type,
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
--      join A as OPPONENT on OPPONENT.pokemon_uid in ('SWAMPERT','PROBOPASS','MAROWAK_ALOLA','WHISCASH','SHIFTRY','ABOMASNOW')
    join A as OPPONENT on OPPONENT.pokemon_uid in ('SWAMPERT')
--    join A as OPPONENT on OPPONENT.pokemon_uid in ('MANTINE')
--    join A as OPPONENT on OPPONENT.pokemon_uid in ('POLIWRATH_NORMAL')
--    join A as OPPONENT on OPPONENT.pokemon_uid in ('WHISCASH')
--    join A as OPPONENT on OPPONENT.pokemon_uid in ('LANTURN')
--    join A as OPPONENT on OPPONENT.pokemon_uid in ('DEWGONG')
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
    where PLAYER.pokemon_uid in ('ALTARIA','SANDSLASH_ALOLA','RATICATE_ALOLA','INFERNAPE','WIGGLYTUFF','LUDICOLO')
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
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_ene,f_dur, c_dmg, c_ene, c_uid, 0) as kill0,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_ene, opponent_f_dur,opponent_c_dmg,opponent_c_ene,0)as death0,
        calc_killtime_combat(opponent_hpt, f_dmg, f_ene,f_dur, c_dmg, c_ene, c_uid, 1) as kill1,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_ene, opponent_f_dur,opponent_c_dmg,opponent_c_ene,1)as death1,
        calc_killtime_combat(opponent_hpt, f_dmg, f_ene,f_dur, c_dmg, c_ene, c_uid, 2) as kill2,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_ene, opponent_f_dur,opponent_c_dmg,opponent_c_ene,2)as death2
    from C
)
select
    uid, f_uid,c_uid,
    opponent_uid,opponent_f_uid, opponent_c_uid,
    kill0, death0, kill1, death1, kill2, death2
from D
order by opponent_uid,opponent_f_uid, opponent_c_uid;


