With A as(
    select
        BB.uid as f, 
        BB.type as f_type,
        BB.power as f_pow,
        (BB.duration + 1)*0.5 as f_dur,
        BB.energy as f_ene,
        CC.uid as c,
        CC.type as c_type,
        CC.power as c_pow,
        CC.energy as c_ene,
        CC.buff as buff,
        CC.target_at as t_at,
        CC.target_df as t_df,
        CC.attacker_at as a_at,
        CC.attacker_df as a_df,
        count(*) as cnt
    from _pokemon A 
    left join _mon_fast B using(uid) 
    left join _mon_charge C using(uid)
    left join _fastmove_combat BB on BB.uid=B.move 
    left join _chargemove_combat CC on CC.uid=C.move
    where BB.energy > 0
    group by BB.uid,BB.type,BB.power,BB.duration,BB.energy,CC.uid,CC.type,CC.power,CC.energy,CC.buff,CC.target_at,CC.target_df,CC.attacker_at,CC.attacker_df
), B as(
    select 
        *, 
        (f_pow / f_dur) as f_dps,
        (f_ene / f_dur) as eps,
        ceil(-(c_ene::numeric / f_ene)) as turn,
        ceil(-(c_ene::numeric / f_ene)) * f_dur as chg,
        (f_pow * ceil(-(c_ene::numeric / f_ene)) + c_pow) / (ceil(-(c_ene::numeric / f_ene)) * f_dur) as ttldps
    from A
)
select 
*
from B
--where c_type in ('FIRE')
where buff = 0 or t_at < 0 or t_df < 0 or a_at > 0 or a_df > 0
--order by ttldps desc;
order by chg, ttldps desc;

select * from _pokemon A 
left join _mon_fast B using(uid) 
left join _mon_charge C using(uid)
left join localize_pokemon D using(uid)
where B.move = 'SHADOW_CLAW' and C.move='SURF'
;

