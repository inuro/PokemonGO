# cp.py
# calc cp from iv
# [usage]
# $ python cp.py AROMATISSE 1 14 10
import sys
import psycopg2
import psycopg2.extras

# convert decimal value from psycopg2 to float
# https://stackoverflow.com/questions/56359506/how-to-get-float-values-from-postgresql-table-as-float-only-instead-of-decimal-i
DEC2FLOAT = psycopg2.extensions.new_type(
    psycopg2.extensions.DECIMAL.values,
    'DEC2FLOAT',
    lambda value, curs: float(value) if value is not None else None)
psycopg2.extensions.register_type(DEC2FLOAT)


args = sys.argv
#print(args)
try:
    (comm, uid, at, df, hp) = args[:5]
except:
    print('[usage] $ cp.py pokemon_uid at df hp')
    exit(1)


query = """
with A as (
select
    (floor((B.at+{}) * (sqrt(B.df+{})) * (sqrt(B.hp+{})) * (A.mlp * A.mlp) / 10))::INTEGER as cp,
    A.lv as lv,
    ((B.at+{}) * A.mlp)::NUMERIC as atk,
    ((B.df+{}) * A.mlp)::NUMERIC as def,
    Floor((B.hp+{}) * A.mlp)::NUMERIC as hpt
from _cpm A
join _pokemon B on B.uid in (puid('{}'))
) select * from A where A.cp <= {} and A.lv <= 50 order by A.cp desc limit 1;
"""


conn = psycopg2.connect("dbname=pokemongo2") 
for cap_cp in [1500,2500,5500]:
    cur=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(query.format(at,df,hp,at,df,hp,uid,cap_cp))
    results = cur.fetchall()
    for row in results:
        print(cap_cp, row)

