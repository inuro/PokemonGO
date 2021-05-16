#!/var/bin/python 
import psycopg2
import psycopg2.extras
import simplejson
import datetime


conn = psycopg2.connect("dbname=pokemongo2") 

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

#   get highest stats for specific pokemon/cap cp
def top_iv(uid, cap_cp, cap_lv):
    cur=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    ivs = []
    for at in range(16):
        for df in range(16):
            for hp in range(16):
                #query = "select * from calc_all('{0},{1},{2},{3},{4},{5}');".format(uid, cap_cp, at, df, hp, cap_lv)
                #print(query)
                query = top_iv_query.format(at,df,hp,at,df,hp,uid,cap_cp,cap_lv)
                cur.execute(query)
                results = cur.fetchall()
                for row in results:
                    #print(row)
                    result = dict(row)
                    result['at'] = at
                    result['df'] = df
                    result['hp'] = hp
                    ivs.append(result)
                    #print(simplejson.dumps(result))
                    #print('AT:{0}/DF:{1}/HP:{2} | {3}'.format(at, df, hp, simplejson.dumps(dict(row))))
    result = sorted(ivs, key = lambda x:float(x['hpt']+x['def']+x['atk'])+float(x['cp']/1000), reverse=True)[0]
#    result = sorted(ivs, key = lambda x:float(x['hpt']*x['def']+x['atk'])+float(x['cp']/100), reverse=True)[0]
    result['uid'] = uid
    cur.close()
    return result




# retrieve all pokemon uid
cur1 = conn.cursor()
query = """
select uid from _pokemon where at is not null;
"""
cur1.execute(query)
uids = cur1.fetchall()

# initiate top_iv table
cur2 = conn.cursor()
query = """
DROP TABLE if exists top_iv;
CREATE TABLE top_iv(
    uid text,
    cp integer,
    lv numeric,
    at integer, df integer, hp integer, 
    atk numeric, def numeric, hpt numeric, 
    cap integer 
);
"""
cur2.execute(query)

# loop each uid
start = datetime.datetime.now()
previous = start
print("start: {}".format(start))
cap_lv = 50
for cap_cp in [1500,2500,5500]:
    print("cap:{}".format(cap_cp))
    for uid in uids:
        #print(uid[0])
        result = top_iv(uid[0], cap_cp, cap_lv)
        #print(simplejson.dumps(result))
        query = "INSERT into top_iv(uid,cp,lv,at,df,hp,atk,def,hpt,cap) values ('{}',{},{},{},{},{},{},{},{},{});".format(result['uid'],result['cp'],result['lv'],result['at'],result['df'],result['hp'],result['atk'],result['def'],result['hpt'],cap_cp)
        cur2.execute(query)
        thistime = datetime.datetime.now()
        print("{} / {} elapsed\t{}".format((thistime - previous).total_seconds(), thistime - start,result['uid']))
        previous = thistime
        conn.commit()
end = datetime.datetime.now()
print("finish: {} / {} elapsed".format(end, (end - start)))


# closing
conn.commit()
cur2.close()
cur1.close()
conn.close()
