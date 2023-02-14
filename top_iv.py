#!/var/bin/python 

# $ python top_iv.py -d pokemongo2 -l 50 -c 1500
# $ python top_iv.py -d pokemongo2 -l 50 -c 2500
# $ python top_iv.py -d pokemongo2 -l 50 -c 10000
# $ python top_iv.py -d pokemongo2 -l 40 -c 10000
 
import psycopg2
import psycopg2.extras
import datetime
import argparse

# definition
#db = 'pokemongo2'
db = 'sandbox'
table = 'top_iv'
pokemon_table = '_pokemon'
not_yet_table = '_not_yet'

# arguments
parser = argparse.ArgumentParser(description='Calculate best IV for each CP cap')
parser.add_argument('-i', '--init', type=bool, default=False, help='Wipe current table and create new')
parser.add_argument('-l', '--lv', type=int, default=50, help='level cap (default:50)')
parser.add_argument('-c', '--cp', default=1500, choices=['1500','2500','10000'], help='level cap (1500,2500,10000)')
parser.add_argument('-d', '--db', default=db, help='db(default:{})'.format(db))
args = parser.parse_args()
print(args)

# connect to Database
db = args.db
conn = psycopg2.connect("dbname={}".format(db)) 
cur = conn.cursor()

# top_iv_query
# format: at,df,hp,at,df,hp,uid,cap_cp,at,df,hp,cap_cp,cap_lv
top_iv_query = """
with A as (
select
    (floor((B.at+{}) * (sqrt(B.df+{})) * (sqrt(B.hp+{})) * (A.mlp * A.mlp) / 10))::INTEGER as cp,
    A.lv as lv,
    ((B.at+{}) * A.mlp)::NUMERIC as atk,
    ((B.df+{}) * A.mlp)::NUMERIC as def,
    Floor((B.hp+{}) * A.mlp)::NUMERIC as hpt
from _cpm A
join _pokemon B on B.uid in ('{}')
) select * from A where A.cp <= {} and A.lv <= {} order by A.cp desc limit 1;
"""

# query for 100% (15/15/15)
# format: uid, cap_lv
perfect_iv_query = """
select 
    (floor((B.at+15) * (sqrt(B.df+15)) * (sqrt(B.hp+15)) * (A.mlp * A.mlp) / 10))::INTEGER as cp, 
    A.lv as lv,
    ((B.at+15) * A.mlp)::NUMERIC as atk,
    ((B.df+15) * A.mlp)::NUMERIC as def,
    Floor((B.hp+15) * A.mlp)::NUMERIC as hpt
from _cpm A join _pokemon B on B.uid in ('{}') 
where A.lv = {};
"""


#   get highest stats for specific pokemon/cap cp
def top_iv(uid, cap_cp, cap_lv):
    cur=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    # first, check whether 100% hits limit
    query = perfect_iv_query.format(uid, cap_lv)
    cur.execute(query)
    result = dict(cur.fetchone())
    if result['cp'] < cap_cp:
        result['at'] = result['df'] = result['hp'] = 15
        result['uid'] = uid
    
    # check all IV
    else:
        ivs = []
        for at in range(16):
            for df in range(16):
                for hp in range(16):
                    query = top_iv_query.format(at,df,hp,at,df,hp,uid,cap_cp,cap_lv)
                    cur.execute(query)
                    results = cur.fetchall()
                    for row in results:
                        result = dict(row)
                        result['at'] = at
                        result['df'] = df
                        result['hp'] = hp
                        ivs.append(result)
        result = sorted(ivs, key = lambda x:float(x['hpt']+x['def']+x['atk'])+float(x['cp']/1000), reverse=True)[0]
        result['uid'] = uid
    cur.close()
    return result


# table creation(check whether exists) 
cur1 = conn.cursor()
query = "select exists (select relname from pg_class where relname='{}');".format(table)
cur1.execute(query)
rows = cur1.fetchone()
# initialize table if initflag or doesn't exist yet
if rows[0] == False or args.init == True:
    print('Initialise table "{}" on DB "{}"...'.format(table, db))
    cur2 = conn.cursor()
    query = """
    DROP TABLE if exists {};
    CREATE TABLE {}(
        uid text,
        cp integer,
        lv numeric,
        at integer, df integer, hp integer, 
        atk numeric, def numeric, hpt numeric, 
        cap_cp integer,
        cap_lv integer
    );
    """.format(table,table)
    print(query)
    cur2.execute(query)
    conn.commit()
    cur2.close()
# wipe existing records matching conditions
else:
    print('Table "{}" already exists on DB "{}"'.format(table, db))
    print('Wipe current records for cap cp:{} / lv:{}'.format(args.cp, args.lv))
    cur2 = conn.cursor()
    query = "DELETE from {} where cap_cp={} and cap_lv={};".format(table, args.cp, args.lv)
    cur2.execute(query)
    conn.commit()
    cur2.close()
# dammy table insert for test
"""
insert into top_iv(uid,cp,lv,at,df,hp,atk,def,hpt,cap_cp,cap_lv) values ('hoge',13,13,13,13,13,13,13,13,1500,50);
insert into top_iv(uid,cp,lv,at,df,hp,atk,def,hpt,cap_cp,cap_lv) values ('hoge',13,13,13,13,13,13,13,13,5500,40);
"""



# retrieve all pokemon uid
cur1 = conn.cursor()
query = """
select uid from {} where uid not in (select uid from {});
""".format(pokemon_table, not_yet_table)
cur1.execute(query)
uids = cur1.fetchall()
num_of_uids = len(uids)

# loop each uid
start = datetime.datetime.now()
previous = start
print("start: {}".format(start))
cap_lv = int(args.lv)
cap_cp = int(args.cp)
print("cap cp:{} / lv:{}".format(cap_cp, cap_lv))
for uid in uids:
    #print(uid[0])
    result = top_iv(uid[0], cap_cp, cap_lv)
    #print(simplejson.dumps(result))
    query = "INSERT into top_iv(uid,cp,lv,at,df,hp,atk,def,hpt,cap_cp,cap_lv) values ('{}',{},{},{},{},{},{},{},{},{},{});".format(result['uid'],result['cp'],result['lv'],result['at'],result['df'],result['hp'],result['atk'],result['def'],result['hpt'],cap_cp,cap_lv)
    cur1.execute(query)
    thistime = datetime.datetime.now()
    print('! ' if result['at'] == result['df'] == result['hp'] == 15 else '  ', '{}/{}'.format(uids.index(uid), num_of_uids), query, (thistime - previous).total_seconds())
    #print("{} / {} elapsed\t{}".format((thistime - previous).total_seconds(), thistime - start,result['uid']))
    previous = thistime
    conn.commit()
end = datetime.datetime.now()
print("finish: {} / {} elapsed".format(end, (end - start)))


# closing
conn.commit()
cur1.close()
conn.close()
