\a
\pset tuples_only t
\pset fieldsep '\t'
\o ./localize_pokemon_temp.tsv

With A as (
    select pokemon_id, uid as original, REGEXP_REPLACE(uid,'(_NORMAL|_SHADOW|_ALOLA|_GALARIAN|_HISUIAN)$','') as uid,
    jp as original_jp, en as original_en
    from _pokemon left join localize_pokemon using(uid, pokemon_id) 
)
select pokemon_id, original,
    case 
        when original_jp is null and original ~ '_SHADOW$' then COALESCE(B.jp,C.jp) || ' (シャドウ)'
        when original_jp is null and original ~ '_ALOLA$' then COALESCE(B.jp,C.jp) || ' (アローラのすがた)'
        when original_jp is null and original ~ '_GALARIAN$' then COALESCE(B.jp,C.jp) || ' (ガラルのすがた)' 
        when original_jp is null and original ~ '_HISUIAN$' then COALESCE(B.jp,C.jp) || ' (ヒスイのすがた)' 
    else
        case when original_jp is null then C.jp || '※' else original_jp end
    end as jp, 
    case 
        when original_jp is null and original ~ '_SHADOW$' then COALESCE(B.en,C.en) || ' (Shadow)' 
        when original_jp is null and original ~ '_ALOLA$' then 'Alolan ' || COALESCE(B.en,C.en)
        when original_jp is null and original ~ '_GALARIAN$' then 'Galarian ' || COALESCE(B.en,C.en) 
        when original_jp is null and original ~ '_HISUIAN$' then 'Hisuian ' || COALESCE(B.en,C.en) 
    else
        case when original_en is null then C.en || '※' else original_en end 
    end as en
from A 
left join localize_pokemon B using(uid, pokemon_id)
left join original_pokemon_localization C using(pokemon_id);
