-- マスターリーグのランキング
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
and 'DARK' not in (type_1,type_2) limit 10;

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
where 'ROCK' in (type_1,type_2) limit 10;

