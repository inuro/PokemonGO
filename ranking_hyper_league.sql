-- ハイパーリーグのランキング
select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique

) A 
join localize_pokemon B on B.uid=A.uid 
where rank<=100;


select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'NORMAL' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'FIGHTING' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'FLYING' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'FLYING' in (type_1,type_2) 
and 'DRAGON' not in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'POISON' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'POISON' in (type_1,type_2) 
and ('DARK' not in (type_1,type_2) or type_2 is null) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'GROUND' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'ROCK' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'BUG' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'GHOST' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'GHOST' in (type_1,type_2) 
and ('DRAGON' not in (type_1,type_2) or type_2 is null) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'STEEL' in (type_1,type_2) limit 10;


select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'FIRE' in (type_1,type_2) limit 10;



select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'WATER' in (type_1,type_2) limit 10;



select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'GRASS' in (type_1,type_2) limit 10;


select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'ELECTRIC' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'PSYCHIC' in (type_1,type_2) limit 10;



select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'ICE' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'DRAGON' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'DARK' in (type_1,type_2) limit 10;

select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'DARK' in (type_1,type_2) 
and ('POISON' not in (type_1,type_2) or type_2 is null) limit 10;


select 
    B.jp,A.* 
from (
    select *, 
    rank() OVER (ORDER BY counter_unique) AS rank
    from win_lose
    where cap='2500'
    order by counter_unique
) A 
join localize_pokemon B on B.uid=A.uid 
where 'FAIRY' in (type_1,type_2) limit 10;


