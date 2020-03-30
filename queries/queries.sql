--OVERALL attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc limit 50;




--Normal attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'NORMAL' in (type_1, type_2) and  c_type='NORMAL' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--Fighting attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'FIGHTING' in (type_1, type_2) and  c_type='FIGHTING' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--Flying attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'FLYING' in (type_1, type_2) and  c_type='FLYING' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--POISON attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'POISON' in (type_1, type_2) and  c_type='POISON' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--GROUND attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'GROUND' in (type_1, type_2) and  c_type='GROUND' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--ROCK attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'ROCK' in (type_1, type_2) and  c_type='ROCK' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--BUG attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'BUG' in (type_1, type_2) and  c_type='BUG' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--GHOST attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'GHOST' in (type_1, type_2) and  c_type='GHOST' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--STEEL attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'STEEL' in (type_1, type_2) and c_type='STEEL' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--FIRE attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'FIRE' in (type_1, type_2) and  c_type='FIRE' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--WATER attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'WATER' in (type_1, type_2) and  c_type='WATER' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--GRASS attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'GRASS' in (type_1, type_2) and  c_type='GRASS' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--ELECTRIC attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'ELECTRIC' in (type_1, type_2) and  c_type='ELECTRIC' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--PSYCHIC attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'PSYCHIC' in (type_1, type_2) and  c_type='PSYCHIC' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--ICE attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'ICE' in (type_1, type_2) and  c_type='ICE' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--DRAGON attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'DRAGON' in (type_1, type_2) and  c_type='DRAGON' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--DARK attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'DARK' in (type_1, type_2) and  c_type='DARK' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;


--FAIRY attacker
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
where 'FAIRY' in (type_1, type_2) and  c_type='FAIRY' 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by dps desc;

-------------------------------------------------------------------------------

--OVERALL tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,null) 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;


--vs NORMAL tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'NORMAL') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs FIGHTING tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'FIGHTING') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs FLYING tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'FLYING') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs POISON tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'POISON') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs GROUND tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'GROUND') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs ROCK tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'ROCK') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;


--vs BUG tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'BUG') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;


--vs GHOST tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'GHOST') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs STEEL tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'STEEL') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;


--vs FIRE tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'FIRE') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs WATER tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'WATER') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs GRASS tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'GRASS') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs ELECTRIC tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'ELECTRIC') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs PSYCHIC tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'PSYCHIC') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs ICE tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'ICE') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs DRAGON tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'DRAGON') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs DARK tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'DARK') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;

--vs FAIRY tank
WITH Q as(
select *
from calc_counter(null,1500,15,15,15,'FAIRY') 
)
select * from Q
where (uid, dps) in (select uid, MAX(dps) from Q group by uid)
order by ac desc limit 50;




With A as(
    select
        f_uid,f_type,f_pow,f_dur,f_ene,c_uid,c_type,c_pow,c_ene
        , round((c_ene::numeric / f_ene),1) * f_dur as chargetime
        , ceil(c_ene::numeric / f_ene) * f_dur as chargetime_int
        ,count(*) as num
    from pokemon_pattern_combat
    group by (f_uid,f_type,f_pow,f_dur,f_ene,c_uid,c_type,c_pow,c_ene)
)
select
    f_uid,B.jp,f_type,f_pow,f_dur,f_ene,
    c_uid,C.jp,c_type,c_pow,c_ene
    ,chargetime,chargetime_int
    ,num
from A
join localize_fastmove B on B.uid=A.f_uid
join localize_chargemove C on C.uid=A.c_uid
order by chargetime;



-- 出が早い技
With A as(
    select
        *
        , round((c_ene::numeric / f_ene),1) * f_dur as chargetime
        , ceil(c_ene::numeric / f_ene) * f_dur as chargetime_int
        , round(f_stab_pow::numeric / f_dur,1) as f_dps
    from pokemon_pattern_combat
    where index in (1,2,3,4,5,6,7,8,9,10,11,13,14,15,23,24,25,26,27,28,29,30,31,32,33,34,37,38,43,44,45,46,47,48,49,50,51,54,55,58,59,60,61,69,70,71,72,73,74,75,76,77,78,86,87,88,89,90,91,92,93,94,95,98,99,100,101,104,105,109,110,111,112,114,116,117,118,119,120,125,126,127,129,131,134,135,136,138,139,140,141,147,148,152,153,154,155,156,157,158,159,160,167,168,170,171,172,179,180,181,182,185,186,191,192,194,195,200,204,211,213,215,218,219,220,221,222,223,224,228,229,230,231,232,239,240,246,247,248,252,253,254,255,256,257,258,259,260,261,262,265,266,268,269,270,271,272,273,274,275,283,285,290,299,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,328,329,330,331,332,336,339,340,341,342,345,346,347,348,349,350,351,351,351,353,354,355,356,359,361,362,363,364,365,366,367,368,369,370,371,372,387,388,389,390,391,392,393,394,395,401,402,403,404,405,406,407,408,409,412,412,412,413,413,417,418,419,420,421,421,422,422,423,423,429,434,435,438,442,443,444,445,449,450,451,452,455,456,457,459,460,461,464,465,466,467,470,471,473,477)
)
select
    --pokemon_uid,
    D.jp, type_1,type_2
    --,f_uid
    ,B.jp,f_type,f_pow,f_dur,f_ene
    --,c_uid
    ,C.jp,c_type,c_pow,c_ene
    ,chargetime,chargetime_int,f_dps
from A
join localize_fastmove B on B.uid=A.f_uid
join localize_chargemove C on C.uid=A.c_uid
join localize_pokemon D on D.uid=A.pokemon_uid
order by chargetime_int, f_dps desc, pokemon_uid;


-- 弱点のチェック
select jp from weakness 
where index in (1,2,3,4,5,6,7,8,9,10,11,13,14,15,23,24,25,26,27,28,29,30,31,32,33,34,37,38,43,44,45,46,47,48,49,50,51,54,55,58,59,60,61,69,70,71,72,73,74,75,76,77,78,86,87,88,89,90,91,92,93,94,95,98,99,100,101,104,105,109,110,111,112,114,116,117,118,119,120,125,126,127,129,131,134,135,136,138,139,140,141,147,148,152,153,154,155,156,157,158,159,160,167,168,170,171,172,179,180,181,182,185,186,191,192,194,195,200,204,211,213,215,218,219,220,221,222,223,224,228,229,230,231,232,239,240,246,247,248,252,253,254,255,256,257,258,259,260,261,262,265,266,268,269,270,271,272,273,274,275,283,285,290,299,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,328,329,330,331,332,336,339,340,341,342,345,346,347,348,349,350,351,351,351,353,354,355,356,359,361,362,363,364,365,366,367,368,369,370,371,372,387,388,389,390,391,392,393,394,395,401,402,403,404,405,406,407,408,409,412,412,412,413,413,417,418,419,420,421,421,422,422,423,423,429,434,435,438,442,443,444,445,449,450,451,452,455,456,457,459,460,461,464,465,466,467,470,471,473,477)
and ground < 1.0
;




