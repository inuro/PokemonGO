#!/var/bin/python
# $ python simulation_love.py
# ラブラブカップシミュレーション
# 
# dependencies: top_iv テーブル, pattern_combat テーブル
# top_ivは $python top_iv.py で生成
# pattern_combatは、pattern_combat.sqlのSQLを実行 

# pattern_combatテーブルの攻撃の値は、既に対戦補正（x1.3）、STAB、シャドウ補正などが入っている。後必要なのはタイプ補正のみ

# usage for output
# 
# select B.jp,C.jp,D.jp,A.win,A.draw,A.lose  from simulation_love A left join localize_pokemon B using(uid) left join localize_fastmove C on C.uid=A.fast left join localize_chargemove D on D.uid=A.charge where cap=1500 order by win desc, lose limit 50;

import sys
import psycopg2
import psycopg2.extras
import simplejson
import datetime
import decimal
import math
import time
import argparse


db = 'sandbox'
table = 'simulation_love'


# convert decimal value from psycopg2 to float
# https://stackoverflow.com/questions/56359506/how-to-get-float-values-from-postgresql-table-as-float-only-instead-of-decimal-i
DEC2FLOAT = psycopg2.extensions.new_type(
    psycopg2.extensions.DECIMAL.values,
    'DEC2FLOAT',
    lambda value, curs: float(value) if value is not None else None)
psycopg2.extensions.register_type(DEC2FLOAT)

# percentage formatter
def pct(val):
    result = round(val * 100, 2)
    return '{}%'.format(result)



# type multiplier table
# key: tuple(attacker_type, defender_type), value:mlp
class Mlp:
    mlp = {}
    conn = psycopg2.connect("dbname={}".format(db)) 
    query = "select * from _effectiveness;"
    cur=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(query)
    results = cur.fetchall()
    for row in results:
        result = dict(row)
        mlp[tuple([result['attacker'],result['defender']])] = result['mlp']
    cur.close()
    # 攻撃のわざのType、防御のポケモンのType2つを受け取って結果を返す
    def calc(type_move, type_1, type_2 = None):
        return Mlp.mlp[(type_move, type_1)] * (Mlp.mlp[(type_move, type_2)] if type_2 is not None else 1.0)


