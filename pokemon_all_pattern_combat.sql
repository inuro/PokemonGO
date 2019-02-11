-- \a　
-- \pset fieldsep '\t'
-- \pset tuples_only t
-- \o pokemon_all_pattern_combat.csv

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


