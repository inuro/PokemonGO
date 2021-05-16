('Abomasnow','Accelgor','Aipom','Ambipom','Amoonguss','Anorith','Arbok','Ariados','Armaldo','Audino','Azurill','Baltoy','Bayleef','Beautifly','Beedrill','Bellossom','Bellsprout','Bibarel','Bidoof','Blissey','Breloom','Budew','Bulbasaur','Buneary','Burmy (Plant Cloak)','Burmy (Sandy Cloak)','Burmy (Trash Cloak)','Butterfree','Cacnea','Cacturne','Camerupt','Carnivine','Cascoon','Castform (Normal)','Caterpie','Celebi','Chansey','Chatot','Cherrim (Overcast Form)','Cherrim (Sunshine Form)','Cherubi','Chikorita','Cinccino','Claydol','Combee','Cradily','Croagunk','Crobat','Crustle','Cubone','Delcatty','Diglett','Diglett (Alolan)','Dodrio','Doduo','Donphan','Drapion','Drilbur','Dugtrio','Dugtrio (Alolan)','Dunsparce','Durant','Dustox','Dwebble','Eevee','Ekans','Escavalier','Excadrill','Exeggcute','Exeggutor','Exeggutor (Alolan)','Exploud','Farfetch’d','Fearow','Ferroseed','Ferrothorn','Flygon','Foongus','Forretress','Furret','Gabite','Galvantula','Garbodor','Garchomp','Gastly','Gengar','Geodude','Gible','Girafarig','Glameow','Gligar','Gliscor','Gloom','Golbat','Golem','Golett','Golurk','Graveler','Grimer','Grimer (Alolan)','Grotle','Groudon','Grovyle','Gulpin','Happiny','Haunter','Heracross','Herdier','Hippopotas','Hippowdon','Hoothoot','Hoppip','Igglybuff','Illumise','Ivysaur','Jigglypuff','Joltik','Jumpluff','Kakuna','Kangaskhan','Karrablast','Koffing','Kricketot','Kricketune','Larvitar','Leafeon','Ledian','Ledyba','Lickilicky','Lickitung','Lileep','Lillipup','Linoone','Lombre','Lopunny','Lotad','Loudred','Ludicolo','Mamoswine','Maractus','Marowak','Masquerain','Meganium','Meowth','Metapod','Miltank','Minccino','Mothim','Muk','Muk (Alolan)','Munchlax','Nidoking','Nidoqueen','Nidoran♀','Nidoran♂','Nidorina','Nidorino','Nincada','Ninjask','Numel','Nuzleaf','Oddish','Onix','Pansage','Paras','Parasect','Patrat','Persian','Phanpy','Pidgeot','Pidgeotto','Pidgey','Pidove','Piloswine','Pineco','Pinsir','Porygon','Porygon-Z','Porygon2','Pupitar','Purugly','Qwilfish','Raticate','Raticate (Alolan)','Rattata','Rattata (Alolan)','Regigigas','Rhydon','Rhyhorn','Rhyperior','Roselia','Roserade','Sandshrew','Sandslash','Sceptile','Scizor','Scolipede','Scyther','Seedot','Sentret','Serperior','Servine','Seviper','Shelmet','Shiftry','Shroomish','Shuckle','Silcoon','Simisage','Skiploom','Skitty','Skorupi','Skuntank','Slaking','Slakoth','Smeargle','Snivy','Snorlax','Snover','Spearow','Spinarak','Spinda','Stantler','Staraptor','Staravia','Starly','Steelix','Stoutland','Stunky','Sunflora','Sunkern','Surskit','Swablu','Swalot','Swellow','Swinub','Taillow','Tangela','Tangrowth','Tauros','Teddiursa','Tentacool','Tentacruel','Torterra','Toxicroak','Tranquill','Trapinch','Treecko','Trubbish','Turtwig','Unfezant','Ursaring','Venipede','Venomoth','Venonat','Venusaur','Vespiquen','Vibrava','Victreebel','Vileplume','Virizion','Volbeat','Watchog','Weedle','Weepinbell','Weezing','Weezing (Galarian)','Whirlipede','Whismur','Wigglytuff','Wormadam (Plant Cloak)','Wormadam (Sandy Cloak)','Wormadam (Trash Cloak)','Wurmple','Yanma','Yanmega','Zangoose','Zigzagoon','Zubat')


