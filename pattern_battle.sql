-- dependency: table "top_iv" 

DROP TABLE IF EXISTS pattern_battle;
CREATE TABLE pattern_battle as

with SETTINGS as(
select 
    max(case when key='sameTypeAttackBonusMultiplier' then value end) as stab,
    max(case when key='shadowPokemonAttackBonusMultiplier' then value end) as shadow_atk,
    max(case when key='shadowPokemonDefenseBonusMultiplier' then value end) as shadow_def
from _battle_settings
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
    (case when C.type in (A.type_1,A.type_2) then SETTINGS.stab else 1.0 end) * C.power * S.atk * (case when A.uid ~ '_SHADOW' then SETTINGS.shadow_atk else 1.0 end) as f_dmg,
    C.duration::numeric / 1000 as f_dur,
    C.energy as f_ene,

    E.uid as charge, E.type as c_type,
    (case when D.legacy then 'TRUE' end) as c_lgcy,
    (case when E.type in (A.type_1,A.type_2) then SETTINGS.stab else 1.0 end) * E.power * S.atk * (case when A.uid ~ '_SHADOW' then SETTINGS.shadow_atk else 1.0 end) as c_dmg,
    E.duration::numeric / 1000 as c_dur,
    E.energy as c_ene,
    S.cap

from _pokemon A 
left join _mon_fast B using(uid) 
left join _mon_charge D using(uid)
left join top_iv S using(uid)
left join _fastmove C on c.uid=b.move 
left join _chargemove E on E.uid=D.move
left join SETTINGS on true
where A.at is not null and C.uid is not null
and C.uid not in ('TRANSFORM')
)
select
    A.uid,type_1,type_2,cp,lv,at,df,hp,
    round(atk,2) as atk,
    round(def,2) as def,
    hpt,
    fast,f_type,f_lgcy,round(f_dmg,2) as f_dmg, round(f_dur,1) as f_dur, f_ene,
    charge,c_type,c_lgcy,round(c_dmg,2) as c_dmg, round(c_dur,1) as c_dur, c_ene,
    round(f_dmg / f_dur, 1) as f_dps,
    round(f_ene / f_dur, 1) as eps,
    round(-(c_ene::numeric / f_ene) * f_dur,1) as chg,
    round((f_dmg / f_dur) * (-(c_ene::numeric / f_ene) * f_dur) + c_dmg,1)  as ttldmg,
    round(((f_dmg / f_dur) * (-(c_ene::numeric / f_ene) * f_dur) + c_dmg) / (-(c_ene::numeric / f_ene) * f_dur + c_dur), 1) as ttldps,
    round(def*hpt) as edr,
    cap
from A
;


select
    A.uid,B.jp,type_1,type_2,
    C.jp,f_type,
    D.jp,c_type,
    f_dps,chg,ttldps,edr
from pattern_battle A
join localize_pokemon B using(uid)
join localize_fastmove C on C.uid=A.fast
join localize_chargemove D on D.uid=A.charge
where
cap='5500'
and f_type='ICE' and c_type='ICE'
order by ttldps desc
;