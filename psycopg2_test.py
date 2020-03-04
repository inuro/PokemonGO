#!/var/bin/python 
import psycopg2
import psycopg2.extras


conn = psycopg2.connect("dbname=pokemongo") 
cur=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
cur.execute("select * from pokemon limit 3;")
results = cur.fetchall()
dict_result = []
for row in results:
    #print(row)
    dict_result.append(dict(row))
    print(dict_result)
#print(dict_result)



