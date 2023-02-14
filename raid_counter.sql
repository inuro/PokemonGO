with T as(
select 
    type_1, type_2
from _pokemon where uid=puid('イベルタル')
)
select 
B.jp,
A.uid, A.type_1, A.type_2, A.cp, A.lv, A.fast, A.f_type,A.charge, A.c_type,edr,
--F1.*, F2.*, C1.*, C2.*,
--F1.mlp * COALESCE(F2.mlp, 1.0) as f_mlp,
--C1.mlp * COALESCE(C2.mlp, 1.0) as c_mlp,
round(( (F1.mlp * COALESCE(F2.mlp, 1.0)) * f_pow * ceil(-(c_ene::numeric / f_ene)) + (C1.mlp * COALESCE(C2.mlp, 1.0)) * c_pow) / (ceil(-(c_ene::numeric / f_ene)) * f_dur), 1) as finaldps
from pattern_battle A 
left join T on true
left join _effectiveness F1 on F1.attacker = A.f_type and F1.defender = T.type_1
left join _effectiveness F2 on F2.attacker = A.f_type and F2.defender = T.type_2
left join _effectiveness C1 on C1.attacker = A.c_type and C1.defender = T.type_1
left join _effectiveness C2 on C2.attacker = A.c_type and C2.defender = T.type_2
left join localize_pokemon B using(uid)
where cap_cp=10000 
--and A.uid !~ '_SHADOW$'
order by finaldps desc;

