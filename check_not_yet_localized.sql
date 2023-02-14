With A as (
    select A.pokemon_id, A.uid as original, REGEXP_REPLACE(uid,'_SHADOW','') as uid from _pokemon A 
    left join localize_pokemon B using(uid) 
    where jp is null
)
select A.pokemon_id, A.original, B.jp || ' (シャドウ)', B.en || ' (Shadow)'
from A
left join localize_pokemon B using(uid);
