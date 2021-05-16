#!/var/bin/python 

# pattern_combatテーブルの攻撃の値は、既に対戦補正（x1.3）、STAB、シャドウ補正などが入っている。後必要なのはタイプ補正のみ

import sys
import psycopg2
import psycopg2.extras
import simplejson
import datetime
import decimal
import math
import time

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
    conn = psycopg2.connect("dbname=pokemongo2") 
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
    conn = psycopg2.connect("dbname=pokemongo2") 
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
        return repr((self.uid, self.fast, self.charge, self.ene, self.c_ene, self.hpt))
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
        print(self.mon[0], self.mon[1])
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
            
            print(turn, self.mon[0],mon_0_dmg, self.mon[1],mon_1_dmg)

        # どちらかのHPTが0になったら終了
        # 0になるまでのターンと、その時点で生き残っている方のHPが何％かを返す
        result = sorted(self.mon, key=lambda x:x.primary, reverse=True)
        return{
            'turn': turn,
            'result': result
        }
                



cap = 1500
args = sys.argv
if len(args) > 1:
    cap = args[1]
#print("cap:{}".format(cap))

# db initialize
conn = psycopg2.connect("dbname=pokemongo2") 
cur=conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
query = "select * from pattern_combat where cap='{}';"
cur.execute(query.format(cap))
results = cur.fetchall()
cur.close()

for p1 in results[0:1]:
    #Attackr
    A = dict(p1)
    #print(simplejson.dumps(A))
    win = 0
    draw = 0
    lose = 0
    for p2 in results[11:13]:
        #Target
        T = dict(p2)
        # Simulate
        btl = Combat(A, T)
        result = btl.simulate()
        print(result)




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


"""