create temporary table toxic ( en text) ;
insert into toxic (en) values ('Abomasnow'),('Accelgor'),('Aipom'),('Ambipom'),('Amoonguss'),('Anorith'),('Arbok'),('Ariados'),('Armaldo'),('Audino'),('Azurill'),('Baltoy'),('Bayleef'),('Beautifly'),('Beedrill'),('Bellossom'),('Bellsprout'),('Bibarel'),('Bidoof'),('Blissey'),('Breloom'),('Budew'),('Bulbasaur'),('Buneary'),('Burmy (Plant Cloak)'),('Burmy (Sandy Cloak)'),('Burmy (Trash Cloak)'),('Butterfree'),('Cacnea'),('Cacturne'),('Camerupt'),('Carnivine'),('Cascoon'),('Castform (Normal)'),('Caterpie'),('Celebi'),('Chansey'),('Chatot'),('Cherrim (Overcast Form)'),('Cherrim (Sunshine Form)'),('Cherubi'),('Chikorita'),('Cinccino'),('Claydol'),('Combee'),('Cradily'),('Croagunk'),('Crobat'),('Crustle'),('Cubone'),('Delcatty'),('Diglett'),('Diglett (Alolan)'),('Dodrio'),('Doduo'),('Donphan'),('Drapion'),('Drilbur'),('Dugtrio'),('Dugtrio (Alolan)'),('Dunsparce'),('Durant'),('Dustox'),('Dwebble'),('Eevee'),('Ekans'),('Escavalier'),('Excadrill'),('Exeggcute'),('Exeggutor'),('Exeggutor (Alolan)'),('Exploud'),('Farfetch’d'),('Fearow'),('Ferroseed'),('Ferrothorn'),('Flygon'),('Foongus'),('Forretress'),('Furret'),('Gabite'),('Galvantula'),('Garbodor'),('Garchomp'),('Gastly'),('Gengar'),('Geodude'),('Gible'),('Girafarig'),('Glameow'),('Gligar'),('Gliscor'),('Gloom'),('Golbat'),('Golem'),('Golett'),('Golurk'),('Graveler'),('Grimer'),('Grimer (Alolan)'),('Grotle'),('Groudon'),('Grovyle'),('Gulpin'),('Happiny'),('Haunter'),('Heracross'),('Herdier'),('Hippopotas'),('Hippowdon'),('Hoothoot'),('Hoppip'),('Igglybuff'),('Illumise'),('Ivysaur'),('Jigglypuff'),('Joltik'),('Jumpluff'),('Kakuna'),('Kangaskhan'),('Karrablast'),('Koffing'),('Kricketot'),('Kricketune'),('Larvitar'),('Leafeon'),('Ledian'),('Ledyba'),('Lickilicky'),('Lickitung'),('Lileep'),('Lillipup'),('Linoone'),('Lombre'),('Lopunny'),('Lotad'),('Loudred'),('Ludicolo'),('Mamoswine'),('Maractus'),('Marowak'),('Masquerain'),('Meganium'),('Meowth'),('Metapod'),('Miltank'),('Minccino'),('Mothim'),('Muk'),('Muk (Alolan)'),('Munchlax'),('Nidoking'),('Nidoqueen'),('Nidoran♀'),('Nidoran♂'),('Nidorina'),('Nidorino'),('Nincada'),('Ninjask'),('Numel'),('Nuzleaf'),('Oddish'),('Onix'),('Pansage'),('Paras'),('Parasect'),('Patrat'),('Persian'),('Phanpy'),('Pidgeot'),('Pidgeotto'),('Pidgey'),('Pidove'),('Piloswine'),('Pineco'),('Pinsir'),('Porygon'),('Porygon-Z'),('Porygon2'),('Pupitar'),('Purugly'),('Qwilfish'),('Raticate'),('Raticate (Alolan)'),('Rattata'),('Rattata (Alolan)'),('Regigigas'),('Rhydon'),('Rhyhorn'),('Rhyperior'),('Roselia'),('Roserade'),('Sandshrew'),('Sandslash'),('Sceptile'),('Scizor'),('Scolipede'),('Scyther'),('Seedot'),('Sentret'),('Serperior'),('Servine'),('Seviper'),('Shelmet'),('Shiftry'),('Shroomish'),('Shuckle'),('Silcoon'),('Simisage'),('Skiploom'),('Skitty'),('Skorupi'),('Skuntank'),('Slaking'),('Slakoth'),('Smeargle'),('Snivy'),('Snorlax'),('Snover'),('Spearow'),('Spinarak'),('Spinda'),('Stantler'),('Staraptor'),('Staravia'),('Starly'),('Steelix'),('Stoutland'),('Stunky'),('Sunflora'),('Sunkern'),('Surskit'),('Swablu'),('Swalot'),('Swellow'),('Swinub'),('Taillow'),('Tangela'),('Tangrowth'),('Tauros'),('Teddiursa'),('Tentacool'),('Tentacruel'),('Torterra'),('Toxicroak'),('Tranquill'),('Trapinch'),('Treecko'),('Trubbish'),('Turtwig'),('Unfezant'),('Ursaring'),('Venipede'),('Venomoth'),('Venonat'),('Venusaur'),('Vespiquen'),('Vibrava'),('Victreebel'),('Vileplume'),('Virizion'),('Volbeat'),('Watchog'),('Weedle'),('Weepinbell'),('Weezing'),('Weezing (Galarian)'),('Whirlipede'),('Whismur'),('Wigglytuff'),('Wormadam (Plant Cloak)'),('Wormadam (Sandy Cloak)'),('Wormadam (Trash Cloak)'),('Wurmple'),('Yanma'),('Yanmega'),('Zangoose'),('Zigzagoon'),('Zubat');

pokemongo=# select * from toxic A left join localize_pokemon B using(en) where jp is null;
           en            | index | uid | jp 
-------------------------+-------+-----+----
 Castform (Normal)       |       |     | 
 Cherrim (Overcast Form) |       |     | 
 Cherrim (Sunshine Form) |       |     | 
 Diglett (Alolan)        |       |     | 
 Dugtrio (Alolan)        |       |     | 
 Exeggutor (Alolan)      |       |     | 
 Farfetch’d              |       |     | 
 Grimer (Alolan)         |       |     | 
 Muk (Alolan)            |       |     | 
 Raticate (Alolan)       |       |     | 
 Rattata (Alolan)        |       |     | 
 Weezing (Galarian)      |       |     | 
(12 rows)


('Castform')
('Cherrim (Overcast)')
('Cherrim (Sunny)')
('Alolan Diglett')
('Alolan Dugtrio')
('Alolan Exeggutor')
('Farfetch''d')
('Alolan Grimer')
('Alolan Muk')
('Alolan Raticate')
('Alolan Rattata')
('Galarian Weezing')


