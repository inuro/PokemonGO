-------------------------------------------------------------------------------
-- Original Pokemon loalization
drop table if exists original_pokemon_localization CASCADE;
create table if not exists original_pokemon_localization(
    pokemon_id text,
    jp text,
    en text,
    de text,
    fr text,
    ko text,
    cn text,
    tw text
);
\copy original_pokemon_localization(pokemon_id, jp, en, de, fr, ko, cn, tw) from 'original_pokemom_localization.tsv' with CSV delimiter E'\t' NULL '';