# ポケモン管理クラス
class Pokemon:
    buff_mlp = [0.5, 0.5714286, 0.6666667, 0.8, 1.0, 1.25, 1.5, 1.75, 2.0]
    buff_mlp_max = len(buff_mlp) - 1

    # buff from chargemove
    # chargemove['LAST_RESORT']['buff']
    # chargemove['LAST_RESORT']['target_at']
    # chargemove['LAST_RESORT']['target_df']
    # chargemove['LAST_RESORT']['attacker_at']
    # chargemove['LAST_RESORT']['attacker_df']
    chargemove = {}
    conn = psycopg2.connect("dbname={}".format(db)) 
    query = "select * from _chargemove_combat;"
    cur=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(query)
    results = cur.fetchall()
    for row in results:
        result = dict(row)
        chargemove[result['uid']] = result
    cur.close()

    # print時の表現
    def __repr__(self):
        return repr((self.uid, self.fast, self.charge, self.ene, self.c_ene, self.maxhpt, self.hpt))
        #return repr((self.uid, self.fast, self.charge, self.atk, self.dfd, self.hpt))

    # 初期化
    # primaryは後でどっちがどっちか見分けるためのフラグ
    def __init__(self, stats, primary = False):
        self.primary = primary
        self.uid = stats['uid']
        self.atk = stats['atk']
        self.dfd = stats['def']
        self.hpt = stats['hpt']
        # 最大HP
        self.maxhpt = stats['hpt']
        self.type_1 = stats['type_1']
        self.type_2 = stats['type_2']

        self.fast = stats['fast']
        self.f_pow = stats['f_pow']
        self.f_type = stats['f_type']
        self.f_ene = stats['f_ene']
        # durは秒からターンに変えて格納
        self.f_dur = int(stats['f_dur'] / 0.5) - 1

        self.charge = stats['charge']
        self.c_pow = stats['c_pow']
        self.c_type = stats['c_type']
        self.c_ene = stats['c_ene']

        # チャージ済みのエネルギー
        self.ene = 0
        # atkとdefのそれぞれのlevel。buffで変化する
        self.atk_level = 4
        self.dfd_level = 4
        # シールド残量
        self.shield = 0
        # Fastを撃ってから発動までのカウントダウンターン
        self.f_cooldown = 0
    
    # 自分に作用するbuffを掛ける
    def buff_myself(self, move):
        if Pokemon.chargemove[move]['buff'] == 1:
            self.atk_level = self.atk_level + int(Pokemon.chargemove[move]['attacker_at'])
            self.dfd_level = self.dfd_level + int(Pokemon.chargemove[move]['attacker_df'])
            self.atk_level =  max(min(Pokemon.buff_mlp_max, self.atk_level), 0)
            self.dfd_level =  max(min(Pokemon.buff_mlp_max, self.dfd_level), 0)

    # 相手からbuffを掛けられる
    def got_buffed(self, move):
        if Pokemon.chargemove[move]['buff'] == 1:
            self.atk_level = self.atk_level + int(Pokemon.chargemove[move]['target_at'])
            self.dfd_level = self.dfd_level + int(Pokemon.chargemove[move]['target_df'])
            self.atk_level =  max(min(Pokemon.buff_mlp_max, self.atk_level), 0)
            self.dfd_level =  max(min(Pokemon.buff_mlp_max, self.dfd_level), 0)

    # buffを考慮した現在のわざの出力を返す
    def buffed_f_pow(self):
        return Pokemon.buff_mlp[self.atk_level] * self.f_pow
    def buffed_c_pow(self):
        return Pokemon.buff_mlp[self.atk_level] * self.c_pow
    # buffを考慮した防御力を返す
    def buffed_dfd(self):
        return Pokemon.buff_mlp[self.dfd_level] * self.dfd
    
    # 必殺技が発動可能か？(c_powは負の値)
    def charged(self):
        return self.ene + self.c_ene >= 0
    
    # 必殺技を使用する。計算されたダメージ量を返す
    # ダメージを与え、使用した分エネルギーを減らし、バフを適用する
    def use_charge(self, target):
        if self.charged():
            self.ene += self.c_ene
            damage = self.c_damage(target)
            # もしシールドがあるならそれを減らす
            target.got_charge_damage(damage)

            # バフの処理
            self.buff_myself(self.charge)
            target.got_buffed(self.charge)
            # 戻り値はダメージ
            return damage
        else:
            return 0
    
    # 通常技を使用する。計算されたダメージ量を返す
    # エネルギーをチャージする（Max100）
    def use_fast(self, target, cancel=False):
        # クールダウンが0＝技を発動してないなら、新たに技を発動する
        if self.f_cooldown == 0:
            self.f_cooldown = self.f_dur
        # クールダウンが>0＝技を発動中なら、クールダウンをデクリメントする
        # もしキャンセル指示があったらクールダウンを強制的に0にする
        else:
            self.f_cooldown -= 1
            if cancel:
                self.f_cooldown = 0
        
        # クールダウンが完了したら技を発動し、相手のHPTを減らし、エネルギーを増やす
        if self.f_cooldown == 0:
            self.ene = min(self.ene + self.f_ene, 100)
            damage = self.f_damage(target)
            target.got_fast_damage(damage)
            return damage
        else:
            return 0

    # ダメージを受ける側の処理
    def got_charge_damage(self, damage):
        if self.shield > 0:
            self.shield -= 1
        else:
            self.hpt -= damage
        return self.hpt
    
    def got_fast_damage(self, damage):
        self.hpt -= damage
        return self.hpt
    
    # ポケモンAからポケモンTへのFastmoveのダメージを計算する
    def f_damage(self, target):
        pow = self.buffed_f_pow()
        mlp = Mlp.calc(self.f_type, target.type_1, target.type_2)
        dfd = target.buffed_dfd()
        return math.floor(0.5 * pow * mlp / dfd) + 1

    # ポケモンAからポケモンTへのChargemoveのダメージを計算する
    def c_damage(self, target):
        pow = self.buffed_c_pow()
        mlp = Mlp.calc(self.c_type, target.type_1, target.type_2)
        dfd = target.buffed_dfd()
        return math.floor(0.5 * pow * mlp / dfd) + 1



