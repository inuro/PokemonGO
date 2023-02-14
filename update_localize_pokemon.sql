-- 現時点のlocalize_pokemonから、対処できていないものを出力する

\a
\pset tuples_only t
\pset fieldsep '\t'
\o ./localize_pokemon_temp.tsv

With A as (
    select pokemon_id, uid as original, REGEXP_REPLACE(uid,'(_SHADOW|_ALOLA|_GALARIAN)$','') as uid,
    jp as original_jp, en as original_en
    from _pokemon left join localize_pokemon using(uid, pokemon_id) 
)
select pokemon_id, original,
    case 
        when original_jp is null and original ~ '_SHADOW$' then B.jp || ' (シャドウ)'
        when original_jp is null and original ~ '_ALOLA$' then B.jp || ' (アローラのすがた)'
        when original_jp is null and original ~ '_GALARIAN$' then B.jp || ' (ガラルのすがた)' 
    else
        case when original_jp is null then C.jp || '※' else original_jp end
    end as jp, 
    case 
        when original_jp is null and original ~ '_SHADOW$' then B.en || ' (Shadow)' 
        when original_jp is null and original ~ '_ALOLA$' then 'Alolan ' || B.en
        when original_jp is null and original ~ '_GALARIAN$' then 'Galarian ' || B.en 
    else
        case when original_en is null then C.en || '※' else original_en end 
    end as en
from A 
left join localize_pokemon B using(uid, pokemon_id)
left join original_pokemon_localization C using(pokemon_id);