-- 特定のポケモンに対するカウンター　
WITH A as(
select 
    A.index,
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('ラグラージ',1500,15,15,15,'マッドショット','だくりゅう') A
join pokemon F on F.uid=A.uid
where A.index in (1,2,3,4,5,6,7,8,9,10,11,13,14,15,23,24,25,26,27,28,29,30,31,32,33,34,37,38,43,44,45,46,47,48,49,50,51,54,55,58,59,60,61,69,70,71,72,73,74,75,76,77,78,86,87,88,89,90,91,92,93,94,95,98,99,100,101,104,105,109,110,111,112,114,116,117,118,119,120,125,126,127,129,131,134,135,136,138,139,140,141,147,148,152,153,154,155,156,157,158,159,160,167,168,170,171,172,179,180,181,182,185,186,191,192,194,195,200,204,211,213,215,218,219,220,221,222,223,224,228,229,230,231,232,239,240,246,247,248,252,253,254,255,256,257,258,259,260,261,262,265,266,268,269,270,271,272,273,274,275,283,285,290,299,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,328,329,330,331,332,336,339,340,341,342,345,346,347,348,349,350,351,351,351,353,354,355,356,359,361,362,363,364,365,366,367,368,369,370,371,372,387,388,389,390,391,392,393,394,395,401,402,403,404,405,406,407,408,409,412,412,412,413,413,417,418,419,420,421,421,422,422,423,423,429,434,435,438,442,443,444,445,449,450,451,452,455,456,457,459,460,461,464,465,466,467,470,471,473,477)
)
select * from A where true 
order by kill/death * kill_b/death_b;



WITH A as(
select 
    A.index,
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('ラグラージ',1500,15,15,15,'マッドショット','だくりゅう') A
join pokemon F on F.uid=A.uid
where A.index in (1,2,3,4,5,6,7,8,9,10,11,13,14,15,23,24,25,26,27,28,29,30,31,32,33,34,37,38,43,44,45,46,47,48,49,50,51,54,55,58,59,60,61,69,70,71,72,73,74,75,76,77,78,86,87,88,89,90,91,92,93,94,95,98,99,100,101,104,105,109,110,111,112,114,116,117,118,119,120,125,126,127,129,131,134,135,136,138,139,140,141,147,148,152,153,154,155,156,157,158,159,160,167,168,170,171,172,179,180,181,182,185,186,191,192,194,195,200,204,211,213,215,218,219,220,221,222,223,224,228,229,230,231,232,239,240,246,247,248,252,253,254,255,256,257,258,259,260,261,262,265,266,268,269,270,271,272,273,274,275,283,285,290,299,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,328,329,330,331,332,336,339,340,341,342,345,346,347,348,349,350,351,351,351,353,354,355,356,359,361,362,363,364,365,366,367,368,369,370,371,372,387,388,389,390,391,392,393,394,395,401,402,403,404,405,406,407,408,409,412,412,412,413,413,417,418,419,420,421,421,422,422,423,423,429,434,435,438,442,443,444,445,449,450,451,452,455,456,457,459,460,461,464,465,466,467,470,471,473,477)
)
select * from A where true 
order by kill/death * kill_b/death_b;



select
    A.index,
    A.jp,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%"
from calc_counter_combat('ラッキー',1500,15,15,15,'POUND','HYPER_BEAM') A
where A.index in (1,2,3,4,5,6,7,8,9,10,11,13,14,15,23,24,25,26,27,28,29,30,31,32,33,34,37,38,43,44,45,46,47,48,49,50,51,54,55,58,59,60,61,69,70,71,72,73,74,75,76,77,78,86,87,88,89,90,91,92,93,94,95,98,99,100,101,104,105,109,110,111,112,114,116,117,118,119,120,125,126,127,129,131,134,135,136,138,139,140,141,147,148,152,153,154,155,156,157,158,159,160,167,168,170,171,172,179,180,181,182,185,186,191,192,194,195,200,204,211,213,215,218,219,220,221,222,223,224,228,229,230,231,232,239,240,246,247,248,252,253,254,255,256,257,258,259,260,261,262,265,266,268,269,270,271,272,273,274,275,283,285,290,299,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,328,329,330,331,332,336,339,340,341,342,345,346,347,348,349,350,351,351,351,353,354,355,356,359,361,362,363,364,365,366,367,368,369,370,371,372,387,388,389,390,391,392,393,394,395,401,402,403,404,405,406,407,408,409,412,412,412,413,413,417,418,419,420,421,421,422,422,423,423,429,434,435,438,442,443,444,445,449,450,451,452,455,456,457,459,460,461,464,465,466,467,470,471,473,477)
order by kill_b;


-- 相手無しの純粋な火力
With A as(
select 
    A.index,
    B.jp,A.type_1,A.type_2,
    E.at,
    C.jp,A.f_type,A.f_stab_pow,
    D.jp,A.c_type,A.c_stab_pow,
    Round((E.at * A.f_stab_pow) / A.f_dur / 10, 1) as f_dps,
    Ceil(A.c_ene::numeric / A.f_ene)*A.f_dur as chg,
    Round((E.at * A.c_stab_pow) / 10, 1) as c_dmg,
    Round(E.df * E.hp / 100) as AC
from pokemon_pattern_combat A
join localize_pokemon B on B.uid=A.pokemon_uid
join localize_fastmove C on C.uid=A.f_uid
join localize_chargemove D on D.uid=A.c_uid
join pokemon E on E.uid=A.pokemon_uid
where A.index in (1,2,3,4,5,6,7,8,9,10,11,13,14,15,23,24,25,26,27,28,29,30,31,32,33,34,37,38,43,44,45,46,47,48,49,50,51,54,55,58,59,60,61,69,70,71,72,73,74,75,76,77,78,86,87,88,89,90,91,92,93,94,95,98,99,100,101,104,105,109,110,111,112,114,116,117,118,119,120,125,126,127,129,131,134,135,136,138,139,140,141,147,148,152,153,154,155,156,157,158,159,160,167,168,170,171,172,179,180,181,182,185,186,191,192,194,195,200,204,211,213,215,218,219,220,221,222,223,224,228,229,230,231,232,239,240,246,247,248,252,253,254,255,256,257,258,259,260,261,262,265,266,268,269,270,271,272,273,274,275,283,285,290,299,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,328,329,330,331,332,336,339,340,341,342,345,346,347,348,349,350,351,351,351,353,354,355,356,359,361,362,363,364,365,366,367,368,369,370,371,372,387,388,389,390,391,392,393,394,395,401,402,403,404,405,406,407,408,409,412,412,412,413,413,417,418,419,420,421,421,422,422,423,423,429,434,435,438,442,443,444,445,449,450,451,452,455,456,457,459,460,461,464,465,466,467,470,471,473,477)
)
select * from A
order by chg, f_dps desc;



-- CPキャップ時点でのHP/AT/DFの計算値 IV=100%
drop view if exists attributes_cap;
create view attributes_cap as 
with a as(
    select 
        B.uid,
        (floor((B.at+15) * (sqrt(B.df+15)) * (sqrt(B.hp+15)) * (A.mlp * A.mlp) / 10))::INTEGER as cp,
        floor((B.hp+15) * A.mlp)::INTEGER as hp,
        floor((B.at+15) * A.mlp)::INTEGER as at,
        floor((B.df+15) * A.mlp)::INTEGER as df
    from cpm A
    join pokemon B on true
), b1 as(
    select 
        *,
        ROW_NUMBER() over (PARTITION by A.uid order by cp desc) rnk,
        1500 as cap
    from A
    where cp <= 1500
)
, b2 as(
    select 
        *,
        ROW_NUMBER() over (PARTITION by A.uid order by cp desc) rnk,
        2500 as cap
    from A
    where cp <= 2500
)
, b3 as(
    select 
        *,
        ROW_NUMBER() over (PARTITION by A.uid order by cp desc) rnk,
        5500 as cap
    from A
    where cp <= 5500
)
select * from b1
where rnk=1
union
select * from b2
where rnk=1
union
select * from b3
where rnk=1
;