# 対戦を管理するクラス
# それぞれのポケモンのステータス、現在HP、現在ATK、現在DEF、シールド残数
# 及びターン数
class Combat:    
    def __init__(self, pokemon1, pokemon2):
        # 2匹のポケモンデータを引数に取る
        # atkの降順にソートしておく
        # 後で引数順にソートしなおすためにprimaryを設定しておく
        self.mon = sorted([Pokemon(pokemon1, True), Pokemon(pokemon2, False)], key=lambda x:x.atk, reverse=True)

    # シミュレート
    # シールドの枚数を指定する
    def simulate(self, shield = 0):
        self.mon[0].shield = self.mon[1].shield = shield
        turn = 0
        #print(self.mon[0], self.mon[1])
        while self.mon[0].hpt > 0 and self.mon[1].hpt > 0:
            #ターンを進める
            turn += 1

            mon_0_dmg = mon_1_dmg = 0

            mon_0_charge_used = False
            mon_1_charge_used = False
            # 先攻の必殺技の発動
            if self.mon[0].charged():
                mon_0_dmg = self.mon[0].use_charge(self.mon[1])
                mon_0_charge_used = True
            # 後攻は先攻の必殺技で死んだら発動できない
            if self.mon[1].charged() and self.mon[1].hpt > 0:
                mon_1_dmg = self.mon[1].use_charge(self.mon[0])
                mon_1_charge_used = True
            
            # 通常技の発動は、必殺技を使わなかった場合のみ
            # もし相手が必殺技を発動していたら、クールダウンの残りはキャンセルされるのでその情報を渡す
            if mon_0_charge_used == False:
                mon_0_dmg = self.mon[0].use_fast(self.mon[1], mon_1_charge_used)
            if mon_1_charge_used == False:
                mon_1_dmg = self.mon[1].use_fast(self.mon[0], mon_0_charge_used)
            
            #print(turn, self.mon[0],mon_0_dmg, self.mon[1],mon_1_dmg)

        # どちらかのHPTが0になったら終了
        # 0になるまでのターンと、その時点で生き残っている方のHPが何％かを返す
        result = sorted(self.mon, key=lambda x:x.primary, reverse=True)
        return{
            'turn': turn,
            'result': result
        }
                


# arguments

parser = argparse.ArgumentParser(description='Simulate Pokemon Combat')
parser.add_argument('-i', '--init', type=bool, default=True, help='Initialize simulation_love table')
parser.add_argument('-s', '--shield', type=int, default=1, choices=range(0, 3), help='how many shield use in simiulation (0-2)')
args = parser.parse_args()
print(args)

cap_cp = 1500
cap_lv = 50


# initiate combat result table
conn = psycopg2.connect("dbname={}".format(db)) 
# target caps and shield
caps = []
caps = [cap_cp]
shield = args.shield

# clear all table
if args.init == True:
    print('Drop entire table.')
    cur2 = conn.cursor()
    query = """
    DROP TABLE if exists {};
    CREATE TABLE {}(
        uid text,
        fast text,
        charge text,
        win integer, draw integer, lose integer,
        cap_cp integer,
        cap_lv integer,
        shield integer
    );
    """.format(table,table)
    cur2.execute(query)
# clear target records only
else:
    cur2 = conn.cursor()
    for cap in caps:
        print('Delete records where cap={} and shield={}.'.format(cap, shield))
        query = "DELETE from {} where cap={} and shield={};".format(table,cap, shield)
        cur2.execute(query)

