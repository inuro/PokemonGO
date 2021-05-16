\a
\pset fieldsep '\t'
\pset tuples_only t
\o ~/weakness.tsv

select         
A.pokemon_id, B.jp, A.uid, A.type_1, A.type_2,
calc_weakness('NORMAL',A.type_1,A.type_2) as Normal,
calc_weakness('FIGHTING',A.type_1,A.type_2) as Fighting,
calc_weakness('FLYING',A.type_1,A.type_2) as Flying,
calc_weakness('POISON',A.type_1,A.type_2) as Poison,
calc_weakness('GROUND',A.type_1,A.type_2) as Ground,
calc_weakness('ROCK',A.type_1,A.type_2) as Rock,
calc_weakness('BUG',A.type_1,A.type_2) as Bug,
calc_weakness('GHOST',A.type_1,A.type_2) as Ghost,
calc_weakness('STEEL',A.type_1,A.type_2) as Steel,
calc_weakness('FIRE',A.type_1,A.type_2) as Fire,
calc_weakness('WATER',A.type_1,A.type_2) as Water,
calc_weakness('GRASS',A.type_1,A.type_2) as Grass,
calc_weakness('ELECTRIC',A.type_1,A.type_2) as Electric,
calc_weakness('PSYCHIC',A.type_1,A.type_2) as Psychic,
calc_weakness('ICE',A.type_1,A.type_2) as Ice,
calc_weakness('DRAGON',A.type_1,A.type_2) as Dragon,
calc_weakness('DARK',A.type_1,A.type_2) as Dark,
calc_weakness('FAIRY',A.type_1,A.type_2) as Fairy
from _pokemon A left join localize_pokemon B using(uid)
where uid !~ '_SHADOW$';

\o
\pset tuples_only f
\pset fieldsep '|'
\a
