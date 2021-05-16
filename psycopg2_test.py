#!/var/bin/python 
import psycopg2
import psycopg2.extras
import simplejson


conn = psycopg2.connect("dbname=pokemongo2") 
cur=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

for at in range(16):
    for df in range(16):
        for hp in range(16):
            cur.execute("select * from calc_all('ENTEI,2500,{0},{1},{2}');".format(at,df,hp))
            results = cur.fetchall()
            dict_result = []
            for row in results:
                #print(row)
                dict_result.append(dict(row))
                print('AT:{0}/DF:{1}/HP:{2} | {3}'.format(at, df, hp, simplejson.dumps(dict(row))))
            #print(dict_result)

#test




