-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='1'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='2'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='3'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='4'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='5'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='6'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='7'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='8'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='9'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='10'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='11'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='12'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='13'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='14'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='15'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='16'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='17'
order by ppe desc
;

-- charge moves by types
select                            
B.jp,B.en,D.jp as type,
COALESCE(A.power,0) as pow,
COALESCE(A.energy,0) as ene,
ROUND(COALESCE(A.power,0)::numeric / COALESCE(A.energy,0)::numeric, 2) as ppe,
E.cnt as usercount
from _chargemove_combat A
join localize_chargemove B on A.uid=B.uid
join _type C on C.index=A.type
join localize_type D on D.uid=C.uid
left join (
    select move_uid, count(*) as cnt from pokemon_chargemove_combat group by move_uid
)E on E.move_uid=A.uid
where A.type='18'
order by ppe desc
;