-- 相手無しの純粋な火力
With A as(
select 
    A.index,
    B.jp as name, A.type_1,A.type_2,
    E.cp,
    E.at,
    C.jp as fmove, A.f_type, --A.f_stab_pow,
    D.jp as cmove, A.c_type, --A.c_stab_pow,
    Round((E.at * A.f_stab_pow) / A.f_dur / 10, 1) as f_dps,
    Ceil(A.c_ene::numeric / A.f_ene)*A.f_dur as chg,
    Round((E.at * A.c_stab_pow) / 10, 1) as c_dmg,
    Round(E.df * E.hp / 100) as AC
from pokemon_pattern_combat A
join localize_pokemon B on B.uid=A.pokemon_uid
join localize_fastmove C on C.uid=A.f_uid
join localize_chargemove D on D.uid=A.c_uid
join attributes_cap E on E.uid=A.pokemon_uid
where A.index in (1,2,3,4,5,6,7,8,9,10,11,13,14,15,23,24,25,26,27,28,29,30,31,32,33,34,37,38,43,44,45,46,47,48,49,50,51,54,55,58,59,60,61,69,70,71,72,73,74,75,76,77,78,86,87,88,89,90,91,92,93,94,95,98,99,100,101,104,105,109,110,111,112,114,116,117,118,119,120,125,126,127,129,131,134,135,136,138,139,140,141,147,148,152,153,154,155,156,157,158,159,160,167,168,170,171,172,179,180,181,182,185,186,191,192,194,195,200,204,211,213,215,218,219,220,221,222,223,224,228,229,230,231,232,239,240,246,247,248,252,253,254,255,256,257,258,259,260,261,262,265,266,268,269,270,271,272,273,274,275,283,285,290,299,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,328,329,330,331,332,336,339,340,341,342,345,346,347,348,349,350,351,351,351,353,354,355,356,359,361,362,363,364,365,366,367,368,369,370,371,372,387,388,389,390,391,392,393,394,395,401,402,403,404,405,406,407,408,409,412,412,412,413,413,417,418,419,420,421,421,422,422,423,423,429,434,435,438,442,443,444,445,449,450,451,452,455,456,457,459,460,461,464,465,466,467,470,471,473,477)
and E.cap=1500
)
select * from A
where cp > 1400 
and name='ウツボット'
--and chg<=11.0
order by f_dps desc, c_dmg desc, chg;




-- Chargemove性能
select 
    A.uid,
    B.jp as name,
    C.uid as type,
    A.power,
    A.energy,
    round(power::numeric/energy,1) as dpe 
from _chargemove_combat A 
join localize_chargemove B using (uid) 
join _type C on C.index=A.type
order by power::numeric/energy desc, energy;

-- Fastmove性能
With A as(
select 
    A.uid,
    B.jp as name,
    C.uid as type,
    COALESCE(A.power,0) as power,
    COALESCE(A.energy,0) as energy,
    (A.duration * 0.5 + 0.5) as dur,
    COALESCE(round(power::numeric/ (A.duration * 0.5 + 0.5),1), 0) as dps,
    COALESCE(round(energy::numeric/ (A.duration * 0.5 + 0.5),1), 0) as eps
from _fastmove_combat A 
join localize_fastmove B using (uid) 
join _type C on C.index=A.type
order by dps desc, eps desc
)
select *, Round(dps*eps) as score from A 
order by dps*eps desc, eps desc;
where type in ('ELECTRIC');






--　キャップを付けて進化後のCPを計算、ついでに必要な砂と飴
select * from calc_evo('ヒトカゲ,リザードン,118,3,12,6,1500');
--  cp  | lv | evo_cp | evo_lv | evo_hp | evo_at | evo_df | stardust | candy 
-- -----+----+--------+--------+--------+--------+--------+----------+-------
--  364 |  5 |   1465 |     19 |    110 |    136 |    104 |    37600 |    44
-- (1 row)


select * from calc_evo('ミニリュウ,カイリュー,551,13,12,13,2500');
select * from calc_evo('ハクリュー,カイリュー,1120,7,14,11,2500');



--　イーブイ専用進化全パターンチェック
With A as (select 12 as cp, 13 as hp, 2 as at, 4 as df, 1500 as cap)
select 'シャワーズ' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,シャワーズ', cp::text, hp::text, at::text, df::text, 1500)) B on true
union all select 'サンダース' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,サンダース', cp::text, hp::text, at::text, df::text, 1500)) B on true
union all select 'ブースター' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,ブースター', cp::text, hp::text, at::text, df::text, 1500)) B on true
union all select 'エーフィ' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,エーフィ', cp::text, hp::text, at::text, df::text, 1500)) B on true
union all select 'ブラッキー' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,ブラッキー', cp::text, hp::text, at::text, df::text, 1500)) B on true
union all select 'リーフィア' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,リーフィア', cp::text, hp::text, at::text, df::text, 1500)) B on true
union all select 'グレイシア' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,グレイシア', cp::text, hp::text, at::text, df::text, 1500)) B on true
union all select 'シャワーズ' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,シャワーズ', cp::text, hp::text, at::text, df::text, 2500)) B on true
union all select 'サンダース' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,サンダース', cp::text, hp::text, at::text, df::text, 2500)) B on true
union all select 'ブースター' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,ブースター', cp::text, hp::text, at::text, df::text, 2500)) B on true
union all select 'エーフィ' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,エーフィ', cp::text, hp::text, at::text, df::text, 2500)) B on true
union all select 'ブラッキー' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,ブラッキー', cp::text, hp::text, at::text, df::text, 2500)) B on true
union all select 'リーフィア' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,リーフィア', cp::text, hp::text, at::text, df::text, 2500)) B on true
union all select 'グレイシア' as target, B.*, evo_hp*evo_df as ac from A join calc_evo(concat_ws(',', 'イーブイ,グレイシア', cp::text, hp::text, at::text, df::text, 2500)) B on true
;



select
    B.jp,C.jp,D.jp,
    A.win, A.lose,
    A.win_unique,A.lose_unique
from win_lose A
join localize_pokemon B on B.uid=A.pokemon
join localize_fastmove C on C.uid=A.fastmove
join localize_chargemove D on D.uid=A.chargemove
where cap=1500 order by win_unique limit 30;

        at  df  hp  LV
1	    0	15	14	27.5	1497	1860
4096	15	4	0	25.5	1473	1727




SNARL / DARK_PULSE
SNARL: f_stab_pow=6.0
DARK_PULSE: c_stab_pow=96.0

select * from calc_all_IV_pattern('ブラッキー',1500) order by (df*hp) desc;

       iv       |  cp  |  lv  | hp | at | df | overall | hpt | atk | def | total | dust |  ac   
 HP14/AT0/DF15  | 1497 | 27.5 | 14 |  0 | 15 | C       | 161 |  88 | 178 |   427 | 4500 | 28658
 HP3/AT15/DF0   | 1499 |   26 |  3 | 15 |  0 | D       | 149 |  96 | 163 |   408 | 4000 | 24287


 (FLOOR(0.5 * (R1.atk::NUMERIC / opponent_def) * R1.f_stab_pow * R1.f_eff) + 1)::numeric as f_dmg,

