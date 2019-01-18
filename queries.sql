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

