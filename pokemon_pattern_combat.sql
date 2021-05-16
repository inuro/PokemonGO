with SETTINGS as(
select 
    max(case when key='sameTypeAttackBonusMultiplier' then value end) as stab,
    max(case when key='shadowPokemonAttackBonusMultiplier' then value end) as shadow_atk,
    max(case when key='shadowPokemonDefenseBonusMultiplier' then value end) as shadow_def,
    max(case when key='fastAttackBonusMultiplier' then value end) as fast_mlp,
    max(case when key='chargeAttackBonusMultiplier' then value end) as charge_mlp
from _combat_settings
),
A as(
select
    A.pokemon_id, A.uid, A.type_1, A.type_2, 
    S.cp, S.lv, S.at, S.df, S.hp,
    S.atk * (case when A.uid ~ '_SHADOW' then SETTINGS.shadow_atk else 1.0 end) as atk, 
    S.def * (case when A.uid ~ '_SHADOW' then SETTINGS.shadow_def else 1.0 end) as def, 
    S.hpt,

    C.uid as fast, C.type as f_type,
    (case when B.legacy then 'TRUE' end) as f_lgcy,
    (case when C.type in (A.type_1,A.type_2) then SETTINGS.stab else 1.0 end) * C.power * S.atk * SETTINGS.fast_mlp * (case when A.uid ~ '_SHADOW' then SETTINGS.shadow_atk else 1.0 end) as f_dmg,
    (C.duration + 1) * 0.5 as f_dur,
    C.energy as f_ene,

    E.uid as charge, E.type as c_type,
    (case when D.legacy then 'TRUE' end) as c_lgcy,
    (case when E.type in (A.type_1,A.type_2) then SETTINGS.stab else 1.0 end) * E.power * S.atk * SETTINGS.charge_mlp * (case when A.uid ~ '_SHADOW' then SETTINGS.shadow_atk else 1.0 end) as c_dmg,
    E.energy as c_ene,

    E.buff * (E.attacker_at + E.attacker_df - E.target_at - E.target_df) as buff,

    S.cap

from _pokemon A 
left join _mon_fast B using(uid) 
left join _mon_charge D using(uid)
left join top_iv S using(uid)
left join _fastmove_combat C on c.uid=b.move 
left join _chargemove_combat E on E.uid=D.move
left join SETTINGS on true
where A.at is not null and C.uid is not null
and C.uid not in ('TRANSFORM')
)
, B as (
select
    A.uid,type_1,type_2,cp,lv,at,df,hp,
    round(atk,2) as atk,
    round(def,2) as def,
    hpt,
    fast,f_type,f_lgcy,round(f_dmg,2) as f_dmg, f_dur,f_ene,
    charge,c_type,c_lgcy,round(c_dmg,2) as c_dmg, c_ene,
    round(f_dmg / f_dur, 1) as f_dps,
    round(f_ene / f_dur, 1) as eps,
    ceil(-(c_ene::numeric / f_ene)) as turn,
    ceil(-(c_ene::numeric / f_ene)) * f_dur as chg,
    round((f_dmg * ceil(-(c_ene::numeric / f_ene)) + c_dmg) / (ceil(-(c_ene::numeric / f_ene)) * f_dur), 1) as ttldps,
    round(def*hpt) as edr,
    buff,
    cap
from A
join localize_pokemon C using(uid)
)
select * from B
where true
and cap='2500'
--and uid='STUNFISK'
--and lv > 40
--and c_type='GHOST' and f_type='GHOST'
--and charge in ('ACID_SPRAY','BUBBLE_BEAM','ICY_WIND','SAND_TOMB','LUNGE')
--and fast='THUNDER_SHOCK' and charge='WILD_CHARGE'
--and chg <= 10
--and jp='ライチュウ'
--and jp in ('ハリボーグ','ブリガロン','フシギバナ')
--and edr::numeric >= 20000
--where chg < 10
--order by edr desc, chg, ttldps desc
order by chg, ttldps desc, edr desc 
--order by ttldps desc, edr desc
--order by f_dps desc, ttldps desc, edr desc

--order by chg, ttldps desc
--where 'GRASS' in (f_type)
--order by f_dmg / f_dur desc, f_ene/f_dur desc
--order by ene/dur desc, dmg / dur desc
;
