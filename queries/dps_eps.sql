-- fastmove dps for blog
select 
    B.jp,B.en,
    CONCAT('{{< type ' , C.uid , ' >}}') as type,
    COALESCE(A.power,0) as dmg, 
    (A.duration + 1) * 0.5 as dur, 
    COALESCE(A.energy, 0) as ene,
    round(COALESCE(A.power,0)::numeric / ((A.duration + 1) * 0.5),1) as dps,
    round(COALESCE(A.energy, 0)::numeric / ((A.duration + 1) * 0.5), 1) as eps
from _fastmove_combat A
join localize_fastmove B on B.uid=A.uid
join localize_type C on C.index=A.type
order by dps desc
;

-- fastmove eps for blog
select 
    B.jp,B.en,
    CONCAT('{{< type ' , C.uid , ' >}}') as type,
    COALESCE(A.power,0) as dmg, 
    (A.duration + 1) * 0.5 as dur, 
    COALESCE(A.energy, 0) as ene,
    round(COALESCE(A.power,0)::numeric / ((A.duration + 1) * 0.5),1) as dps,
    round(COALESCE(A.energy, 0)::numeric / ((A.duration + 1) * 0.5), 1) as eps
from _fastmove_combat A
join localize_fastmove B on B.uid=A.uid
join localize_type C on C.index=A.type
order by eps desc
;