Fastmove
(FLOOR(0.5 * (88.0 / 163.0) * 6.0 * 0.625) + 1) = 2
(FLOOR(0.5 * (96.0 / 178.0) * 6.0 * 0.625) + 1) = 2

Chargemove
(FLOOR(0.5 * (88.0 / 163.0) * 96.0 * 0.625) + 1) = 17
(FLOOR(0.5 * (96.0 / 178.0) * 96.0 * 0.625) + 1) = 17

       iv       |  cp  |  lv  | hp | at | df | overall | hpt | atk | def | total | dust |  ac   
 HP14/AT0/DF15  | 1497 | 27.5 | 14 |  0 | 15 | C       | 161 |  88 | 178 |   427 | 4500 | 28658
 HP15/AT0/DF6   | 1500 |   28 | 15 |  0 |  6 | D       | 163 |  89 | 173 |   425 | 4500 | 28199

Fastmove
(FLOOR(0.5 * (88.0 / 173.0) * 6.0 * 0.625) + 1) = 1  (0.50867052023121387283)
(FLOOR(0.5 * (89.0 / 178.0) * 6.0 * 0.625) + 1) = 1  (0.50000000000000000000)

(FLOOR(0.5 * (88.0 / 173.0) * 96.0 * 0.625) + 1)
(FLOOR(0.5 * (89.0 / 178.0) * 96.0 * 0.625) + 1)

こうげき:88/ぼうぎょ:178/HP:161
こうげき:89/ぼうぎょ:173/HP:163

(FLOOR(0.5 * (88.0 / 173.0) * 7.2 * 0.625) + 1)
(FLOOR(0.5 * (89.0 / 178.0) * 7.2 * 0.625) + 1)


count = (c_ene::numeric/f_ene)
chargetime = (c_ene::numeric/f_ene) * f_dur

f_dmg = f_stab_pow * (c_ene::numeric/f_ene)
c_dmg

dps = (f_stab_pow * (c_ene::numeric/f_ene) + c_dmg) / ((c_ene::numeric/f_ene) * f_dur)


With A as(
    select 
    A.*,
    B.hp,B.at,B.df,
    B.hp * B.df as AC,
    c_ene::numeric/f_ene as cnt,
    (c_ene::numeric/f_ene) * f_dur as chgtime,
    (f_stab_pow * (c_ene::numeric/f_ene) + c_stab_pow) as ttldmg,
    (f_stab_pow * (c_ene::numeric/f_ene) + c_stab_pow) / ((c_ene::numeric/f_ene) * f_dur) as dps 
    from pokemon_pattern_combat A 
    join pokemon B on B.uid=A.pokemon_uid
), B as(
    select 
        pokemon_uid,f_uid,c_uid, 
        f_dur,f_ene,f_stab_pow,c_ene,c_stab_pow,
        Round(cnt,1) as cnt,
        Round(chgtime,1) as chgtime,
        Round(ttldmg,1) as ttldmg,
        Round(dps,1) as dps,
        AC,
        Round(dps*AC / 100) as efficiency
    from A
)
select * from B
order by efficiency desc;



 HP14/AT0/DF15 | 1497 | 27.5 | 14 |  0 | 15 | C       | 161 |  88 | 178 |   427 | 4500
 HP15/AT15/DF15 | 1500 | 29.5 | 15 | 15 | 15 | S       | 124 | 129 | 108 |   361 | 5000

(FLOOR(0.5 * (88.0 / 108.0) * 6.0 * 1.0) + 1) = 3
(FLOOR(0.5 * (129.0 / 178.0) * 4.8 * 1.0) + 1) = 2


 HP0/AT15/DF4 | 1473 | 25.5 |  0 | 15 |  4 | D       | 145 |  95 | 164 |   404 | 4000
 HP15/AT15/DF15 | 1500 | 29.5 | 15 | 15 | 15 | S       | 124 | 129 | 108 |   361 | 5000

(FLOOR(0.5 * (95.0 / 108.0) * 6.0 * 1.0) + 1) = 3
(FLOOR(0.5 * (129.0 / 164.0) * 4.8 * 1.0) + 1) = 2




-- 全ポケモンの、キャップ以下での最高パラメータ同志の比較
With A as(
    select * from pokemon where uid !~'_SHADOW' and uid !~ '_PURIFIED' and uid !~ '_FALL_2019' 
    --limit 3
), B as (
    select A.uid, B.*,
    rank() over (
        partition by uid
        order by hpt*def desc, hpt desc, def*atk desc, atk desc, lv, cp desc
    ) rnk
    from A 
    join calc_all_IV_pattern(A.uid,1500) B on true 
)
select * from B where rnk=1
order by hpt*def desc, hpt desc, def*atk desc;




With A as(select distinct pokemon_uid as uid from pokemon_pattern_combat), 
B as (select uid from pokemon where uid !~'_SHADOW' and uid !~ '_PURIFIED' and uid !~ '_FALL_2019') 
select * from A left join B on B.uid=A.uid
where B.uid is null;

With A as(select distinct pokemon_uid as uid from pokemon_pattern_combat), 
B as (select uid from pokemon where uid !~'_SHADOW' and uid !~ '_PURIFIED' and uid !~ '_FALL_2019') 
select * from B left join A on B.uid=A.uid
where A.uid is null;










--　リトレーンCP
With A as(
    select LEAST(15,2+12) as ativ, LEAST(15,2+8) as dfiv,LEAST(15,2+13) as hpiv,puid('ミニリュウ') as uid
)
, B as(select 
    uid, (floor((B.at+ativ) * (sqrt(B.df+dfiv)) * (sqrt(B.hp+hpiv)) * (C.mlp * C.mlp) / 10))::INTEGER as cp, 
    hpiv, ativ, dfiv
from A
join pokemon B using (uid)
join cpm C on C.lv=25
)
select * from B
join calc_evo(concat_ws(',',uid,'ハクリュー',cp,hpiv,ativ,dfiv,1500)) on true;



With A as(
    select LEAST(15,2+15) as ativ, LEAST(15,2+3) as dfiv,LEAST(15,2+4) as hpiv,puid('ミズゴロウ') as uid
)
, B as(select 
    uid, (floor((B.at+ativ) * (sqrt(B.df+dfiv)) * (sqrt(B.hp+hpiv)) * (C.mlp * C.mlp) / 10))::INTEGER as cp, 
    hpiv, ativ, dfiv
from A
join pokemon B using (uid)
join cpm C on C.lv=25
)
select * from B
join calc_evo(concat_ws(',',uid,'ラグラージ',cp,hpiv,ativ,dfiv,2500)) on true;



