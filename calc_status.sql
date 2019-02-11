-- \a　
-- \pset fieldsep '\t'
-- \pset tuples_only t
-- \o calc_status.tsv


-- master
select
    A.index, B.jp, B.en, A.type_1, A.type_2,
    A.hp as base_hp,
    A.at as base_at,
    A.df as base_df,
    C.cp,
    C.lv,
    C.hpt,
    C.atk,
    C.def,
    C.hpt * C.def as armorclass
from pokemon A
join localize_pokemon B on B.uid=A.uid
join calc_all(A.uid,5500,15,15,15) C on true
--where A.uid='LATIAS'
;


-- \o calc_status_2500.tsv
-- hyper
select
    A.index, B.jp, B.en, A.type_1, A.type_2,
    A.hp as base_hp,
    A.at as base_at,
    A.df as base_df,
    C.cp,
    C.lv,
    C.hpt,
    C.atk,
    C.def,
    C.hpt * C.def as armorclass
from pokemon A
join localize_pokemon B on B.uid=A.uid
join calc_all(A.uid,2500,15,15,15) C on true
;


-- \o calc_status_1500.tsv
-- hyper
select
    A.index, B.jp, B.en, A.type_1, A.type_2,
    A.hp as base_hp,
    A.at as base_at,
    A.df as base_df,
    C.cp,
    C.lv,
    C.hpt,
    C.atk,
    C.def,
    C.hpt * C.def as armorclass
from pokemon A
join localize_pokemon B on B.uid=A.uid
join calc_all(A.uid,1500,15,15,15) C on true
;

