-- dependency: table "top_iv" 

DROP TABLE IF EXISTS pattern_combat;
CREATE TABLE pattern_combat as
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
    S.atk * (case when A.uid ~ '_SHADOW$' then SETTINGS.shadow_atk else 1.0 end) as atk, 
    S.def * (case when A.uid ~ '_SHADOW$' then SETTINGS.shadow_def else 1.0 end) as def, 
    S.hpt,

    C.uid as fast, C.type as f_type,
    (case when B.legacy then 'TRUE' end) as f_lgcy,
    (case when C.type in (A.type_1,A.type_2) then SETTINGS.stab else 1.0 end) * C.power * S.atk * SETTINGS.fast_mlp * (case when A.uid ~ '_SHADOW$' then SETTINGS.shadow_atk else 1.0 end) as f_dmg,
    (C.duration + 1) * 0.5 as f_dur,
    C.energy as f_ene,

    E.uid as charge, E.type as c_type,
    (case when D.legacy then 'TRUE' end) as c_lgcy,
    (case when E.type in (A.type_1,A.type_2) then SETTINGS.stab else 1.0 end) * E.power * S.atk * SETTINGS.charge_mlp * (case when A.uid ~ '_SHADOW$' then SETTINGS.shadow_atk else 1.0 end) as c_dmg,
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
select
    A.uid,type_1,type_2,cp,lv,at,df,hp,
    round(atk,2) as atk,
    round(def,2) as def,
    hpt,
    fast,f_type,f_lgcy,round(f_dmg,2) as f_pow, f_dur,f_ene,
    charge,c_type,c_lgcy,round(c_dmg,2) as c_pow, c_ene,
    round(f_dmg / f_dur, 1) as f_dps,
    round(f_ene / f_dur, 1) as eps,
    ceil(-(c_ene::numeric / f_ene)) as turn,
    ceil(-(c_ene::numeric / f_ene)) * f_dur as chg,
    round((f_dmg * ceil(-(c_ene::numeric / f_ene)) + c_dmg) / (ceil(-(c_ene::numeric / f_ene)) * f_dur), 1) as ttldps,
    round(def*hpt) as edr,
    buff,
    cap
from A
;

-- select B.jp,A.uid,type_1,type_2,cp,lv,at,df,hp,atk,def,hpt,fast,f_type,f_lgcy,f_dmg,f_dur,charge,c_type,c_lgcy,eps,f_dps,c_dmg,chg,ttldps,edr,buff from f_c_patten_combat A left join localize_pokemon B using(uid) where cap='2500' order by chg, ttldps desc, edr desc;

select 
    B.jp,type_1,type_2,C.jp,f_type,f_lgcy,D.jp,c_type,c_lgcy,
--    A.uid,type_1,type_2,fast,f_type,f_lgcy,charge,c_type,c_lgcy,
    cp,lv,
--    at,df,hp,
    atk,def,hpt,
    f_dmg,f_dur,
    eps,f_dps,c_dmg,chg,ttldps,edr,buff 
from pattern_combat A 
left join localize_pokemon B using(uid) 
left join localize_fastmove C on C.uid=A.fast
left join localize_chargemove D on D.uid=A.charge
where cap=1500 and shield=1
order by chg, ttldps desc, edr desc
;

-- f_dpsの高い順
select distinct
    B.jp,type_1,type_2,C.jp,f_type,f_lgcy,
--    A.uid,type_1,type_2,fast,f_type,f_lgcy,charge,c_type,c_lgcy,
    cp,lv,
--    at,df,hp,
    atk,def,hpt,
    f_dmg,f_dur,
    eps,f_dps,edr, round(f_dps*edr / 100000) 
from pattern_combat A 
left join localize_pokemon B using(uid) 
left join localize_fastmove C on C.uid=A.fast
where cap=1500 and shield=1 and round(f_dps*edr / 100000) > 240
order by f_dps desc, edr desc;