With A as(
    select LEAST(15,2+5) as ativ, LEAST(15,2+11) as dfiv,LEAST(15,2+1) as hpiv,puid('ラルトス') as uid
)
, B as(select 
    uid, (floor((B.at+ativ) * (sqrt(B.df+dfiv)) * (sqrt(B.hp+hpiv)) * (C.mlp * C.mlp) / 10))::INTEGER as cp, 
    hpiv, ativ, dfiv
from A
join pokemon B using (uid)
join cpm C on C.lv=25
)
select * from B
join calc_evo(concat_ws(',',uid,'サーナイト',cp,hpiv,ativ,dfiv,2500)) on true;



  998 | 13 |   1497 |   19.5 |    134 |    125 |    105 |    25300 |    26
  868 | 11 |   1500 |     19 |    132 |    127 |    104 |    28000 |    32
 1081 | 13 |   1497 |     18 |    133 |    126 |    105 |    18400 |    20
  967 | 12 |   1491 |   18.5 |    137 |    123 |    105 |    23200 |    26
  913 | 11 |   1494 |     18 |    132 |    126 |    105 |    23600 |    28

 1693 | 21 |   2500 |     32 |    170 |    162 |    138 |    92000 |    82
 2028 | 25 |   2495 |   31.5 |    171 |    165 |    133 |    60000 |    52
 1845 | 23 |   2487 |     32 |    171 |    165 |    130 |    80000 |    70
 2243 | 29 |   2494 |   34.5 |    179 |    157 |    139 |    65000 |    64


 2126 | 29 |   2492 |     38 |    154 |    181 |    122 |   122000 |   136
 1143 | 15 |   2497 |   35.5 |    150 |    181 |    126 |   166400 |   160
 2423 | 35 |   2498 |     37 |    151 |    182 |    123 |    32000 |    40




 2145 | 20 |   2467 |     23 |    130 |    172 |    155 |    17000 |    16
 2142 | 20 |   2464 |     23 |    131 |    172 |    155 |    17000 |    16  
 2012 | 20 |   2465 |   24.5 |    130 |    173 |    154 |    27500 |    25
 2108 | 20 |   2477 |   23.5 |    127 |    174 |    157 |    20500 |    19
 2111 | 20 |   2480 |   23.5 |    128 |    174 |    157 |    20500 |    19
 1965 | 19 |   2483 |     24 |    128 |    176 |    155 |    29000 |    26



1353 | 13 |   1457 |     14 |     99 |    133 |    118 |     3200 |     4
 367 |  4 |   1456 |   14.5 |     99 |    134 |    117 |    20400 |    28
 157 |  2 |   1469 |   14.5 |    101 |    132 |    121 |    21600 |    32



With A as(
select 
    B.jp,C.jp,D.jp,
    A.*, 
    rank()over(partition by cap order by win_unique,win) as rnk 
from win_lose A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where cap=1500
)
select * from A where pokemon=puid('コモルー') order by win_unique limit 100;






WITH A as(
select 
    A.index,
    A.uid,
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('ダイノーズ',1500,15,15,15,'スパーク','いわなだれ') A
join pokemon F on F.uid=A.uid
where A.uid in ('ALTARIA','WIGGLYTUFF','SANDSLASH_ALOLA','LUDICOLO','INFERNAPE_NORMAL','RATICATE_ALOLA')
)
select * from A where true 
order by kill/death * kill_b/death_b;

WITH A as(
select 
    A.index,
    A.uid,
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('ナマズン',1500,15,15,15,'マッドショット','MUD_BOMB') A
join pokemon F on F.uid=A.uid
where A.uid in ('ALTARIA','WIGGLYTUFF','SANDSLASH_ALOLA','LUDICOLO','INFERNAPE_NORMAL','RATICATE_ALOLA')
)
select * from A where true 
and kill<death and kill_b<death_b
order by kill/death * kill_b/death_b;

WITH A as(
select 
    A.index,
    A.uid,
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('NOCTOWL',1500,15,15,15,'WING_ATTACK','NIGHT_SHADE') A
join pokemon F on F.uid=A.uid
where A.uid in ('ALTARIA','WIGGLYTUFF','SANDSLASH_ALOLA','LUDICOLO','INFERNAPE_NORMAL','RATICATE_ALOLA')
)
select * from A where true 
and kill<death and kill_b<death_b
order by kill/death * kill_b/death_b;



WITH A as(                                                                                                                 
select 
    A.index,
    A.uid,
    A.jp,
    F.type_1,
    F.type_2,
    A.fastmove, 
    A.f_type, 
    A.chargemove, 
    A.c_type, 
    A.kill, 
    A.death, 
    ROUND(A.kill / A.death * 100,1)||'%' as "%",
    A.kill_b, 
    A.death_b,
    ROUND(A.kill_b / A.death_b * 100,1)||'%' as "%",
    ROW_NUMBER() over (PARTITION by A.jp order by kill/death * kill_b/death_b) rnk
from calc_counter_combat('NOCTOWL',1500,15,15,15,'WING_ATTACK','NIGHT_SHADE') A
join pokemon F on F.uid=A.uid
where A.uid in ('ALTARIA','KINGDRA','WHISCASH','SWAMPERT_NORMAL','POLIWRATH_NORMAL','BIBAREL','NOCTOWL','SWABLU','TOGEKISS','WIGGLYTUFF','NINETALES_ALOLA','SANDSLASH_ALOLA','FROSLASS','MAMOSWINE','WALREIN','ABOMASNOW','SHIFTRY_NORMAL','VENUSAUR_NORMAL','VICTREEBEL_NORMAL','EXEGGUTOR_NORMAL','LUDICOLO','PROBOPASS','AGGRON','BRONZONG','DURANT','MAGNEZONE_NORMAL','MAROWAK_ALOLA','CHARIZARD_NORMAL','BLAZIKEN','INFERNAPE_NORMAL','CAMERUPT','MUK_ALOLA','SKUNTANK','RATICATE_ALOLA','HERACROSS','HAUNTER')
)
select * from A where true 
and kill<death and kill_b<death_b
order by kill/death * kill_b/death_b;



-- all pattern　MAROWAK_ALOLA
select *, ceil(c_ene::numeric/f_ene)*f_dur as charge from pokemon_pattern_combat where pokemon_uid=puid('MAROWAK_ALOLA') order by f_uid, charge;