-- Toxic cup eligible pokemons
DROP TABLE if exists cup_toxic;
CREATE TABLE cup_toxic(
    uid text
);
INSERT INTO cup_toxic(uid)
select uid from localize_pokemon where en in
('Abomasnow','Accelgor','Aipom','Ambipom','Amoonguss','Anorith','Arbok','Ariados','Armaldo','Audino','Azurill','Baltoy','Bayleef','Beautifly','Beedrill','Bellossom','Bellsprout','Bibarel','Bidoof','Blissey','Breloom','Budew','Bulbasaur','Buneary','Burmy (Plant Cloak)','Burmy (Sandy Cloak)','Burmy (Trash Cloak)','Butterfree','Cacnea','Cacturne','Camerupt','Carnivine','Cascoon','Castform','Caterpie','Celebi','Chansey','Chatot','Cherrim (Overcast)','Cherrim (Sunny)','Cherubi','Chikorita','Cinccino','Claydol','Combee','Cradily','Croagunk','Crobat','Crustle','Cubone','Delcatty','Diglett','Alolan Diglett','Dodrio','Doduo','Donphan','Drapion','Drilbur','Dugtrio','Alolan Dugtrio','Dunsparce','Durant','Dustox','Dwebble','Eevee','Ekans','Escavalier','Excadrill','Exeggcute','Exeggutor','Alolan Exeggutor','Exploud','Farfetch''d','Fearow','Ferroseed','Ferrothorn','Flygon','Foongus','Forretress','Furret','Gabite','Galvantula','Garbodor','Garchomp','Gastly','Gengar','Geodude','Gible','Girafarig','Glameow','Gligar','Gliscor','Gloom','Golbat','Golem','Golett','Golurk','Graveler','Grimer','Alolan Grimer','Grotle','Groudon','Grovyle','Gulpin','Happiny','Haunter','Heracross','Herdier','Hippopotas','Hippowdon','Hoothoot','Hoppip','Igglybuff','Illumise','Ivysaur','Jigglypuff','Joltik','Jumpluff','Kakuna','Kangaskhan','Karrablast','Koffing','Kricketot','Kricketune','Larvitar','Leafeon','Ledian','Ledyba','Lickilicky','Lickitung','Lileep','Lillipup','Linoone','Lombre','Lopunny','Lotad','Loudred','Ludicolo','Mamoswine','Maractus','Marowak','Masquerain','Meganium','Meowth','Metapod','Miltank','Minccino','Mothim','Muk','Alolan Muk','Munchlax','Nidoking','Nidoqueen','Nidoran♀','Nidoran♂','Nidorina','Nidorino','Nincada','Ninjask','Numel','Nuzleaf','Oddish','Onix','Pansage','Paras','Parasect','Patrat','Persian','Phanpy','Pidgeot','Pidgeotto','Pidgey','Pidove','Piloswine','Pineco','Pinsir','Porygon','Porygon-Z','Porygon2','Pupitar','Purugly','Qwilfish','Raticate','Alolan Raticate','Rattata','Alolan Rattata','Regigigas','Rhydon','Rhyhorn','Rhyperior','Roselia','Roserade','Sandshrew','Sandslash','Sceptile','Scizor','Scolipede','Scyther','Seedot','Sentret','Serperior','Servine','Seviper','Shelmet','Shiftry','Shroomish','Shuckle','Silcoon','Simisage','Skiploom','Skitty','Skorupi','Skuntank','Slaking','Slakoth','Smeargle','Snivy','Snorlax','Snover','Spearow','Spinarak','Spinda','Stantler','Staraptor','Staravia','Starly','Steelix','Stoutland','Stunky','Sunflora','Sunkern','Surskit','Swablu','Swalot','Swellow','Swinub','Taillow','Tangela','Tangrowth','Tauros','Teddiursa','Tentacool','Tentacruel','Torterra','Toxicroak','Tranquill','Trapinch','Treecko','Trubbish','Turtwig','Unfezant','Ursaring','Venipede','Venomoth','Venonat','Venusaur','Vespiquen','Vibrava','Victreebel','Vileplume','Virizion','Volbeat','Watchog','Weedle','Weepinbell','Weezing','Galarian Weezing','Whirlipede','Whismur','Wigglytuff','Wormadam (Plant Cloak)','Wormadam (Sandy Cloak)','Wormadam (Trash Cloak)','Wurmple','Yanma','Yanmega','Zangoose','Zigzagoon','Zubat');




