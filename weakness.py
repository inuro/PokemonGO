# weakness.py
# export weakness table for Google Sheet
# usage
# $ python weakness.py > weakness.tsv

import sys
import psycopg2
import psycopg2.extras
import csv

# convert decimal value from psycopg2 to float
# https://stackoverflow.com/questions/56359506/how-to-get-float-values-from-postgresql-table-as-float-only-instead-of-decimal-i
DEC2FLOAT = psycopg2.extensions.new_type(
    psycopg2.extensions.DECIMAL.values,
    'DEC2FLOAT',
    lambda value, curs: float(value) if value is not None else None)
psycopg2.extensions.register_type(DEC2FLOAT)

# query 
conn = psycopg2.connect("dbname=pokemongo2") 
query = """
With A as(
    select 
        a.*, 
        C.jp,
        b1.attacker as attcker, 
        b1.mlp,b2.mlp,
        COALESCE(b1.mlp,1.0) * COALESCE(b2.mlp,1.0) as eff 
    from _pokemon a 
    left join _effectiveness b1 on b1.defender=a.type_1 
    left join _effectiveness b2 on b2.defender = a.type_2 and b2.attacker=b1.attacker
    left join localize_pokemon C using(uid)
    where a.uid !~ '_SHADOW'
), B as(
    select
        A.pokemon_id, A.jp, A.uid, A.type_1, A.type_2
        ,   (max(case when attcker='NORMAL' then eff else -100.0 end)) as NORMAL
        ,   (max(case when attcker='FIGHTING' then eff else -100.0 end)) as FIGHTING
        ,   (max(case when attcker='FLYING' then eff else -100.0 end)) as FLYING
        ,   (max(case when attcker='POISON' then eff else -100.0 end)) as POISON
        ,   (max(case when attcker='GROUND' then eff else -100.0 end)) as GROUND
        ,   (max(case when attcker='ROCK' then eff else -100.0 end)) as ROCK
        ,   (max(case when attcker='BUG' then eff else -100.0 end)) as BUG
        ,   (max(case when attcker='GHOST' then eff else -100.0 end)) as GHOST
        ,   (max(case when attcker='STEEL' then eff else -100.0 end)) as STEEL
        ,   (max(case when attcker='FIRE' then eff else -100.0 end)) as FIRE
        ,   (max(case when attcker='WATER' then eff else -100.0 end)) as WATER
        ,   (max(case when attcker='GRASS' then eff else -100.0 end)) as GRASS
        ,   (max(case when attcker='ELECTRIC' then eff else -100.0 end)) as ELECTRIC
        ,   (max(case when attcker='PSYCHIC' then eff else -100.0 end)) as PSYCHIC
        ,   (max(case when attcker='ICE' then eff else -100.0 end)) as ICE
        ,   (max(case when attcker='DRAGON' then eff else -100.0 end)) as DRAGON
        ,   (max(case when attcker='DARK' then eff else -100.0 end)) as DARK
        ,   (max(case when attcker='FAIRY' then eff else -100.0 end)) as FAIRY
    from A
    group by pokemon_id, uid, type_1, type_2, jp
)
select * from B
order by pokemon_id
;
"""
cur=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
cur.execute(query)
results = cur.fetchall()
for row in results:
    print('\t'.join(str(item) for item in row).replace('None',''))
cur.close()