-- Fusion cup用。対戦相手に対して、通常攻撃のDPS差など
--    where a.pokemon_uid=puid('RATICATE_ALOLA') and a.f_uid=get_move_uid('BITE') and a.c_uid=get_move_uid('HYPER_FANG') 
--    where a.pokemon_uid=puid('KINGDRA') and a.f_uid=get_move_uid('DRAGON_BREATH') and a.c_uid=get_move_uid('OCTAZOOKA')
--    where a.pokemon_uid=puid('ALTARIA') and a.f_uid=get_move_uid('DRAGON_BREATH') and a.c_uid=get_move_uid('SKY_ATTACK')
--    where a.pokemon_uid=puid('PROBOPASS') and a.f_uid=get_move_uid('ROCK_THROW') and a.c_uid=get_move_uid('ROCK_SLIDE')
--    where a.pokemon_uid=puid('SHIFTRY_NORMAL') and a.f_uid=get_move_uid('SNARL') and a.c_uid=get_move_uid('LEAF_BLADE')
--    where a.pokemon_uid=puid('SHIFTRY_NORMAL') and a.f_uid=get_move_uid('SNARL') and a.c_uid=get_move_uid('FOUL_PLAY')
--    where a.pokemon_uid=puid('MAROWAK_ALOLA') and a.f_uid=get_move_uid('FIRE_SPIN') and a.c_uid=get_move_uid('SHADOW_BALL')
with O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    where a.pokemon_uid=puid('MAROWAK_ALOLA') and a.f_uid=get_move_uid('FIRE_SPIN') and a.c_uid=get_move_uid('BONE_CLUB')
    and b.cap=1500
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    --where a.pokemon_uid in ('ALTARIA','KINGDRA','WHISCASH','SWAMPERT_NORMAL','POLIWRATH_NORMAL','BIBAREL','NOCTOWL','SWABLU','TOGEKISS','WIGGLYTUFF','NINETALES_ALOLA','SANDSLASH_ALOLA','FROSLASS','MAMOSWINE','WALREIN','ABOMASNOW','SHIFTRY_NORMAL','VENUSAUR_NORMAL','VICTREEBEL_NORMAL','EXEGGUTOR_NORMAL','LUDICOLO','PROBOPASS','AGGRON','BRONZONG','DURANT','MAGNEZONE_NORMAL','MAROWAK_ALOLA','CHARIZARD_NORMAL','BLAZIKEN','INFERNAPE_NORMAL','CAMERUPT','MUK_ALOLA','SKUNTANK','RATICATE_ALOLA','HERACROSS','HAUNTER')
    where a.pokemon_uid in ('ALTARIA','WIGGLYTUFF','SANDSLASH_ALOLA','LUDICOLO','INFERNAPE_NORMAL','RATICATE_ALOLA')
    and b.cap=1500
), B as(
    select *,
    Floor(0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,f_uid,c_uid,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg
    from B
)
select *
, Round(f_dps / o_f_dps, 1) as f_ratio
from C
where true
and kill2 < death1
--and f_dps > o_f_dps
--and kill2 < death0
order by f_dps / o_f_dps desc;



with O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    where a.pokemon_uid=puid('シュバルゴ') and a.f_uid=get_move_uid('カウンター') and a.c_uid=get_move_uid('ドリルライナー')
    and b.cap=1500
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    where a.pokemon_uid in ('ALTARIA','KINGDRA','WHISCASH','SWAMPERT_NORMAL','POLIWRATH_NORMAL','BIBAREL','NOCTOWL','SWABLU','TOGEKISS','WIGGLYTUFF','NINETALES_ALOLA','SANDSLASH_ALOLA','FROSLASS','MAMOSWINE','WALREIN','ABOMASNOW','SHIFTRY_NORMAL','VENUSAUR_NORMAL','VICTREEBEL_NORMAL','EXEGGUTOR_NORMAL','LUDICOLO','PROBOPASS','AGGRON','BRONZONG','DURANT','MAGNEZONE_NORMAL','MAROWAK_ALOLA','CHARIZARD_NORMAL','BLAZIKEN','INFERNAPE_NORMAL','CAMERUPT','MUK_ALOLA','SKUNTANK','RATICATE_ALOLA','HERACROSS','HAUNTER')
    --where a.pokemon_uid in ('ALTARIA','WIGGLYTUFF','SANDSLASH_ALOLA','LUDICOLO','INFERNAPE_NORMAL','RATICATE_ALOLA')
    and b.cap=1500
), B as(
    select *,
    Floor(0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,f_uid,c_uid,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg
    from B
)
select *
, Round(f_dps / o_f_dps, 1) as f_ratio
from C
where true
and kill2 < death1
--and f_dps > o_f_dps
--and kill2 < death0
order by f_dps / o_f_dps desc;




With A as(
select 
    B.jp,C.jp,D.jp,
    A.*, 
    rank()over(partition by cap order by win_unique,win) as rnk 
from win_lose A 
join localize_pokemon B on B.uid=A.pokemon 
join localize_fastmove C on C.uid=A.fastmove 
join localize_chargemove D on D.uid=A.chargemove 
where cap=1500
    and a.pokemon in ('ALTARIA','KINGDRA','WHISCASH','SWAMPERT_NORMAL','POLIWRATH_NORMAL','BIBAREL','NOCTOWL','SWABLU','TOGEKISS','WIGGLYTUFF','NINETALES_ALOLA','SANDSLASH_ALOLA','FROSLASS','MAMOSWINE','WALREIN','ABOMASNOW','SHIFTRY_NORMAL','VENUSAUR_NORMAL','VICTREEBEL_NORMAL','EXEGGUTOR_NORMAL','LUDICOLO','PROBOPASS','AGGRON','BRONZONG','DURANT','MAGNEZONE_NORMAL','MAROWAK_ALOLA','CHARIZARD_NORMAL','BLAZIKEN','INFERNAPE_NORMAL','CAMERUPT','MUK_ALOLA','SKUNTANK','RATICATE_ALOLA','HERACROSS','HAUNTER')

)
select * from A order by win_unique limit 100;







with O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    where a.pokemon_uid=puid('RATICATE_ALOLA') and a.f_uid=get_move_uid('BITE') and a.c_uid=get_move_uid('HYPER_FANG')
    and b.cap=1500
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    where a.pokemon_uid in ('ALTARIA','KINGDRA','WHISCASH','SWAMPERT_NORMAL','POLIWRATH_NORMAL','BIBAREL','NOCTOWL','SWABLU','TOGEKISS','WIGGLYTUFF','NINETALES_ALOLA','SANDSLASH_ALOLA','FROSLASS','MAMOSWINE','WALREIN','ABOMASNOW','SHIFTRY_NORMAL','VENUSAUR_NORMAL','VICTREEBEL_NORMAL','EXEGGUTOR_NORMAL','LUDICOLO','PROBOPASS','AGGRON','BRONZONG','DURANT','MAGNEZONE_NORMAL','MAROWAK_ALOLA','CHARIZARD_NORMAL','BLAZIKEN','INFERNAPE_NORMAL','CAMERUPT','MUK_ALOLA','SKUNTANK','RATICATE_ALOLA','HERACROSS','HAUNTER')
    --where a.pokemon_uid in ('ALTARIA','WIGGLYTUFF','SANDSLASH_ALOLA','LUDICOLO','INFERNAPE_NORMAL','RATICATE_ALOLA')
    and b.cap=1500
), B as(
    select *,
    Floor(0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,f_uid,c_uid,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg
    from B
)
select *
, Round(f_dps / o_f_dps, 1) as f_ratio
from C
where true
--and kill2 < death1
--and f_dps > o_f_dps
--and kill2 < death0
order by f_dps / o_f_dps desc;



--    where a.pokemon_uid=puid('RATICATE_ALOLA') and a.f_uid=get_move_uid('BITE') and a.c_uid=get_move_uid('HYPER_FANG')
--    where a.pokemon_uid=puid('ALTARIA') and a.f_uid=get_move_uid('DRAGON_BREATH') and a.c_uid=get_move_uid('SKY_ATTACK')
--    where a.pokemon_uid=puid('PROBOPASS') and a.f_uid=get_move_uid('ROCK_THROW') and a.c_uid=get_move_uid('THUNDERBOLT')
--    where a.pokemon_uid=puid('WHISCASH') and a.f_uid=get_move_uid('MUD_SHOT') and a.c_uid=get_move_uid('MUD_BOMB')
--    where a.pokemon_uid=puid('LUDICOLO') and a.f_uid=get_move_uid('RAZOR_LEAF') and a.c_uid=get_move_uid('ICE_BEAM')
--    where a.pokemon_uid=puid('SHIFTRY_NORMAL') and a.f_uid=get_move_uid('RAZOR_LEAF') and a.c_uid=get_move_uid('FOUL_PLAY')
--    where a.pokemon_uid=puid('MUK_ALOLA') and a.f_uid=get_move_uid('BITE') and a.c_uid=get_move_uid('DARK_PULSE')
--    where a.pokemon_uid=puid('NOCTOWL') and a.f_uid=get_move_uid('WING_ATTACK') and a.c_uid=get_move_uid('SKY_ATTACK')
--    where a.pokemon_uid=puid('WALREIN') and a.f_uid=get_move_uid('FROST_BREATH') and a.c_uid=get_move_uid('BLIZZARD')
--    where a.pokemon_uid=puid('BRONZONG') and a.f_uid=get_move_uid('CONFUSION') and a.c_uid=get_move_uid('BULLDOZE')
-- ゴウカザル                    | いわくだき     | インファイト     | INFERNAPE_NORMAL  | ROCK_SMASH    | CLOSE_COMBAT   |   4.7 |     2.5 |     1.9
--    where a.pokemon_uid=puid('INFERNAPE_NORMAL') and a.f_uid=get_move_uid('ROCK_SMASH') and a.c_uid=get_move_uid('CLOSE_COMBAT')
 フシギバナ                    | はっぱカッター | ハードプラント   | VENUSAUR_NORMAL   | RAZOR_LEAF    | FRENZY_PLANT    |   4.2 |     2.2 |     1.9
    where a.pokemon_uid=puid('WIGGLYTUFF') and a.f_uid=get_move_uid('CHARM') and a.c_uid=get_move_uid('PLAY_ROUGH')

with O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    where a.pokemon_uid=puid('LUDICOLO') and a.f_uid=get_move_uid('RAZOR_LEAF') and a.c_uid=get_move_uid('ICE_BEAM')
    and b.cap=1500
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    join localize_pokemon X on X.uid=a.pokemon_uid
    join fusion_cup Y on Y.en=X.en
    --where a.pokemon_uid in ('ALTARIA','KINGDRA','WHISCASH','SWAMPERT_NORMAL','POLIWRATH_NORMAL','BIBAREL','NOCTOWL','SWABLU','TOGEKISS','WIGGLYTUFF','NINETALES_ALOLA','SANDSLASH_ALOLA','FROSLASS','MAMOSWINE','WALREIN','ABOMASNOW','SHIFTRY_NORMAL','VENUSAUR_NORMAL','VICTREEBEL_NORMAL','EXEGGUTOR_NORMAL','LUDICOLO','PROBOPASS','AGGRON','BRONZONG','DURANT','MAGNEZONE_NORMAL','MAROWAK_ALOLA','CHARIZARD_NORMAL','BLAZIKEN','INFERNAPE_NORMAL','CAMERUPT','MUK_ALOLA','SKUNTANK','RATICATE_ALOLA','HERACROSS','HAUNTER')
    --where a.pokemon_uid in ('ALTARIA','WIGGLYTUFF','SANDSLASH_ALOLA','LUDICOLO','INFERNAPE_NORMAL','RATICATE_ALOLA')
    and b.cap=1500
), B as(
    select *,
    Floor(0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,f_uid,c_uid,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg
    from B
)
select 
--D.jp,E.jp,F.jp,
--pokemon_uid,f_uid,c_uid,
c.*,
f_dps,o_f_dps, Round(f_dps / o_f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid
join localize_fastmove E on E.uid=C.f_uid
join localize_chargemove F on F.uid=C.c_uid
where true
--and kill2 < death1
and f_dps > o_f_dps
--and kill2 < death0
order by f_dps / o_f_dps desc;






--    where a.pokemon_uid=puid('TOGEKISS') and a.f_uid=get_move_uid('CHARM') and a.c_uid=get_move_uid('DAZZLING_GLEAM')
--    where a.pokemon_uid=puid('WIGGLYTUFF') and a.f_uid=get_move_uid('CHARM') and a.c_uid=get_move_uid('PLAY_ROUGH')
--    where a.pokemon_uid=puid('NINETALES_ALOLA') and a.f_uid=get_move_uid('CHARM') and a.c_uid=get_move_uid('DAZZLING_GLEAM')
--    where a.pokemon_uid=puid('SHIFTRY_NORMAL') and a.f_uid=get_move_uid('RAZOR_LEAF') and a.c_uid=get_move_uid('FOUL_PLAY')
with O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    where a.pokemon_uid=puid('BLAZIKEN') and a.f_uid=get_move_uid('COUNTER') and a.c_uid=get_move_uid('BRAVE_BIRD')
    and b.cap=1500
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    where a.pokemon_uid in ('ALTARIA','KINGDRA','WHISCASH','SWAMPERT_NORMAL','POLIWRATH_NORMAL','BIBAREL','NOCTOWL','SWABLU','TOGEKISS','WIGGLYTUFF','NINETALES_ALOLA','SANDSLASH_ALOLA','FROSLASS','MAMOSWINE','WALREIN','ABOMASNOW','SHIFTRY_NORMAL','VENUSAUR_NORMAL','VICTREEBEL_NORMAL','EXEGGUTOR_NORMAL','LUDICOLO','PROBOPASS','AGGRON','BRONZONG','DURANT','MAGNEZONE_NORMAL','MAROWAK_ALOLA','CHARIZARD_NORMAL','BLAZIKEN','INFERNAPE_NORMAL','CAMERUPT','MUK_ALOLA','SKUNTANK','RATICATE_ALOLA','HERACROSS','HAUNTER')
    --where a.pokemon_uid in ('ALTARIA','WIGGLYTUFF','SANDSLASH_ALOLA','LUDICOLO','INFERNAPE_NORMAL','RATICATE_ALOLA')
    and b.cap=1500
), B as(
    select *,
    Floor(0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,f_uid,c_uid,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg
    from B
)
select 
D.jp,E.jp,F.jp,
pokemon_uid,f_uid,c_uid,
f_dps,o_f_dps, Round(f_dps / o_f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid
join localize_fastmove E on E.uid=C.f_uid
join localize_chargemove F on F.uid=C.c_uid
where true
--and kill2 < death1
and f_dps > o_f_dps
--and kill2 < death0
order by f_dps / o_f_dps desc;


--    where a.pokemon_uid=puid('BLAZIKEN') and a.f_uid=get_move_uid('COUNTER') and a.c_uid=get_move_uid('BRAVE_BIRD')
--    where a.pokemon_uid=puid('BLAZIKEN') and a.f_uid=get_move_uid('COUNTER') and a.c_uid=get_move_uid('BLAST_BURN')

with O as(
    select 
    a.type_1 as o_type_1,
    a.type_2 as o_type_2,
    b.atk as o_atk,
    b.def as o_def,
    b.hpt as o_hpt,
    a.f_uid as o_f_uid,
    a.c_uid as o_c_uid,
    a.f_type as o_f_type,
    a.f_stab_pow as o_f_stab_pow,
    a.f_dur as o_f_dur,
    a.f_ene as o_f_ene,
    a.c_type as o_c_type,
    a.c_stab_pow as o_c_stab_pow,
    a.c_ene as o_c_ene
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    where a.pokemon_uid=puid('BRONZONG') and a.f_uid=get_move_uid('CONFUSION') and a.c_uid=get_move_uid('BULLDOZE')
    and b.cap=1500
), A as(
    select 
    *,
    calc_weakness(f_type, o_type_1, o_type_2) as f_eff,
    calc_weakness(c_type, o_type_1, o_type_2) as c_eff,
    calc_weakness(o_f_type, type_1, type_2) as o_f_eff,
    calc_weakness(o_c_type, type_1, type_2) as o_c_eff
    from pokemon_pattern_combat a
    join top_iv b on b.uid=a.pokemon_uid
    join O on true
    where a.pokemon_uid in ('ALTARIA','KINGDRA','WHISCASH','SWAMPERT_NORMAL','POLIWRATH_NORMAL','BIBAREL','NOCTOWL','SWABLU','TOGEKISS','WIGGLYTUFF','NINETALES_ALOLA','SANDSLASH_ALOLA','FROSLASS','MAMOSWINE','WALREIN','ABOMASNOW','SHIFTRY_NORMAL','VENUSAUR_NORMAL','VICTREEBEL_NORMAL','EXEGGUTOR_NORMAL','LUDICOLO','PROBOPASS','AGGRON','BRONZONG','DURANT','MAGNEZONE_NORMAL','MAROWAK_ALOLA','CHARIZARD_NORMAL','BLAZIKEN','INFERNAPE_NORMAL','CAMERUPT','MUK_ALOLA','SKUNTANK','RATICATE_ALOLA','HERACROSS','HAUNTER')
    --where a.pokemon_uid in ('ALTARIA','WIGGLYTUFF','SANDSLASH_ALOLA','LUDICOLO','INFERNAPE_NORMAL','RATICATE_ALOLA')
    and b.cap=1500
), B as(
    select *,
    Floor(0.5 * f_stab_pow * atk * f_eff / o_def) + 1 as f_dmg,
    Floor(0.5 * c_stab_pow * atk * c_eff / o_def) + 1 as c_dmg,
    Floor(0.5 * o_f_stab_pow * o_atk * o_f_eff / def) + 1 as o_f_dmg,
    Floor(0.5 * o_c_stab_pow * o_atk * o_c_eff / def) + 1 as o_c_dmg
    from A
), C as(
    select
    pokemon_uid,f_uid,c_uid,
    --f_dmg,c_dmg,o_f_dmg,o_c_dmg,
    Round(100 * (f_dmg::numeric / f_dur) / o_hpt, 1) as f_dps,
    Ceil(c_ene::numeric / f_ene) * f_dur as charge,
    Round(100 * (Ceil(c_ene::numeric / f_ene) * f_dmg) / o_hpt, 1) as chg_dmg,
    Round(100 * c_dmg::numeric / o_hpt, 1) as c_dmg,
    Round(100 * (c_dmg::numeric + (Ceil(c_ene::numeric / f_ene) * f_dmg)) / o_hpt, 1) as cycle_dmg,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill0,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 0) as death0,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 1) as kill1,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 1) as death1,
    calc_killtime_combat(o_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill2,
    calc_killtime_combat(hpt, o_f_dmg, o_f_uid, o_c_dmg, o_c_uid, 2) as death2,

    Round(100 * (o_f_dmg::numeric / o_f_dur) / hpt, 1) as o_f_dps,
    Ceil(o_c_ene::numeric / o_f_ene) * o_f_dur as o_charge,
    Round(100 * (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg) / hpt, 1) as o_chg_dmg,
    Round(100 * o_c_dmg::numeric / hpt, 1) as o_c_dmg,
    Round(100 * (o_c_dmg::numeric + (Ceil(o_c_ene::numeric / o_f_ene) * o_f_dmg)) / hpt, 1) as o_cycle_dmg
    from B
)
select 
--D.jp,E.jp,F.jp,
--pokemon_uid,f_uid,c_uid,
C.*,
f_dps,o_f_dps, Round(f_dps / o_f_dps, 1) as f_ratio
from C 
join localize_pokemon D on D.uid=C.pokemon_uid
join localize_fastmove E on E.uid=C.f_uid
join localize_chargemove F on F.uid=C.c_uid
where true
and kill2 < death1
--and f_dps > o_f_dps
--and kill2 < death0
order by f_dps / o_f_dps desc;



With A as(
    select * from calc_all_iv_pattern('RHYHORN_NORMAL',660) 
), B as(
    select A.hp as hp, A.at as at, A.df as df, * from A, calc_evo(concat_ws(',','サイホーン,ドサイドン,660',A.hp,A.at,A.df))
)
select *
--iv,cp,lv,hp,at,df 
from A 
join  on true;

with a as(
select * from calc_all_iv_pattern('RHYPERIOR_NORMAL',1500) order by lv desc, hp+at+df;
)

with a as(
select * from calc_all_iv_pattern('RHYPERIOR_NORMAL',1500)
)select calc_cp(concat_ws(',','サイホーン',lv,hp,at,df)), iv,cp,at,df,hp from a;

with a as(
select * from calc_all_iv_pattern('RHYPERIOR_NORMAL',1500)
)select iv, A.cp,B.cp,A.lv,A.hp,A.at,A.df from a, calc_cp(concat_ws(',','サイホーン',lv,hp,at,df)) b
order by b.cp;


-- こごえるかぜ の使い手
With a as(
select
    ceil(c_ene::numeric/f_ene)*f_dur as chg,
    floor(C.atk * c_stab_pow * (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end)) as c_pow,
    floor((C.atk*f_stab_pow * (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end))*ceil(c_ene::numeric/f_ene)) as f_pow,
    round(((C.atk*f_stab_pow * (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end))*ceil(c_ene::numeric/f_ene) + C.atk * c_stab_pow * (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end))/(ceil(c_ene::numeric/f_ene)*f_dur), 1) as dps,
    C.cp,round(C.atk * (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end)) as atk,round(C.def / (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end)) as def,C.hpt,
    A.pokemon_uid,B.jp, 
    A.f_uid,B2.jp,
    A.c_uid,B3.jp,
    f_stab_pow,c_stab_pow
from pokemon_pattern_combat A 
join localize_pokemon B on B.uid=A.pokemon_uid 
join localize_fastmove B2 on B2.uid=A.f_uid 
join localize_chargemove B3 on B3.uid=A.c_uid 
join top_iv C on C.uid=A.pokemon_uid and C.cap=1500 
where c_uid in ('ICY_WIND') and pokemon_uid not in (select uid from _not_yet) 
)
select * from A where cp>1200
order by dps desc;

-- 100%バフ・デバフの使い手
With a as(
select
    ceil(c_ene::numeric/f_ene)*f_dur as chg,
    floor(C.atk * c_stab_pow * (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end)) as c_pow,
    floor((C.atk*f_stab_pow * (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end))*ceil(c_ene::numeric/f_ene)) as f_pow,
    round(((C.atk*f_stab_pow * (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end))*ceil(c_ene::numeric/f_ene) + C.atk * c_stab_pow * (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end))/(ceil(c_ene::numeric/f_ene)*f_dur), 1) as dps,
    C.cp,round(C.atk * (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end)) as atk,round(C.def / (case when A.pokemon_uid~'_SHADOW' then 1.2 else 1.0 end)) as def,C.hpt,
    A.pokemon_uid,B.jp, 
    A.f_uid,B2.jp,
    A.c_uid,B3.jp,
    f_stab_pow,c_stab_pow
from pokemon_pattern_combat A 
join localize_pokemon B on B.uid=A.pokemon_uid 
join localize_fastmove B2 on B2.uid=A.f_uid 
join localize_chargemove B3 on B3.uid=A.c_uid 
join top_iv C on C.uid=A.pokemon_uid and C.cap=1500 
where c_uid in ('POWER_UP_PUNCH','SKULL_BASH','ACID_SPRAY','MUDDY_WATER','BUBBLE_BEAM','ICY_WIND','SAND_TOMB') and pokemon_uid not in (select uid from _not_yet) 
)
select * from A where cp>1200
order by dps desc;

