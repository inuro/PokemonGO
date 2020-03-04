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
    --and B.uid in ('GOLEM_NORMAL','FORRETRESS')
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