# simulate now
start = datetime.datetime.now()
previous = start
print("start: {}".format(start))
for cap in caps:
    # Pokemon pattern db roading
    cur1=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "select A.* from pattern_combat A left join _pokemon B using(uid) where cap_cp=1500 and cap_lv=50 and (uid ~ 'CHARMANDER' or uid ~ 'CHARMELEON' or uid ~ 'CHARIZARD' or uid ~ 'CHARIZARD' or uid ~ 'CLEFAIRY' or uid ~ 'CLEFABLE' or uid ~ 'JIGGLYPUFF' or uid ~ 'WIGGLYTUFF' or uid ~ 'VILEPLUME' or uid ~ 'PARAS' or uid ~ 'PARASECT' or uid ~ 'SLOWPOKE' or uid ~ 'SLOWBRO' or uid ~ 'KRABBY' or uid ~ 'KINGLER' or uid ~ 'VOLTORB' or uid ~ 'ELECTRODE' or uid ~ 'EXEGGCUTE' or uid ~ 'LICKITUNG' or uid ~ 'CHANSEY' or uid ~ 'GOLDEEN' or uid ~ 'SEAKING' or uid ~ 'MR_MIME_NORMAL' or uid ~ 'JYNX' or uid ~ 'MAGMAR' or uid ~ 'MAGIKARP' or uid ~ 'FLAREON' or uid ~ 'PORYGON' or uid ~ 'LEDYBA' or uid ~ 'LEDIAN' or uid ~ 'ARIADOS' or uid ~ 'CLEFFA' or uid ~ 'IGGLYBUFF' or uid ~ 'FLAAFFY' or uid ~ 'HOPPIP' or uid ~ 'YANMA' or uid ~ 'SLOWKING' or uid ~ 'SNUBBULL' or uid ~ 'SCIZOR' or uid ~ 'SLUGMA' or uid ~ 'MAGCARGO' or uid ~ 'CORSOLA' or uid ~ 'OCTILLERY' or uid ~ 'DELIBIRD' or uid ~ 'PORYGON2' or uid ~ 'SMOOCHUM' or uid ~ 'MAGBY' or uid ~ 'MILTANK' or uid ~ 'BLISSEY' or uid ~ 'TORCHIC' or uid ~ 'COMBUSKEN' or uid ~ 'BLAZIKEN' or uid ~ 'WURMPLE' or uid ~ 'WHISMUR' or uid ~ 'SKITTY' or uid ~ 'MEDICHAM' or uid ~ 'CARVANHA' or uid ~ 'CAMERUPT' or uid ~ 'SOLROCK' or uid ~ 'CORPHISH' or uid ~ 'CRAWDAUNT' or uid ~ 'MILOTIC' or uid ~ 'CASTFORM_SUNNY' or uid ~ 'GOREBYSS' or uid ~ 'LUVDISC' or uid ~ 'KRICKETOT' or uid ~ 'KRICKETUNE' or uid ~ 'BURMY_TRASH' or uid ~ 'WORMADAM_TRASH' or uid ~ 'CHERUBI' or uid ~ 'CHERRIM_SUNNY' or uid ~ 'MIME_JR' or uid ~ 'HAPPINY' or uid ~ 'LICKILICKY' or uid ~ 'MAGMORTAR' or uid ~ 'PORYGON_Z' or uid ~ 'ROTOM' or uid ~ 'TEPIG' or uid ~ 'PIGNITE' or uid ~ 'EMBOAR' or uid ~ 'PANSEAR' or uid ~ 'SIMISEAR' or uid ~ 'MUNNA' or uid ~ 'MUSHARNA' or uid ~ 'AUDINO' or uid ~ 'THROH' or uid ~ 'VENIPEDE' or uid ~ 'SCOLIPEDE' or uid ~ 'KROOKODILE' or uid ~ 'DARUMAKA_NORMAL' or uid ~ 'DARMANITAN_STANDARD' or uid ~ 'DWEBBLE' or uid ~ 'CRUSTLE' or uid ~ 'SCRAFTY' or uid ~ 'DEERLING_SPRING' or uid ~ 'DEERLING_AUTUMN' or uid ~ 'ALOMOMOLA' or uid ~ 'SHELMET' or uid ~ 'ACCELGOR' or uid ~ 'DRUDDIGON' or uid ~ 'PAWNIARD' or uid ~ 'BISHARP' or uid ~ 'BRAVIARY' or uid ~ 'HEATMOR' or uid ~ 'FENNEKIN' or uid ~ 'BRAIXEN' or uid ~ 'DELPHOX' or uid ~ 'FLETCHLING' or uid ~ 'FLETCHINDER' or uid ~ 'TALONFLAME' or uid ~ 'SPRITZEE' or uid ~ 'AROMATISSE' or uid ~ 'SYLVEON');"
    cur1.execute(query.format(cap))
    results = cur1.fetchall()
    cur1.close()

    ttl = len(results)
    cnt = 0
    #for p1 in results[:3]:
    for p1 in results:
        #Attackr
        A = dict(p1)
        #print(simplejson.dumps(A))
        win = 0
        draw = 0
        lose = 0
        #for p2 in results[11:13]:
        for p2 in results:
            #Target
            T = dict(p2)
            # Simulate
            btl = Combat(A, T)
            result = btl.simulate(shield)['result'] #数字はシールド
            ratio = max(result[0].hpt/result[0].maxhpt, result[1].hpt/result[1].maxhpt)
            if ratio < 0.05:
                draw += 1
            elif result[0].hpt > 0:
                win += 1
            else:
                lose += 1
            #print(result)
        
        # output
        thistime = datetime.datetime.now()
        cnt += 1
        print("{}\t{}/{}\t{}({}/{}) - win:{}/draw:{}/lose:{}\t{}".format(thistime - previous, cnt, ttl, A['uid'],A['fast'],A['charge'], win, draw, lose, win-lose))
        
        # insert simulation_love result into the table
        query = "INSERT into {}(uid,fast,charge,win,draw,lose,cap_cp,cap_lv,shield) values ('{}','{}','{}',{},{},{},{},{},{});".format(table, A['uid'],A['fast'],A['charge'], win, draw, lose, cap_cp,cap_lv, shield)
        cur2.execute(query)
        conn.commit()

