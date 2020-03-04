- moves.sql

-- \a　
-- \pset fieldsep '\t'
-- \pset tuples_only t
-- \o moves_fast.tsv

select
    B.jp,B.en,
    C.uid as type,
    COALESCE(A.power,0) as dmg, 
    (A.duration + 1)*0.5 as dur,
    COALESCE(A.energy, 0) as ene,
    round(COALESCE(A.power,0)::numeric / ((A.duration + 1) * 0.5),1) as dps,
    round(COALESCE(A.energy, 0)::numeric / ((A.duration + 1) * 0.5), 1) as eps
from _fastmove_combat A
join localize_fastmove B on B.uid=A.uid
join localize_type C on C.index=A.type
order by type
;

-- \o moves_charge.tsv

select 
    B.jp,B.en,
    C.uid as type,
    COALESCE(A.power,0) as dmg, 
    COALESCE(A.energy, 0) as ene,
    round(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric,2) as dpe
from _chargemove_combat A
join localize_chargemove B on B.uid=A.uid
join localize_type C on C.index=A.type
order by type
;