-- win_lose table building
-- tables required: cup_rose , top_IV
-- latest version
select now();
BEGIN;
drop table if exists win_lose_toxic;
create table win_lose_toxic as (
WITH 
-- eligible Pokemon uid/types
AAA as(
    select 
        B.uid,b.hpt,b.atk,b.def,
        A.type_1,A.type_2 
    from top_IV B
    join pokemon A on A.uid=B.uid
    where
    B.cap=1500 and B.cp>1200
    and B.uid in (select uid from cup_toxic)
    --and B.uid in ('TOXICROAK','PARASECT','MUK_ALOLA')
),
-- eligible Pokemon all patterns
AA as(
    select
        B.pokemon_uid as uid, 
        --B.type_1, B.type_2, 
        B.f_uid, B.f_type, B.f_dur, B.f_ene, 
        --B.f_stab_pow,
        (0.5 * 1.3 * B.f_stab_pow * AAA.atk) as f_pow,
        B.c_uid, B.c_type, B.c_ene, 
        --B.c_stab_pow,
        (0.5 * 1.3 * B.c_stab_pow * AAA.atk) as c_pow,
        AAA.hpt,
        --AAA.atk,
        AAA.def
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




-- TOP 100
-- 3/3/2020 support Shadow Bonus
select now();
BEGIN;
drop table if exists win_lose_toxic_100;
create table win_lose_toxic_100 as (
WITH 
-- eligible Pokemon uid/types
AAA as(
    select 
        B.uid,b.hpt,b.atk,b.def,
        A.type_1,A.type_2 
    from top_IV B
    join pokemon A on A.uid=B.uid
    where
    B.cap=1500 and B.cp>1200
    and B.uid in ('WORMADAM_TRASH','FORRETRESS','MUNCHLAX','GLIGAR','PILOSWINE','SCIZOR_NORMAL','DRAPION','SKUNTANK','MUK_ALOLA','LICKILICKY','ESCAVALIER','STEELIX_NORMAL','SNORLAX_NORMAL','GLISCOR','RATICATE_ALOLA','CRUSTLE','FERROTHORN','PIDGEOT','HIPPOWDON_NORMAL','VESPIQUEN','SWELLOW','HERACROSS','GRIMER_ALOLA','TOXICROAK','DUNSPARCE','TRANQUILL','SWALOT','FLYGON_NORMAL','PERSIAN_NORMAL','DURANT','GOLBAT_NORMAL','MAMOSWINE','STARAPTOR','VENUSAUR_NORMAL','STOUTLAND','CROBAT_NORMAL','CLAYDOL','QWILFISH','VIRIZION','MILTANK','UNFEZANT','CASTFORM_NORMAL','FEAROW','SCYTHER_NORMAL','IVYSAUR_NORMAL','CHATOT','GRAVELER_NORMAL','BEEDRILL_NORMAL','WIGGLYTUFF','BIBAREL','GLOOM_NORMAL','WORMADAM_SANDY','PORYGON2_NORMAL','MUK_NORMAL','LEDIAN','CAMERUPT','KRICKETUNE','RHYPERIOR_NORMAL','MEGANIUM','PURUGLY','LICKITUNG','EXCADRILL','YANMA','NIDOQUEEN','VICTREEBEL_NORMAL','YANMEGA','GABITE_NORMAL','BUTTERFREE','AMOONGUSS','CRADILY','ARBOK_NORMAL','VENOMOTH_NORMAL','CELEBI','SCOLIPEDE','GOLEM_NORMAL','VILEPLUME_NORMAL','DELCATTY','BAYLEEF','GIRAFARIG','ARMALDO','FARFETCHD','SERPERIOR','LINOONE_GALARIAN','URSARING','BELLOSSOM_NORMAL','DONPHAN','MASQUERAIN','SHIFTRY_NORMAL','GROTLE_NORMAL','GARBODOR','GARCHOMP_NORMAL','TENTACRUEL','NINJASK','SCEPTILE','DUSTOX','WORMADAM_PLANT','WEEPINBELL_NORMAL','EXPLOUD','WATCHOG','SEVIPER')
    --and B.uid in ('TOXICROAK','PARASECT','MUK_ALOLA')
),
-- eligible Pokemon all patterns
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
        AAA.def / (case when B.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end)
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



    select 'BIBAREL'::TEXT as pokemon_uid, 'WATER_GUN'::TEXT as f_uid, 'SURF'::TEXT as c_uid
    select 'BIBAREL'::TEXT as pokemon_uid, 'WATER_GUN'::TEXT as f_uid, 'HYPER_FANG'::TEXT as c_uid
    select 'LUDICOLO' as pokemon_uid, 'BUBBLE' as f_uid, 'ICE_BEAM' as c_uid
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'BUG_BITE'::TEXT as f_uid, 'IRON_HEAD'::TEXT as c_uid
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'CONFUSION'::TEXT as f_uid, 'IRON_HEAD'::TEXT as c_uid
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'BUG_BITE'::TEXT as f_uid, 'BUG_BUZZ'::TEXT as c_uid
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'CONFUSION'::TEXT as f_uid, 'BUG_BUZZ'::TEXT as c_uid
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'BUG_BITE'::TEXT as f_uid, 'PSYBEAM'::TEXT as c_uid
    select 'CAMERUPT'::TEXT as pokemon_uid, 'EMBER'::TEXT as f_uid, 'OVERHEAT'::TEXT as c_uid
    select 'CAMERUPT'::TEXT as pokemon_uid, 'EMBER'::TEXT as f_uid, 'EARTH_POWER'::TEXT as c_uid
    select 'MUNCHLAX'::TEXT as pokemon_uid, 'LICK'::TEXT as f_uid, 'BODY_SLAM'::TEXT as c_uid
    select 'MUNCHLAX'::TEXT as pokemon_uid, 'LICK'::TEXT as f_uid, 'GUNK_SHOT'::TEXT as c_uid
    select 'MUNCHLAX'::TEXT as pokemon_uid, 'LICK'::TEXT as f_uid, 'BULLDOZE'::TEXT as c_uid
    select 'GLIGAR'::TEXT as pokemon_uid, 'WING_ATTACK'::TEXT as f_uid, 'NIGHT_SLASH'::TEXT as c_uid
    select 'PILOSWINE'::TEXT as pokemon_uid, 'POWDER_SNOW'::TEXT as f_uid, 'AVALANCHE'::TEXT as c_uid
    select 'MEGANIUM'::TEXT as pokemon_uid, 'VINE_WHIP'::TEXT as f_uid, 'FRENZY_PLANT'::TEXT as c_uid
    select 'STEELIX_NORMAL'::TEXT as pokemon_uid, 'DRAGON_TAIL'::TEXT as f_uid, 'HEAVY_SLAM'::TEXT as c_uid

    select 'BRELOOM'::TEXT as pokemon_uid, 'COUNTER'::TEXT as f_uid, 'SEED_BOMB'::TEXT as c_uid
    select 'VENUSAUR_NORMAL'::TEXT as pokemon_uid, 'VINE_WHIP'::TEXT as f_uid, 'FRENZY_PLANT'::TEXT as c_uid
    select 'FORRETRESS'::TEXT as pokemon_uid, 'BUG_BITE'::TEXT as f_uid, 'MIRROR_SHOT'::TEXT as c_uid
    select 'QWILFISH'::TEXT as pokemon_uid, 'WATER_GUN'::TEXT as f_uid, 'AQUA_TAIL'::TEXT as c_uid
    select 'CELEBI'::TEXT as pokemon_uid, 'CONFUSION'::TEXT as f_uid, 'SEED_BOMB'::TEXT as c_uid
    select 'CELEBI'::TEXT as pokemon_uid, 'CONFUSION'::TEXT as f_uid, 'PSYCHIC'::TEXT as c_uid
    select 'DRAPION'::TEXT as pokemon_uid, 'ICE_FANG'::TEXT as f_uid, 'AQUA_TAIL'::TEXT as c_uid
    select 'FORRETRESS'::TEXT as pokemon_uid, 'BUG_BITE'::TEXT as f_uid, 'MIRROR_SHOT'::TEXT as c_uid
    select 'SNORLAX_NORMAL'::TEXT as pokemon_uid, 'LICK'::TEXT as f_uid, 'BODY_SLAM'::TEXT as c_uid
    select 'SCIZOR_NORMAL'::TEXT as pokemon_uid, 'BULLET_PUNCH'::TEXT as f_uid, 'NIGHT_SLASH'::TEXT as c_uid
    select 'SCIZOR_NORMAL'::TEXT as pokemon_uid, 'BULLET_PUNCH'::TEXT as f_uid, 'IRON_HEAD'::TEXT as c_uid
    select 'CAMERUPT'::TEXT as pokemon_uid, 'EMBER'::TEXT as f_uid, 'OVERHEAT'::TEXT as c_uid
    select 'HIPPOWDON_NORMAL'::TEXT as pokemon_uid, 'FIRE_FANG'::TEXT as f_uid, 'BODY_SLAM'::TEXT as c_uid
    select 'GOLBAT_NORMAL'::TEXT as pokemon_uid, 'WING_ATTACK'::TEXT as f_uid, 'OMINOUS_WIND'::TEXT as c_uid
    select 'PILOSWINE'::TEXT as pokemon_uid, 'POWDER_SNOW'::TEXT as f_uid, 'AVALANCHE'::TEXT as c_uid
    select 'SHIFTRY_NORMAL'::TEXT as pokemon_uid, 'SNARL'::TEXT as f_uid, 'LEAF_BLADE'::TEXT as c_uid
    select 'PIDGEOT'::TEXT as pokemon_uid, 'WING_ATTACK'::TEXT as f_uid, 'AERIAL_ACE'::TEXT as c_uid
    select 'ESCAVALIER'::TEXT as pokemon_uid, 'COUNTER'::TEXT as f_uid, 'AERIAL_ACE'::TEXT as c_uid
    select 'RHYPERIOR_NORMAL'::TEXT as pokemon_uid, 'SMACK_DOWN'::TEXT as f_uid, 'ROCK_WRECKER'::TEXT as c_uid
    select 'MUK_ALOLA'::TEXT as pokemon_uid, 'SNARL'::TEXT as f_uid, 'DARK_PULSE'::TEXT as c_uid
    select 'MUK_ALOLA'::TEXT as pokemon_uid, 'SNARL'::TEXT as f_uid, 'SLUDGE_WAVE'::TEXT as c_uid


    select 'TENTACRUEL' as pokemon_uid, 'POISON_JAB' as f_uid, 'ACID_SPRAY' as c_uid
    select 'TENTACRUEL' as pokemon_uid, 'POISON_JAB' as f_uid, 'HYDRO_PUMP' as c_uid
    select 'SCIZOR_NORMAL' as pokemon_uid, 'BULLET_PUNCH' as f_uid, 'IRON_HEAD' as c_uid
    select 'SCIZOR_NORMAL' as pokemon_uid, 'BULLET_PUNCH' as f_uid, 'NIGHT_SLASH' as c_uid
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'NIGHT_SLASH' as c_uid
    select 'GLIGAR' as pokemon_uid, 'WING_ATTACK' as f_uid, 'AERIAL_ACE' as c_uid
    select 'RHYPERIOR_NORMAL' as pokemon_uid, 'SMACK_DOWN' as f_uid, 'ROCK_WRECKER' as c_uid
    select 'RHYPERIOR_NORMAL' as pokemon_uid, 'SMACK_DOWN' as f_uid, 'SURF' as c_uid
    select 'HAUNTER' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'SHADOW_PUNCH' as c_uid
    select 'HAUNTER' as pokemon_uid, 'SHADOW_CLAW' as f_uid, 'SHADOW_BALL' as c_uid
    select 'BIBAREL' as pokemon_uid, 'WATER_GUN' as f_uid, 'SURF' as c_uid
    select 'BIBAREL' as pokemon_uid, 'WATER_GUN' as f_uid, 'HYPER_FANG' as c_uid
    select 'STEELIX_NORMAL'::TEXT as pokemon_uid, 'DRAGON_TAIL'::TEXT as f_uid, 'CRUNCH'::TEXT as c_uid
    select 'STEELIX_NORMAL'::TEXT as pokemon_uid, 'DRAGON_TAIL'::TEXT as f_uid, 'EARTHQUAKE'::TEXT as c_uid
    select 'CAMERUPT'::TEXT as pokemon_uid, 'EMBER'::TEXT as f_uid, 'EARTH_POWER'::TEXT as c_uid
    select 'CAMERUPT'::TEXT as pokemon_uid, 'EMBER'::TEXT as f_uid, 'OVERHEAT'::TEXT as c_uid
    select 'TOXICROAK'::TEXT as pokemon_uid, 'COUNTER'::TEXT as f_uid, 'MUD_BOMB'::TEXT as c_uid
    select 'TOXICROAK'::TEXT as pokemon_uid, 'COUNTER'::TEXT as f_uid, 'DYNAMIC_PUNCH'::TEXT as c_uid
    select 'GALVANTULA'::TEXT as pokemon_uid, 'VOLT_SWITCH'::TEXT as f_uid, 'DISCHARGE'::TEXT as c_uid
    select 'VENUSAUR_NORMAL'::TEXT as pokemon_uid, 'VINE_WHIP'::TEXT as f_uid, 'FRENZY_PLANT'::TEXT as c_uid
    select 'VENUSAUR_NORMAL'::TEXT as pokemon_uid, 'VINE_WHIP'::TEXT as f_uid, 'SLUDGE_BOMB'::TEXT as c_uid
    select 'DRAPION'::TEXT as pokemon_uid, 'ICE_FANG'::TEXT as f_uid, 'AQUA_TAIL'::TEXT as c_uid
    select 'DRAPION'::TEXT as pokemon_uid, 'ICE_FANG'::TEXT as f_uid, 'CRUNCH'::TEXT as c_uid
    select 'DRAPION'::TEXT as pokemon_uid, 'ICE_FANG'::TEXT as f_uid, 'SLUDGE_BOMB'::TEXT as c_uid
    select 'DRAPION'::TEXT as pokemon_uid, 'BITE'::TEXT as f_uid, 'FELL_STINGER'::TEXT as c_uid
    select 'DRAPION'::TEXT as pokemon_uid, 'BITE'::TEXT as f_uid, 'SLUDGE_BOMB'::TEXT as c_uid
    select 'DRAPION'::TEXT as pokemon_uid, 'BITE'::TEXT as f_uid, 'CRUNCH'::TEXT as c_uid
    select 'PILOSWINE'::TEXT as pokemon_uid, 'POWDER_SNOW'::TEXT as f_uid, 'AVALANCHE'::TEXT as c_uid
    select 'PILOSWINE'::TEXT as pokemon_uid, 'POWDER_SNOW'::TEXT as f_uid, 'BULLDOZE'::TEXT as c_uid
    select 'FLYGON_NORMAL'::TEXT as pokemon_uid, 'MUD_SHOT'::TEXT as f_uid, 'DRAGON_CLAW'::TEXT as c_uid
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'CONFUSION'::TEXT as f_uid, 'IRON_HEAD'::TEXT as c_uid
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'CONFUSION'::TEXT as f_uid, 'PSYBEAM'::TEXT as c_uid
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'CONFUSION'::TEXT as f_uid, 'BUG_BUZZ'::TEXT as c_uid
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'BUG_BITE'::TEXT as f_uid, 'BUG_BUZZ'::TEXT as c_uid
    select 'WIGGLYTUFF'::TEXT as pokemon_uid, 'CHARM'::TEXT as f_uid, 'PLAY_ROUGH'::TEXT as c_uid
    select 'WIGGLYTUFF'::TEXT as pokemon_uid, 'CHARM'::TEXT as f_uid, 'ICE_BEAM'::TEXT as c_uid
    select 'ESCAVALIER'::TEXT as pokemon_uid, 'COUNTER'::TEXT as f_uid, 'AERIAL_ACE'::TEXT as c_uid
    select 'ESCAVALIER'::TEXT as pokemon_uid, 'COUNTER'::TEXT as f_uid, 'MEGAHORN'::TEXT as c_uid
    select 'ESCAVALIER'::TEXT as pokemon_uid, 'COUNTER'::TEXT as f_uid, 'DRILL_RUN'::TEXT as c_uid
    select 'GOLBAT_NORMAL'::TEXT as pokemon_uid, 'WING_ATTACK'::TEXT as f_uid, 'POISON_FANG'::TEXT as c_uid
    select 'GOLBAT_NORMAL'::TEXT as pokemon_uid, 'WING_ATTACK'::TEXT as f_uid, 'SHADOW_BALL'::TEXT as c_uid
    select 'GLISCOR'::TEXT as pokemon_uid, 'WING_ATTACK'::TEXT as f_uid, 'NIGHT_SLASH'::TEXT as c_uid
    select 'GLISCOR'::TEXT as pokemon_uid, 'WING_ATTACK'::TEXT as f_uid, 'EARTHQUAKE'::TEXT as c_uid

and pokemon_uid in ('WORMADAM_TRASH','MUNCHLAX','GLIGAR','WIGGLYTUFF','TOXICROAK','LUDICOLO')


--相手へのカウンター
With Z as(
    select 'TOXICROAK'::TEXT as pokemon_uid, 'COUNTER'::TEXT as f_uid, 'MUD_BOMB'::TEXT as c_uid
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
    and a.c_uid != 'FRUSTRATION'::TEXT
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
    and a.c_uid != 'FRUSTRATION'::TEXT
    and B.cp>1400
    and a.pokemon_uid in (select uid from win_lose_toxic)
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
), D as(
    select 
    Round(f_dps / o_f_dps, 2) as f_ratio,
    Round((cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge),2) as dpsratio,
    D.jp,
    C.pokemon_uid,
    --type_1,type_2,
    E.jp,
    f_uid,
    --f_type,
    F.jp,
    c_uid,
    --c_type,
    f_dps,charge as chg,chg_dmg,c_dmg, cycle_dmg,
    kill0,death0,kill1,death1,kill2,death2,
    o_f_dps,o_charge as o_chg,o_chg_dmg,o_c_dmg, o_cycle_dmg,
    --firstdmg,
    Round(cycle_dmg::numeric/charge, 1) as tdps,
    Round(o_cycle_dmg::numeric/o_charge, 1) as o_tdps,
    rank() over (partition by C.pokemon_uid order by (cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge) desc) as rnk
    from C 
    join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
    where true
    --    and C.pokemon_uid in ('ELECTRODE','RHYPERIOR_NORMAL','CASTFORM_SUNNY','DRAPION','WIGGLYTUFF','GLIGAR')
    --and C.pokemon_uid='DRAPION'
    --and kill0<death0
    --and kill2<death2
    --and f_dps / o_f_dps>1.0
    order by 
    --f_dps / o_f_dps desc
    (cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge) desc
    --kill0/death0 * kill2/death2, charge
),
E as(
    select 
        rank()over(partition by pokemon_uid order by (kill0/death0)*(kill2/death2),chg, f_ratio,dpsratio) rnk_e,
        rank()over(order by (kill0/death0)*(kill2/death2),chg, f_ratio, dpsratio desc) rnk_t,
        *
    from D
    where true 
    and f_uid not in ('TACKLE')
)
select * from E where true
and pokemon_uid in ('WORMADAM_TRASH','MUNCHLAX','GLIGAR','WIGGLYTUFF','TOXICROAK','LUDICOLO')
order by rnk_t
;



--技の確認
select
    pokemon_uid,type_1,type_2,
    B.jp,f_uid,f_type,f_stab_pow as fpow, f_dur,f_ene,
    Round((c_ene::numeric/f_ene)*f_dur,1) as chg,
    C.jp,c_uid,c_type,c_stab_pow as cpow, c_ene
from pokemon_pattern_combat A
join localize_fastmove B on B.uid=f_uid
join localize_chargemove C on C.uid=c_uid
where true
and A.pokemon_uid=puid('LUDICOLO')
order by f_uid, (c_ene::numeric/f_ene)*f_dur;






With a as(
select rank()over(order by win0*win2 desc)rnk, * from win_lose_toxic
)select * from a where uid in ('MUNCHLAX') order by rnk;






with a as(select *, rank()over(order by win0*win2 desc)as rnk from win_lose_toxic_100 order by win0*win2 desc)
select * from a 
where uid in ('SCIZOR_NORMAL');
--where f_type in ('PSYCHIC');

with a as(select *, 
    rank()over(order by win0*win2 desc)as rnk, 
    rank()over(partition by type_1,type_2 order by win0*win2 desc) as rnk_t,
    rank()over(partition by uid order by win0*win2 desc) as rnk_s
from win_lose_toxic join pokemon using(uid) order by win0*win2 desc)
select uid,type_1,type_2,f_uid,f_type,c_uid,c_type,win0,lose0,win2,lose2,counter0,counter2,victim0,victim2,rnk
from a 
where rnk_s=1;



--相手へのカウンター

With C as(
select * from(
With Z as(
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'CONFUSION'::TEXT as f_uid, 'IRON_HEAD'::TEXT as c_uid
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
    and a.c_uid != 'FRUSTRATION'::TEXT
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
    and a.c_uid != 'FRUSTRATION'::TEXT
    and B.cp>1400
    and a.pokemon_uid in (select uid from win_lose_toxic)
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
), D as(
    select 
    Round(f_dps / o_f_dps, 2) as f_ratio,
    Round((cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge),2) as dpsratio,
    D.jp,
    C.pokemon_uid,
    --type_1,type_2,
    E.jp,
    f_uid,
    --f_type,
    F.jp,
    c_uid,
    --c_type,
    f_dps,charge as chg,chg_dmg,c_dmg, cycle_dmg,
    kill0,death0,kill1,death1,kill2,death2,
    o_f_dps,o_charge as o_chg,o_chg_dmg,o_c_dmg, o_cycle_dmg,
    --firstdmg,
    Round(cycle_dmg::numeric/charge, 1) as tdps,
    Round(o_cycle_dmg::numeric/o_charge, 1) as o_tdps,
    rank() over (partition by C.pokemon_uid order by (cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge) desc) as rnk
    from C 
    join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
    where true
    --    and C.pokemon_uid in ('ELECTRODE','RHYPERIOR_NORMAL','CASTFORM_SUNNY','DRAPION','WIGGLYTUFF','GLIGAR')
    --and C.pokemon_uid='DRAPION'
    --and kill0<death0
    --and kill2<death2
    --and f_dps / o_f_dps>1.0
    order by 
    --f_dps / o_f_dps desc
    (cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge) desc
    --kill0/death0 * kill2/death2, charge
)
select * from D 
) A1
union all 
select * from(
With Z as(
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'BUG_BITE'::TEXT as f_uid, 'IRON_HEAD'::TEXT as c_uid
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
    and a.c_uid != 'FRUSTRATION'::TEXT
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
    and a.c_uid != 'FRUSTRATION'::TEXT
    and B.cp>1400
    and a.pokemon_uid in (select uid from win_lose_toxic)
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
), D as(
    select 
    Round(f_dps / o_f_dps, 2) as f_ratio,
    Round((cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge),2) as dpsratio,
    D.jp,
    C.pokemon_uid,
    --type_1,type_2,
    E.jp,
    f_uid,
    --f_type,
    F.jp,
    c_uid,
    --c_type,
    f_dps,charge as chg,chg_dmg,c_dmg, cycle_dmg,
    kill0,death0,kill1,death1,kill2,death2,
    o_f_dps,o_charge as o_chg,o_chg_dmg,o_c_dmg, o_cycle_dmg,
    --firstdmg,
    Round(cycle_dmg::numeric/charge, 1) as tdps,
    Round(o_cycle_dmg::numeric/o_charge, 1) as o_tdps,
    rank() over (partition by C.pokemon_uid order by (cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge) desc) as rnk
    from C 
    join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
    where true
    --    and C.pokemon_uid in ('ELECTRODE','RHYPERIOR_NORMAL','CASTFORM_SUNNY','DRAPION','WIGGLYTUFF','GLIGAR')
    --and C.pokemon_uid='DRAPION'
    --and kill0<death0
    --and kill2<death2
    --and f_dps / o_f_dps>1.0
    order by 
    --f_dps / o_f_dps desc
    (cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge) desc
    --kill0/death0 * kill2/death2, charge
)
select * from D 
) A2

union all 
select * from(
With Z as(
    select 'WORMADAM_TRASH'::TEXT as pokemon_uid, 'BUG_BITE'::TEXT as f_uid, 'BUG_BUZZ'::TEXT as c_uid
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
    and a.c_uid != 'FRUSTRATION'::TEXT
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
    and a.c_uid != 'FRUSTRATION'::TEXT
    and B.cp>1400
    and a.pokemon_uid in (select uid from win_lose_toxic)
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
), D as(
    select 
    Round(f_dps / o_f_dps, 2) as f_ratio,
    Round((cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge),2) as dpsratio,
    D.jp,
    C.pokemon_uid,
    --type_1,type_2,
    E.jp,
    f_uid,
    --f_type,
    F.jp,
    c_uid,
    --c_type,
    f_dps,charge as chg,chg_dmg,c_dmg, cycle_dmg,
    kill0,death0,kill1,death1,kill2,death2,
    o_f_dps,o_charge as o_chg,o_chg_dmg,o_c_dmg, o_cycle_dmg,
    --firstdmg,
    Round(cycle_dmg::numeric/charge, 1) as tdps,
    Round(o_cycle_dmg::numeric/o_charge, 1) as o_tdps,
    rank() over (partition by C.pokemon_uid order by (cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge) desc) as rnk
    from C 
    join localize_pokemon D on D.uid=C.pokemon_uid join localize_fastmove E on E.uid=C.f_uid join localize_chargemove F on F.uid=C.c_uid
    where true
    --    and C.pokemon_uid in ('ELECTRODE','RHYPERIOR_NORMAL','CASTFORM_SUNNY','DRAPION','WIGGLYTUFF','GLIGAR')
    --and C.pokemon_uid='DRAPION'
    --and kill0<death0
    --and kill2<death2
    --and f_dps / o_f_dps>1.0
    order by 
    --f_dps / o_f_dps desc
    (cycle_dmg::numeric/charge)/(o_cycle_dmg::numeric/o_charge) desc
    --kill0/death0 * kill2/death2, charge
)
select * from D 
) A3

),
D as(
    select *, rank() over(partition by pokemon_uid, f_uid, c_uid order by f_ratio*dpsratio) as rnk_t from C
)
select * from D where rnk_t=1 order by f_ratio desc, dpsratio desc, chg;








WITH 
-- eligible Pokemon uid/types
AAA as(
    select 
        B.uid,b.hpt,b.atk,b.def,
        A.type_1,A.type_2 
    from top_IV B
    join pokemon A on A.uid=B.uid
    where
    B.cap=1500 and B.cp>1200
    and B.uid in ('WORMADAM_TRASH','FORRETRESS','MUNCHLAX','GLIGAR','PILOSWINE','SCIZOR_NORMAL','DRAPION','SKUNTANK','MUK_ALOLA','LICKILICKY','ESCAVALIER','STEELIX_NORMAL','SNORLAX_NORMAL','SNORLAX_SHADOW','GLISCOR','RATICATE_ALOLA','CRUSTLE','FERROTHORN','PIDGEOT','HIPPOWDON_NORMAL','VESPIQUEN','SWELLOW','HERACROSS','GRIMER_ALOLA','TOXICROAK','DUNSPARCE','TRANQUILL','SWALOT','FLYGON_NORMAL','PERSIAN_NORMAL','DURANT','GOLBAT_NORMAL','GOLBAT_SHADOW','MAMOSWINE','STARAPTOR','VENUSAUR_NORMAL','STOUTLAND','CROBAT_NORMAL','CLAYDOL','QWILFISH','VIRIZION','MILTANK','UNFEZANT','CASTFORM_NORMAL','FEAROW','SCYTHER_NORMAL','IVYSAUR_NORMAL','CHATOT','GRAVELER_NORMAL','BEEDRILL_NORMAL','WIGGLYTUFF','BIBAREL','GLOOM_NORMAL','WORMADAM_SANDY','PORYGON2_NORMAL','MUK_NORMAL','LEDIAN','CAMERUPT','KRICKETUNE','RHYPERIOR_NORMAL','MEGANIUM','PURUGLY','LICKITUNG','EXCADRILL','YANMA','NIDOQUEEN','VICTREEBEL_NORMAL','YANMEGA','GABITE_NORMAL','BUTTERFREE','AMOONGUSS','CRADILY','ARBOK_NORMAL','VENOMOTH_NORMAL','CELEBI','SCOLIPEDE','GOLEM_NORMAL','VILEPLUME_NORMAL','DELCATTY','BAYLEEF','GIRAFARIG','ARMALDO','FARFETCHD','SERPERIOR','LINOONE_GALARIAN','URSARING','BELLOSSOM_NORMAL','DONPHAN','MASQUERAIN','SHIFTRY_NORMAL','GROTLE_NORMAL','GARBODOR','GARCHOMP_NORMAL','TENTACRUEL','NINJASK','SCEPTILE','DUSTOX','WORMADAM_PLANT','WEEPINBELL_NORMAL','EXPLOUD','WATCHOG','SEVIPER')
    --and B.uid in ('TOXICROAK','PARASECT','MUK_ALOLA')
),
-- eligible Pokemon all patterns
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
    where OPPONENT.uid~'SNORLAX'
    and PLAYER.uid='GOLBAT_NORMAL'
)
select * from C;




WITH 
-- eligible Pokemon uid/types
AAA as(
    select 
        B.uid,b.hpt,b.atk,b.def,
        A.type_1,A.type_2 
    from top_IV B
    join pokemon A on A.uid=B.uid
    where
    B.cap=1500 and B.cp>1200
    and B.uid in ('WORMADAM_TRASH','FORRETRESS','MUNCHLAX','GLIGAR','PILOSWINE','SCIZOR_NORMAL','DRAPION','SKUNTANK','MUK_ALOLA','LICKILICKY','ESCAVALIER','STEELIX_NORMAL','SNORLAX_NORMAL','SNORLAX_SHADOW','GLISCOR','RATICATE_ALOLA','CRUSTLE','FERROTHORN','PIDGEOT','HIPPOWDON_NORMAL','VESPIQUEN','SWELLOW','HERACROSS','GRIMER_ALOLA','TOXICROAK','DUNSPARCE','TRANQUILL','SWALOT','FLYGON_NORMAL','PERSIAN_NORMAL','DURANT','GOLBAT_NORMAL','GOLBAT_SHADOW','MAMOSWINE','STARAPTOR','VENUSAUR_NORMAL','STOUTLAND','CROBAT_NORMAL','CLAYDOL','QWILFISH','VIRIZION','MILTANK','UNFEZANT','CASTFORM_NORMAL','FEAROW','SCYTHER_NORMAL','IVYSAUR_NORMAL','CHATOT','GRAVELER_NORMAL','BEEDRILL_NORMAL','WIGGLYTUFF','BIBAREL','GLOOM_NORMAL','WORMADAM_SANDY','PORYGON2_NORMAL','MUK_NORMAL','LEDIAN','CAMERUPT','KRICKETUNE','RHYPERIOR_NORMAL','MEGANIUM','PURUGLY','LICKITUNG','EXCADRILL','YANMA','NIDOQUEEN','VICTREEBEL_NORMAL','YANMEGA','GABITE_NORMAL','BUTTERFREE','AMOONGUSS','CRADILY','ARBOK_NORMAL','VENOMOTH_NORMAL','CELEBI','SCOLIPEDE','GOLEM_NORMAL','VILEPLUME_NORMAL','DELCATTY','BAYLEEF','GIRAFARIG','ARMALDO','FARFETCHD','SERPERIOR','LINOONE_GALARIAN','URSARING','BELLOSSOM_NORMAL','DONPHAN','MASQUERAIN','SHIFTRY_NORMAL','GROTLE_NORMAL','GARBODOR','GARCHOMP_NORMAL','TENTACRUEL','NINJASK','SCEPTILE','DUSTOX','WORMADAM_PLANT','WEEPINBELL_NORMAL','EXPLOUD','WATCHOG','SEVIPER')
    --and B.uid in ('TOXICROAK','PARASECT','MUK_ALOLA')
),
-- eligible Pokemon all patterns
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
)
select
    PLAYER.uid, PLAYER.f_pow, PLAYER.c_pow, PLAYER.def, PLAYER.hpt, PLAYER.f_uid, PLAYER.f_type, PLAYER.c_uid, PLAYER.c_type,
    OPPONENT.uid as o_uid, OPPONENT.f_pow, OPPONENT.c_pow, OPPONENT.def, OPPONENT.hpt, OPPONENT.f_uid as o_f_uid, OPPONENT.f_type as o_f_type, OPPONENT.c_uid as o_c_uid, OPPONENT.c_type as o_c_type,
    calc_killtime_combat(OPPONENT.hpt, (FLOOR(EF_P.f_eff * PLAYER.f_pow / OPPONENT.def) + 1), PLAYER.f_ene, PLAYER.f_dur, (FLOOR(EF_P.c_eff * PLAYER.c_pow / OPPONENT.def) + 1), PLAYER.c_ene, 0) as kill0,
    calc_killtime_combat(OPPONENT.hpt, (FLOOR(EF_P.f_eff * PLAYER.f_pow / OPPONENT.def) + 1), PLAYER.f_ene, PLAYER.f_dur, (FLOOR(EF_P.c_eff * PLAYER.c_pow / OPPONENT.def) + 1), PLAYER.c_ene, 2) as kill2,
    calc_killtime_combat(PLAYER.hpt, (FLOOR(EF_O.f_eff * OPPONENT.f_pow / PLAYER.def) + 1), OPPONENT.f_ene, OPPONENT.f_dur, (FLOOR(EF_O.c_eff * OPPONENT.c_pow / PLAYER.def) + 1), OPPONENT.c_ene, 0) as death0,
    calc_killtime_combat(PLAYER.hpt, (FLOOR(EF_O.f_eff * OPPONENT.f_pow / PLAYER.def) + 1), OPPONENT.f_ene, OPPONENT.f_dur, (FLOOR(EF_O.c_eff * OPPONENT.c_pow / PLAYER.def) + 1), OPPONENT.c_ene, 2) as death2,
    (FLOOR(EF_P.f_eff * PLAYER.f_pow / OPPONENT.def) + 1)::numeric as f_dmg,
    (FLOOR(EF_P.c_eff * PLAYER.c_pow / OPPONENT.def) + 1)::numeric as c_dmg,
    (FLOOR(EF_O.f_eff * OPPONENT.f_pow / PLAYER.def) + 1)::numeric as o_f_dmg,
    (FLOOR(EF_O.c_eff * OPPONENT.c_pow / PLAYER.def) + 1)::numeric as o_c_dmg
--    EF_P.f_eff as f_eff, EF_P.c_eff as c_eff,
--    EF_O.f_eff as o_f_eff, EF_O.c_eff as o_c_eff
from AA as PLAYER
join AA as OPPONENT on true
left join EFFE as EF_P on EF_P.uid=PLAYER.uid and EF_P.f_uid=PLAYER.f_uid and EF_P.f_type=PLAYER.f_type and EF_P.c_uid=PLAYER.c_uid and EF_P.o_uid=OPPONENT.uid
left join EFFE as EF_O on EF_O.uid=OPPONENT.uid and EF_O.f_uid=OPPONENT.f_uid and EF_O.f_type=OPPONENT.f_type and EF_O.c_uid=OPPONENT.c_uid and EF_O.o_uid=PLAYER.uid
where OPPONENT.uid~'SNORLAX'
and OPPONENT.f_uid='LICK' and OPPONENT.c_uid='BODY_SLAM'
and PLAYER.uid='GOLBAT_NORMAL'
and PLAYER.f_uid='WING_ATTACK' and PLAYER.c_uid='AIR_CUTTER'
--and PLAYER.f_uid=OPPONENT.f_uid and PLAYER.c_uid=OPPONENT.c_uid
;