end = datetime.datetime.now()
print("finish: {} / {} elapsed".format(end, (end - start)))

conn.commit()
cur2.close()
cur1.close()
conn.close()






temp = """

query = "select * from pattern_combat where cap='{}';"
cur=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
#sys.stderr.write(query.format(cap))
cur.execute(query.format(cap))
results = cur.fetchall()
cur.close()

#total = len(results)
#count = 0
#dt_start = datetime.datetime.now()
#sys.stderr.write("start:{}".format(dt_start))
for p1 in results:
    #Attackr
    A = dict(p1)
    #print(simplejson.dumps(A))

    #count += 1
    #sys.stderr.write("{}/{}\t{}\t{}\t{}".format(count, total, A['uid'],A['fast'],A['charge']))
    #time.sleep(1/1000)

    win = 0
    draw = 0
    lose = 0
    for p2 in results:
        #Target
        T = dict(p2)

        # attacker->T dmg
        A['f_dmg'] = f_dmg(A, T)
        A['f_dps'] = A['f_dmg'] / A['f_dur']
        A['c_dmg'] = c_dmg(A, T)
        A['ttl'] = A['f_dmg'] * A['turn'] + A['c_dmg']

        A['f_dmg_pct'] = A['f_dmg'] / T['hpt']
        A['f_dps_pct'] = A['f_dps'] / T['hpt']
        A['c_dmg_pct'] = A['c_dmg'] / T['hpt']
        A['ttl_pct'] = A['ttl'] / T['hpt']
        A['ttldps_pct'] = (A['ttl'] / A['chg']) / T['hpt']
        
        # T->attacker dmg
        T['f_dmg'] = f_dmg(T, A)
        T['f_dps'] = T['f_dmg'] / T['f_dur']
        T['c_dmg'] = c_dmg(T, A)
        T['ttl'] = T['f_dmg'] * T['turn'] + T['c_dmg']

        T['f_dmg_pct'] = T['f_dmg'] / A['hpt']
        T['f_dps_pct'] = T['f_dps'] / A['hpt']
        T['c_dmg_pct'] = T['c_dmg'] / A['hpt']
        T['ttl_pct'] = T['ttl'] / A['hpt']
        T['ttldps_pct'] = (T['ttl'] / T['chg']) / A['hpt']

        # 各種指標
        # 必殺技1サイクルの時間と、相手のHPを何％減らせるか、またそのDPS
        # 通常技のみのDPS
        # 必殺技1発のダメージ％
        # 相手のHPを0にするまでの時間
        A['timer'] = killtime(A, T, 0)
        T['timer'] = killtime(T, A, 0)

        if A['timer'] + 0.5 < T['timer']:
            win += 1
        elif T['timer'] + 0.5 < A['timer']:
            lose += 1
        else:
            draw += 1

    print ("{}\t{}\t{}\t{}\t{}\t{}".format(A['uid'],A['fast'],A['charge'],win,draw,lose))



class Dammy:
    def __init__(self, val, flag):
        self.val = val
        self.flag = flag
a = Dammy(123, True)
b = Dammy(256, False)
sorted([a,b], key=lambda x:x.flag, reverse=False)[0].val




With a as(
select 
rank() over (order by win desc,lose) as rnk,
A.uid as id,C.jp as name,type_1,type_2,
D.jp as fast, f_type,case when B.f_lgcy='TRUE' then '★' else '' end as fL, 
E.jp as charge, c_type,case when B.c_lgcy='TRUE' then '★' else '' end as cL, 
B.cp,B.lv,B.atk,B.def,B.hpt,
win,draw,lose,f_dps,c_pow,chg,ttldps,edr
,F.* 
from simulation_love A 
left join weakness F using(uid)
left join pattern_combat B using(uid,fast,charge,cap_cp,cap_lv)
left join localize_pokemon C using(uid) 
left join localize_fastmove D on A.fast=D.uid 
left join localize_chargemove E on A.charge=E.uid 
--where A.uid !~ 'ETERNATUS'
order by win desc, lose
)
select rnk,id, name,type_1,type_2,fast,f_type,fL,charge,c_type,cL,cp,lv,win,draw,lose,f_dps,c_pow,chg,ttldps,edr,atk,def,hpt
from a
where electric < 1.0
--where 'POISON' in (type_1,type_2)
;



drop function if exists effi(NUMERIC);
create or replace function effi(val NUMERIC)
returns TEXT as $$
DECLARE
    res TEXT;
BEGIN
    case 
        when val >= 2.56 THEN res := '◎';
        when val >= 1.6 THEN res := '○';
        when val <= 0.244140625 then res := '-';
        when val <= 0.390625 then res := '×';
        when val <= 0.625 then res := '▲';
        ELSE res := '';
    END CASE;
    return res;
END
$$ LANGUAGE 'plpgsql';




With a as(
select 
rank() over (order by win desc,lose) as rnk,
A.uid as id,C.jp as name,type_1,type_2,
D.jp as fast, f_type,case when B.f_lgcy='TRUE' then '★' else '' end as fL, 
E.jp as charge, c_type,case when B.c_lgcy='TRUE' then '★' else '' end as cL, 
B.cp,B.lv,B.atk,B.def,B.hpt,
win,draw,lose,f_dps,c_pow,chg,ttldps,edr
,F.* 
from simulation_love A 
left join weakness F using(uid)
left join pattern_combat B using(uid,fast,charge,cap_cp,cap_lv)
left join localize_pokemon C using(uid) 
left join localize_fastmove D on A.fast=D.uid 
left join localize_chargemove E on A.charge=E.uid 
--where A.uid !~ 'ETERNATUS'
order by win desc, lose
)
, b as(select 
row_number() over (partition by id order by win desc,lose) as uidrnk,
rnk,id, name,type_1,type_2,fast,f_type,fL,charge,c_type,cL,cp,lv,win,draw,lose,f_dps,c_pow,chg,ttldps,edr,atk,def,hpt,
effi(normal) as "ノ",
effi(fighting) as "闘",
effi(flying) as "飛",
effi(poison) as "毒",
effi(ground) as "地",
effi(rock) as "岩",
effi(bug) as "虫",
effi(ghost) as "ゴ",
effi(steel) as "鋼",
effi(fire) as "炎",
effi(water) as "水",
effi(grass) as "草",
effi(electric) as "電",
effi(psychic) as "エ",
effi(ice) as "氷",
effi(dragon) as "竜",
effi(dark) as "悪",
effi(fairy) as "妖"
from a
order by rnk
)
select * from b
where uidrnk = 1
;




With a as(
select 
rank() over (order by win desc,lose) as rnk,
A.uid as id,C.jp as name,type_1,type_2,
D.jp as fast, f_type,case when B.f_lgcy='TRUE' then '★' else '' end as fL, 
E.jp as charge, c_type,case when B.c_lgcy='TRUE' then '★' else '' end as cL, 
B.cp,B.lv,B.atk,B.def,B.hpt,
win,draw,lose,f_dps,c_pow,chg,ttldps,edr
,F.* 
from simulation_love A 
left join weakness F using(uid)
left join pattern_combat B using(uid,fast,charge,cap_cp,cap_lv)
left join localize_pokemon C using(uid) 
left join localize_fastmove D on A.fast=D.uid 
left join localize_chargemove E on A.charge=E.uid 
--where A.uid !~ 'ETERNATUS'
order by win desc, lose
)
, b as(select 
row_number() over (partition by id order by win desc,lose) as uidrnk,
rnk,id, name,type_1,type_2,fast,f_type,fL,charge,c_type,cL,cp,lv,win,draw,lose,f_dps,c_pow,chg,ttldps,edr,atk,def,hpt,
effi(normal) as "ノ",
effi(fighting) as "闘",
effi(flying) as "飛",
effi(poison) as "毒",
effi(ground) as "地",
effi(rock) as "岩",
effi(bug) as "虫",
effi(ghost) as "ゴ",
effi(steel) as "鋼",
effi(fire) as "炎",
effi(water) as "水",
effi(grass) as "草",
effi(electric) as "電",
effi(psychic) as "エ",
effi(ice) as "氷",
effi(dragon) as "竜",
effi(dark) as "悪",
effi(fairy) as "妖"
from a
order by rnk
)
select * from b
where uidrnk = 1
;



CREATE VIEW pokemon_love as
select uid from _pokemon where
(uid ~ 'CHARMANDER' or uid ~ 'CHARMELEON' or uid ~ 'CHARIZARD' or uid ~ 'CHARIZARD' or uid ~ 'CLEFAIRY' or uid ~ 'CLEFABLE' or uid ~ 'JIGGLYPUFF' or uid ~ 'WIGGLYTUFF' or uid ~ 'VILEPLUME' or uid ~ 'PARAS' or uid ~ 'PARASECT' or uid ~ 'SLOWPOKE' or uid ~ 'SLOWBRO' or uid ~ 'KRABBY' or uid ~ 'KINGLER' or uid ~ 'VOLTORB' or uid ~ 'ELECTRODE' or uid ~ 'EXEGGCUTE' or uid ~ 'LICKITUNG' or uid ~ 'CHANSEY' or uid ~ 'GOLDEEN' or uid ~ 'SEAKING' or uid ~ 'MR_MIME_NORMAL' or uid ~ 'JYNX' or uid ~ 'MAGMAR' or uid ~ 'MAGIKARP' or uid ~ 'FLAREON' or uid ~ 'PORYGON' or uid ~ 'LEDYBA' or uid ~ 'LEDIAN' or uid ~ 'ARIADOS' or uid ~ 'CLEFFA' or uid ~ 'IGGLYBUFF' or uid ~ 'FLAAFFY' or uid ~ 'HOPPIP' or uid ~ 'YANMA' or uid ~ 'SLOWKING' or uid ~ 'SNUBBULL' or uid ~ 'SCIZOR' or uid ~ 'SLUGMA' or uid ~ 'MAGCARGO' or uid ~ 'CORSOLA' or uid ~ 'OCTILLERY' or uid ~ 'DELIBIRD' or uid ~ 'PORYGON2' or uid ~ 'SMOOCHUM' or uid ~ 'MAGBY' or uid ~ 'MILTANK' or uid ~ 'BLISSEY' or uid ~ 'TORCHIC' or uid ~ 'COMBUSKEN' or uid ~ 'BLAZIKEN' or uid ~ 'WURMPLE' or uid ~ 'WHISMUR' or uid ~ 'SKITTY' or uid ~ 'MEDICHAM' or uid ~ 'CARVANHA' or uid ~ 'CAMERUPT' or uid ~ 'SOLROCK' or uid ~ 'CORPHISH' or uid ~ 'CRAWDAUNT' or uid ~ 'MILOTIC' or uid ~ 'CASTFORM_SUNNY' or uid ~ 'GOREBYSS' or uid ~ 'LUVDISC' or uid ~ 'KRICKETOT' or uid ~ 'KRICKETUNE' or uid ~ 'BURMY_TRASH' or uid ~ 'WORMADAM_TRASH' or uid ~ 'CHERUBI' or uid ~ 'CHERRIM_SUNNY' or uid ~ 'MIME_JR' or uid ~ 'HAPPINY' or uid ~ 'LICKILICKY' or uid ~ 'MAGMORTAR' or uid ~ 'PORYGON_Z' or uid ~ 'ROTOM' or uid ~ 'TEPIG' or uid ~ 'PIGNITE' or uid ~ 'EMBOAR' or uid ~ 'PANSEAR' or uid ~ 'SIMISEAR' or uid ~ 'MUNNA' or uid ~ 'MUSHARNA' or uid ~ 'AUDINO' or uid ~ 'THROH' or uid ~ 'VENIPEDE' or uid ~ 'SCOLIPEDE' or uid ~ 'KROOKODILE' or uid ~ 'DARUMAKA_NORMAL' or uid ~ 'DARMANITAN_STANDARD' or uid ~ 'DWEBBLE' or uid ~ 'CRUSTLE' or uid ~ 'SCRAFTY' or uid ~ 'DEERLING_SPRING' or uid ~ 'DEERLING_AUTUMN' or uid ~ 'ALOMOMOLA' or uid ~ 'SHELMET' or uid ~ 'ACCELGOR' or uid ~ 'DRUDDIGON' or uid ~ 'PAWNIARD' or uid ~ 'BISHARP' or uid ~ 'BRAVIARY' or uid ~ 'HEATMOR' or uid ~ 'FENNEKIN' or uid ~ 'BRAIXEN' or uid ~ 'DELPHOX' or uid ~ 'FLETCHLING' or uid ~ 'FLETCHINDER' or uid ~ 'TALONFLAME' or uid ~ 'SPRITZEE' or uid ~ 'AROMATISSE' or uid ~ 'SYLVEON');

drop view if exists pokemon_love;
CREATE VIEW pokemon_love as
select uid from _pokemon where uid in
('CHARMANDER_NORMAL','CHARMELEON_NORMAL','CHARIZARD_NORMAL','CLEFAIRY','CLEFABLE','JIGGLYPUFF','WIGGLYTUFF','VILEPLUME_NORMAL','PARAS','PARASECT','SLOWPOKE_GALARIAN','SLOWPOKE_NORMAL','SLOWBRO_GALARIAN','SLOWBRO_NORMAL','KRABBY_NORMAL','KINGLER_NORMAL','VOLTORB_HISUIAN','VOLTORB_NORMAL','ELECTRODE_NORMAL','EXEGGCUTE_NORMAL','LICKITUNG','CHANSEY','GOLDEEN','SEAKING','MR_MIME_NORMAL','JYNX','MAGMAR_NORMAL','MAGIKARP_NORMAL','FLAREON','PORYGON_NORMAL','LEDYBA','LEDIAN','ARIADOS','CLEFFA','IGGLYBUFF','FLAAFFY_NORMAL','HOPPIP_NORMAL','YANMA','SLOWKING_GALARIAN','SLOWKING_NORMAL','SNUBBULL_NORMAL','SCIZOR_NORMAL','SLUGMA','MAGCARGO','CORSOLA','OCTILLERY','DELIBIRD_NORMAL','PORYGON2_NORMAL','SMOOCHUM','MAGBY','MILTANK','BLISSEY','TORCHIC_NORMAL','COMBUSKEN_NORMAL','BLAZIKEN_NORMAL','WURMPLE','WHISMUR_NORMAL','SKITTY','MEDICHAM','CARVANHA_NORMAL','CAMERUPT','SOLROCK','CORPHISH','CRAWDAUNT','MILOTIC','CASTFORM_SUNNY','GOREBYSS','LUVDISC','KRICKETOT','KRICKETUNE','BURMY_TRASH','WORMADAM_TRASH','CHERUBI','CHERRIM_SUNNY','MIME_JR','HAPPINY','LICKILICKY','MAGMORTAR_NORMAL','PORYGON_Z_NORMAL','ROTOM_FAN','ROTOM_FROST','ROTOM_HEAT','ROTOM_MOW','ROTOM_NORMAL','ROTOM_WASH','TEPIG','PIGNITE','EMBOAR','PANSEAR','SIMISEAR','MUNNA','MUSHARNA','AUDINO','THROH','VENIPEDE','SCOLIPEDE','KROOKODILE','DARUMAKA_NORMAL','DARMANITAN_STANDARD','DWEBBLE','CRUSTLE','SCRAFTY','DEERLING_AUTUMN','DEERLING_SPRING','ALOMOMOLA','SHELMET','ACCELGOR','DRUDDIGON','PAWNIARD','BISHARP','BRAVIARY','HEATMOR','FENNEKIN','BRAIXEN','DELPHOX','FLETCHLING','FLETCHINDER','TALONFLAME','SPRITZEE','AROMATISSE','SYLVEON','CHARMANDER_SHADOW','CHARMELEON_SHADOW','CHARIZARD_SHADOW','VILEPLUME_SHADOW','SLOWPOKE_GALARIAN_SHADOW','SLOWPOKE_SHADOW','SLOWBRO_GALARIAN_SHADOW','SLOWBRO_SHADOW','KRABBY_SHADOW','KINGLER_SHADOW','VOLTORB_HISUIAN_SHADOW','VOLTORB_SHADOW','ELECTRODE_SHADOW','EXEGGCUTE_SHADOW','MAGMAR_SHADOW','MAGIKARP_SHADOW','PORYGON_SHADOW','FLAAFFY_SHADOW','HOPPIP_SHADOW','SLOWKING_GALARIAN_SHADOW','SLOWKING_SHADOW','SNUBBULL_SHADOW','SCIZOR_SHADOW','DELIBIRD_SHADOW','PORYGON2_SHADOW','TORCHIC_SHADOW','COMBUSKEN_SHADOW','BLAZIKEN_SHADOW','WHISMUR_SHADOW','CARVANHA_SHADOW','MAGMORTAR_SHADOW','PORYGON_Z_SHADOW');



"""





