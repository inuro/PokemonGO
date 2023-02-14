\a
\pset fieldsep '\t'
\pset tuples_only t
\o ~/Downloads/SERPERIOR2500.tsv

select * from calc_all_iv_pattern('SERPERIOR',2500) order by atk+def+hpt desc, def*hpt desc, cp desc;

\o
\pset tuples_only f
\pset fieldsep '|'
\a
