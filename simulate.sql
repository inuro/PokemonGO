-- simulate all




select
    *
from (select pokemon_uid, f_uid, c_uid from pokemon_pattern_combat where pokemon_uid='ABRA') A 
join (select pokemon_uid, f_uid, c_uid from pokemon_pattern_combat where pokemon_uid='ABSOL') B on true;


EXPLAIN ANALYZE
select
    *
from (select pokemon_uid, f_uid, c_uid from pokemon_pattern_combat) A 
join (select pokemon_uid, f_uid, c_uid from pokemon_pattern_combat) B on true;

                                                                         QUERY PLAN                                                                          
-------------------------------------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=0.00..197715.25 rows=15800625 width=56) (actual time=0.022..3290.224 rows=15800625 loops=1)
   ->  Seq Scan on pokemon_pattern_combat  (cost=0.00..98.75 rows=3975 width=28) (actual time=0.011..1.269 rows=3975 loops=1)
   ->  Materialize  (cost=0.00..118.62 rows=3975 width=28) (actual time=0.000..0.244 rows=3975 loops=3975)
         ->  Seq Scan on pokemon_pattern_combat pokemon_pattern_combat_1  (cost=0.00..98.75 rows=3975 width=28) (actual time=0.006..1.109 rows=3975 loops=1)
 Planning time: 0.111 ms
 Execution time: 4206.935 ms
(6 rows)

EXPLAIN ANALYZE
WITH A as(
    select pokemon_uid, f_uid, c_uid from pokemon_pattern_combat
    join 
)
select * from A join A as B on true;



EXPLAIN ANALYZE
WITH A as(
    select A.*,B.* 
    from pokemon_pattern_combat A 
    join calc_all(A.pokemon_uid, 1500, 15,15,15) B on true
    join pokemon C on C.uid=A.pokemon_uid
    where C.available = true
)
select * from A join A as B on true;
                                                                   QUERY PLAN                                                                   
------------------------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=67804.08..765078165131.92 rows=11440386228496 width=712) (actual time=0.592..82739.092 rows=15800625 loops=1)
   CTE a
     ->  Nested Loop  (cost=16.60..67804.08 rows=3382364 width=128) (actual time=0.588..76330.594 rows=3975 loops=1)
           ->  Hash Join  (cost=16.35..163.83 rows=3382 width=80) (actual time=0.203..10.806 rows=3975 loops=1)
                 Hash Cond: (a_1.pokemon_uid = c.uid)
                 ->  Seq Scan on pokemon_pattern_combat a_1  (cost=0.00..98.75 rows=3975 width=80) (actual time=0.008..1.666 rows=3975 loops=1)
                 ->  Hash  (cost=10.50..10.50 rows=468 width=9) (actual time=0.187..0.188 rows=468 loops=1)
                       Buckets: 1024  Batches: 1  Memory Usage: 27kB
                       ->  Seq Scan on pokemon c  (cost=0.00..10.50 rows=468 width=9) (actual time=0.007..0.107 rows=468 loops=1)
                             Filter: available
                             Rows Removed by Filter: 82
           ->  Function Scan on calc_all b_1  (cost=0.25..10.25 rows=1000 width=48) (actual time=19.197..19.198 rows=1 loops=3975)
   ->  CTE Scan on a  (cost=0.00..67647.28 rows=3382364 width=356) (actual time=0.590..1.327 rows=3975 loops=1)
   ->  CTE Scan on a b  (cost=0.00..67647.28 rows=3382364 width=356) (actual time=0.000..19.572 rows=3975 loops=3975)
 Planning time: 0.465 ms
 Execution time: 83636.174 ms
(16 rows)



EXPLAIN ANALYZE
select A.*,B.* 
from pokemon_pattern_combat A 
join calc_all(A.pokemon_uid, 1500, 15,15,15) B on true
join pokemon C on C.uid=A.pokemon_uid
where C.available = true;


EXPLAIN ANALYZE
select count(*) 
from pokemon_pattern_combat A 
join calc_all(A.pokemon_uid, 1500, 15,15,15) B on true
join pokemon C on C.uid=A.pokemon_uid
where C.available = true
and A.pokemon_uid='ABSOL';


EXPLAIN ANALYZE
WITH A as(
    select A.*,B.* 
    from pokemon_pattern_combat A 
    join calc_all(A.pokemon_uid, 1500, 15,15,15) B on true
),B as(
    select * from A
    join pokemon C on C.uid=A.pokemon_uid
    where C.available=true
)
select * from B join B as B2 on true;
                                                               QUERY PLAN                                                               
----------------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=207845.24..966176697338.08 rows=11440386228496 width=994) (actual time=0.555..84061.394 rows=15800625 loops=1)
   CTE a
     ->  Nested Loop  (cost=0.25..79599.00 rows=3975000 width=128) (actual time=0.380..76217.434 rows=3975 loops=1)
           ->  Seq Scan on pokemon_pattern_combat a  (cost=0.00..98.75 rows=3975 width=80) (actual time=0.009..1.610 rows=3975 loops=1)
           ->  Function Scan on calc_all b_1  (cost=0.25..10.25 rows=1000 width=48) (actual time=19.171..19.171 rows=1 loops=3975)
   CTE b
     ->  Hash Join  (cost=16.35..128246.24 rows=3382364 width=395) (actual time=0.549..76235.462 rows=3975 loops=1)
           Hash Cond: (a_1.pokemon_uid = c.uid)
           ->  CTE Scan on a a_1  (cost=0.00..79500.00 rows=3975000 width=356) (actual time=0.382..76224.759 rows=3975 loops=1)
           ->  Hash  (cost=10.50..10.50 rows=468 width=39) (actual time=0.161..0.161 rows=468 loops=1)
                 Buckets: 1024  Batches: 1  Memory Usage: 40kB
                 ->  Seq Scan on pokemon c  (cost=0.00..10.50 rows=468 width=39) (actual time=0.008..0.105 rows=468 loops=1)
                       Filter: available
                       Rows Removed by Filter: 82
   ->  CTE Scan on b  (cost=0.00..67647.28 rows=3382364 width=497) (actual time=0.553..1.207 rows=3975 loops=1)
   ->  CTE Scan on b b2  (cost=0.00..67647.28 rows=3382364 width=497) (actual time=0.000..19.591 rows=3975 loops=3975)
 Planning time: 0.174 ms
 Execution time: 84955.324 ms

EXPLAIN ANALYZE
WITH A as(
    select *
    from pokemon
    where available=true
),B as(
    select B.*
    from A
    join pokemon_pattern_combat B on B.pokemon_uid=A.uid
),C as (
    select *
    from B 
    join calc_all(B.pokemon_uid, 1500, 15,15,15) C on true
)
select * from C join C as Z on true;
                                                               QUERY PLAN                                                               
----------------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=80327.94..1065724292962.94 rows=15936064000000 width=712) (actual time=1.049..82406.774 rows=15800625 loops=1)
   CTE a
     ->  Seq Scan on pokemon  (cost=0.00..10.50 rows=468 width=39) (actual time=0.010..0.150 rows=468 loops=1)
           Filter: available
           Rows Removed by Filter: 82
   CTE b
     ->  Hash Join  (cost=15.21..397.35 rows=3992 width=80) (actual time=0.457..10.695 rows=3975 loops=1)
           Hash Cond: (b.pokemon_uid = a.uid)
           ->  Seq Scan on pokemon_pattern_combat b  (cost=0.00..98.75 rows=3975 width=80) (actual time=0.014..1.429 rows=3975 loops=1)
           ->  Hash  (cost=9.36..9.36 rows=468 width=32) (actual time=0.434..0.434 rows=468 loops=1)
                 Buckets: 1024  Batches: 1  Memory Usage: 27kB
                 ->  CTE Scan on a  (cost=0.00..9.36 rows=468 width=32) (actual time=0.011..0.318 rows=468 loops=1)
   CTE c
     ->  Nested Loop  (cost=0.25..79920.09 rows=3992000 width=356) (actual time=1.043..75949.057 rows=3975 loops=1)
           ->  CTE Scan on b b_1  (cost=0.00..79.84 rows=3992 width=308) (actual time=0.460..14.701 rows=3975 loops=1)
           ->  Function Scan on calc_all c_1  (cost=0.25..10.25 rows=1000 width=48) (actual time=19.100..19.100 rows=1 loops=3975)
   ->  CTE Scan on c  (cost=0.00..79840.00 rows=3992000 width=356) (actual time=1.046..1.696 rows=3975 loops=1)
   ->  CTE Scan on c z  (cost=0.00..79840.00 rows=3992000 width=356) (actual time=0.000..19.509 rows=3975 loops=3975)
 Planning time: 0.305 ms
 Execution time: 83292.491 ms
(20 rows)



EXPLAIN ANALYZE
WITH A as(
    select A.*,B.* 
    from pokemon_pattern_combat A 
    join calc_all(A.pokemon_uid, 1500, 15,15,15) B on true
    join pokemon C on C.uid=A.pokemon_uid
    where C.available = true
    and C.uid='ABSOL'
), B as(
    select * from A join A as B on true
)
select * from B;




EXPLAIN ANALYZE
WITH A as(
    select A.*,B.* 
    from pokemon_pattern_combat A 
    join calc_all(A.pokemon_uid, 1500, 15,15,15) B on true
    join pokemon C on C.uid=A.pokemon_uid
    where C.available = true
) select * from A;


EXPLAIN ANALYZE
WITH A as(
    select A.*,B.* 
    from pokemon_pattern_combat A 
    join calc_all(A.pokemon_uid, 1500, 15,15,15) B on true
    where A.available = true
) select * from A;


EXPLAIN ANALYZE
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 1500, 15,15,15) B on true
)
select * from A join A as Z on true;


with A as (
select
    *,
    floor((B.at+IV.AT) * (sqrt(B.df+IV.DF)) * (sqrt(B.hp+IV.HP)) * (A.mlp * A.mlp) / 10) as cp,
    A.lv as lv,
    floor((B.at+IV.AT) * A.mlp) as at,
    floor((B.df+IV.DF) * A.mlp) as df,
    floor((B.hp+IV.HP) * A.mlp) as hp
from cpm A
join pokemon B on B.uid in ('ABSOL')
join (select 15 as AT, 15 as DF, 15 as HP) IV on true
) select * from A where cp <= 1500 order by cp desc limit 1;

EXPLAIN ANALYZE
with A as (
select
    *,
    floor((B.at+IV.AT) * (sqrt(B.df+IV.DF)) * (sqrt(B.hp+IV.HP)) * (A.mlp * A.mlp) / 10) as cp,
    A.lv as lv,
    floor((B.at+IV.AT) * A.mlp) as at,
    floor((B.df+IV.DF) * A.mlp) as df,
    floor((B.hp+IV.HP) * A.mlp) as hp
from cpm A
join pokemon B on B.uid in ('ABSOL')
join (select 15 as AT, 15 as DF, 15 as HP) IV on true
) select * from A where cp <= 1500 order by cp desc limit 1;

drop function if exists calc_all2(target_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer) cascade;
create or replace function calc_all2(target_uid TEXT, cap_cp integer, HPIV integer, ATIV integer, DFIV integer)
returns table(cp integer, lv numeric, atk integer, def integer, hpt integer) as'
BEGIN
    return query
        with A as (
        select
            (floor((B.at+ATIV) * (sqrt(B.df+DFIV)) * (sqrt(B.hp+HPIV)) * (A.mlp * A.mlp) / 10))::INTEGER as cp,
            A.lv as lv,
            floor((B.at+ATIV) * A.mlp)::INTEGER as at,
            floor((B.df+DFIV) * A.mlp)::INTEGER as df,
            floor((B.hp+HPIV) * A.mlp)::INTEGER as hp
        from cpm A
        join pokemon B on B.uid in (target_uid)
        ) select * from A where A.cp <= cap_cp order by A.cp desc limit 1;
    return;
END
' LANGUAGE 'plpgsql';



EXPLAIN ANALYZE
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        get_resistance(PLAYER.f_type, OPPONENT.type_1, OPPONENT.type_2) as f_eff,
        get_resistance(PLAYER.c_type, OPPONENT.type_1, OPPONENT.type_2) as c_eff,

        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        get_resistance(OPPONENT.f_type, PLAYER.type_1, PLAYER.type_2) as opponent_f_eff,
        get_resistance(OPPONENT.c_type, PLAYER.type_1, PLAYER.type_2) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    join effectiveness as Epf1 where Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    join effectiveness as Epf2 where Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    join effectiveness as Epc1 where Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    join effectiveness as Epc2 where Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    join effectiveness as Eof1 where Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    join effectiveness as Eof2 where Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    join effectiveness as Eoc1 where Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    join effectiveness as Eoc2 where Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
)
select
    uid, f_uid, c_uid,
    opponent_uid, opponent_f_uid, opponent_c_uid,
    kill, death,
    kill_b, death_b
from D
where uid='GIRATINA_ALTERED' and f_uid='SHADOW_CLAW' and c_uid='DRAGON_CLAW'
and opponent_uid='TYRANITAR'
limit 3;

--'GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','DRAGON_CLAW'
-- TYRANITAR




EXPLAIN ANALYZE
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
)select * from A join A as Z on true;
                                                                QUERY PLAN                                                                 
-------------------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=79606.00..1180109906473.00 rows=15800625000000 width=840) (actual time=0.319..10748.510 rows=15800625 loops=1)
   CTE a
     ->  Nested Loop  (cost=0.25..79606.00 rows=3975000 width=140) (actual time=0.316..894.479 rows=3975 loops=1)
           ->  Seq Scan on pokemon_pattern_combat a_1  (cost=0.00..105.75 rows=3975 width=92) (actual time=0.007..0.607 rows=3975 loops=1)
           ->  Function Scan on calc_all b  (cost=0.25..10.25 rows=1000 width=48) (actual time=0.224..0.224 rows=1 loops=3975)
   ->  CTE Scan on a  (cost=0.00..79500.00 rows=3975000 width=420) (actual time=0.318..1.499 rows=3975 loops=1)
   ->  CTE Scan on a z  (cost=0.00..79500.00 rows=3975000 width=420) (actual time=0.000..0.781 rows=3975 loops=3975)
 Planning time: 0.137 ms
 Execution time: 12039.095 ms
(9 rows)


EXPLAIN ANALYZE
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,

        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
)
select * from B;



EXPLAIN ANALYZE
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,

        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow
    
    from A as PLAYER
    join A as OPPONENT on true
    join effectiveness as Epf1 on Epf1.attacker in (PLAYER.f_type) and Epf1.defender in (OPPONENT.type_1)
    join effectiveness as Epf2 on Epf2.attacker in (PLAYER.f_type) and Epf2.defender in (OPPONENT.type_2)
    join effectiveness as Epc1 on Epc1.attacker in (PLAYER.c_type) and Epc1.defender in (OPPONENT.type_1)
    join effectiveness as Epc2 on Epc2.attacker in (PLAYER.c_type) and Epc2.defender in (OPPONENT.type_2)
    join effectiveness as Eof1 on Eof1.attacker in (OPPONENT.f_type) and Eof1.defender in (PLAYER.type_1)
    join effectiveness as Eof2 on Eof2.attacker in (OPPONENT.f_type) and Eof2.defender in (PLAYER.type_2)
    join effectiveness as Eoc1 on Eoc1.attacker in (OPPONENT.c_type) and Eoc1.defender in (PLAYER.type_1)
    join effectiveness as Eoc2 on Eoc2.attacker in (OPPONENT.c_type) and Eoc2.defender in (PLAYER.type_2)
)
select * from B;




EXPLAIN ANALYZE
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,

        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
)
select
    uid, f_uid, c_uid,
    opponent_uid, opponent_f_uid, opponent_c_uid,
    kill, death,
    kill_b, death_b
from D
where uid='GIRATINA_ALTERED' and f_uid='SHADOW_CLAW' and c_uid='DRAGON_CLAW'
and opponent_uid='TYRANITAR'
limit 3;

--'GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','DRAGON_CLAW'
-- TYRANITAR



WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('GIRATINA_ALTERED','TYRANITAR')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,

        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
)
select
    uid, f_uid, c_uid,
    opponent_uid, opponent_f_uid, opponent_c_uid,
    kill, death,
    kill_b, death_b
from D
;







WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('GIRATINA_ALTERED','TYRANITAR','ABRA')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
)
select
    uid, f_uid, c_uid,
    opponent_uid, opponent_f_uid, opponent_c_uid,
    kill, death,
    kill_b, death_b
,   case when kill > death and kill_b > death_b then '×' else null end as rate
from D
where uid='ABRA';


WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('GIRATINA_ALTERED','TYRANITAR','ABRA')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), Z as(
    select count(*) as total, count(distinct pokemon_uid) as unique_total from A
)
select
    uid, f_uid, c_uid,
    count(*) as win, 
    Z.total - count(*) as lose, 
    count(distinct opponent_uid) as win_unique, 
    Z.unique_total - count(distinct opponent_uid) as lose_unique
    from D join Z on true
    where kill > death and kill_b > death_b
    group by uid,f_uid,c_uid,Z.total,Z.unique_total
;



drop table if exists win_lose;
create table win_lose as (
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
--    where A.pokemon_uid in ('GIRATINA_ALTERED','TYRANITAR','LATIAS','ABRA')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), Z as(
    select count(*) as total, count(distinct pokemon_uid) as total_unique from A
)
select
    uid as pokemon, 
    f_uid as fastmove, 
    c_uid as chargemove,
    5500 as cap,
    Z.total - count(*) as win,
    count(*) as lose,
    Z.total_unique - count(distinct opponent_uid) as win_unique,
    count(distinct opponent_uid) as lose_unique
from D,Z
where kill > death and kill_b > death_b
group by uid, f_uid, c_uid, Z.total, Z.total_unique
);

WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('SUICUNE')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), Z as(
    select count(*) as total, count(distinct pokemon_uid) as total_unique from A
)
select
    uid as pokemon, 
    f_uid as fastmove, 
    c_uid as chargemove,
    5500 as cap,
    Z.total - count(*) as win,
    count(*) as lose,
    Z.total_unique - count(distinct opponent_uid) as win_unique,
    count(distinct opponent_uid) as lose_unique
from D,Z
where kill > death and kill_b > death_b
group by uid, f_uid, c_uid, f_type, Z.total, Z.total_unique
;


WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('SUICUNE')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), Z as(
    select count(*) as total, count(distinct pokemon_uid) as total_unique from A
)
select
    uid as pokemon, 
    f_uid as fastmove, 
    f_type as f_type,
    c_uid as chargemove,
    5500 as cap,
    Z.total - count(*) as win,
    count(*) as lose,
    Z.total_unique - count(distinct opponent_uid) as win_unique,
    count(distinct opponent_uid) as lose_unique
from D,Z
where kill > death and kill_b > death_b
group by uid, f_uid, c_uid, f_type, Z.total, Z.total_unique
;




select * from pokemon_pattern_combat where pokemon_uid='SUICUNE'
and (pokemon_uid,f_uid,f_type,c_uid) not in 
(WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('SUICUNE')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), Z as(
    select count(*) as total, count(distinct pokemon_uid) as total_unique from A
)
select
    uid as pokemon, 
    f_uid as fastmove, 
    f_type as f_type,
    c_uid as chargemove
from D,Z
where kill > death and kill_b > death_b
group by uid, f_uid, c_uid, f_type, Z.total, Z.total_unique
);
 index | pokemon_uid | type_1 | type_2 |    f_uid     |  f_type  | f_pow | f_dur | f_ene | f_leg | f_stab | f_stab_pow |    c_uid    | c_type | c_pow | c_ene | c_leg | c_stab | c_stab_pow 
-------+-------------+--------+--------+--------------+----------+-------+-------+-------+-------+--------+------------+-------------+--------+-------+-------+-------+--------+------------
   245 | SUICUNE     | WATER  |        | HIDDEN_POWER | ELECTRIC |     9 |   1.5 |     8 | t     | f      |        9.0 | BUBBLE_BEAM | WATER  |    45 |    40 | f     | t      |       54.0
   245 | SUICUNE     | WATER  |        | HIDDEN_POWER | GRASS    |     9 |   1.5 |     8 | t     | f      |        9.0 | BUBBLE_BEAM | WATER  |    45 |    40 | f     | t      |       54.0
   245 | SUICUNE     | WATER  |        | HIDDEN_POWER | ELECTRIC |     9 |   1.5 |     8 | t     | f      |        9.0 | WATER_PULSE | WATER  |    70 |    60 | f     | t      |       84.0
   245 | SUICUNE     | WATER  |        | HIDDEN_POWER | GRASS    |     9 |   1.5 |     8 | t     | f      |        9.0 | WATER_PULSE | WATER  |    70 |    60 | f     | t      |       84.0
(4 rows)

WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('SUICUNE','ABRA')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
)
select
    distinct 
    uid as pokemon, 
    f_uid as fastmove, 
    f_type as f_type,
    c_uid as chargemove,
    5500 as cap,
    sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose
from D;


WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('ABSOL','ABRA','LATIOS')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), E as(
    select distinct 
        uid, 
        f_uid, 
        f_type,
        c_uid,
        opponent_uid,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as lose_each,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as win_each
    from D
)
select distinct
    uid as pokemon, 
    f_uid as fastmove, 
    f_type as f_type,
    c_uid as chargemove,
    5500 as cap,
    win,
    lose,
    sum(case when win_each > 0 then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win_unique,
    sum(case when lose_each > 0 then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose_unique
from E;




BEGIN;
select now();
drop table if exists win_lose;
create table win_lose as (
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
--    where A.pokemon_uid in ('ABSOL','ABRA','LATIOS')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), E as(
    select distinct 
        uid, 
        f_uid, 
        f_type,
        c_uid,
        c_type,
        opponent_uid,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as lose_each,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as win_each
    from D
)
select distinct
    uid as pokemon, 
    f_uid as fastmove, 
    f_type as f_type,
    c_uid as chargemove,
    c_type as c_type,
    5500 as cap,
    win,
    lose,
    sum(case when win_each > 0 then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win_unique,
    sum(case when lose_each > 0 then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose_unique
from E
);
select now();
COMMIT;


WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('GIRATINA_ALTERED','DRAGONITE','MUK_ALOLA','SNORLAX','TYRANITAR')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.type_1 as type_1,
        PLAYER.type_2 as type_2,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), E as(
    select distinct 
        uid, 
        f_uid, 
        type_1,
        type_2,
        f_type,
        c_uid,
        c_type,
        opponent_uid,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as lose_each,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as win_each
    from D
)
select distinct
    uid as pokemon,
    type_1 as type_1,
    type_2 as type_2,
    f_uid as fastmove, 
    f_type as f_type,
    c_uid as chargemove,
    c_type as c_type,
    5500 as cap,
    win,
    lose,
    sum(case when win_each > 0 then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win_unique,
    sum(case when win_each > 0 then 0 else 1 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose_unique
from E
;


select * from(
select distinct uid
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','DRAGON_CLAW') A
where kill<death and kill_b < death_b 
order by uid)A
left join (
select distinct uid
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','SHADOW_SNEAK') A
where kill<death and kill_b < death_b 
order by uid)B on B.uid=A.uid
;

select distinct uid
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'SHADOW_CLAW','DRAGON_CLAW') A
where kill>=death and kill_b >= death_b 
order by uid;




select now();
BEGIN;
drop table if exists win_lose;
create table win_lose as (
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
--    where A.pokemon_uid in ('GIRATINA_ALTERED','DRAGONITE','MUK_ALOLA','SNORLAX','TYRANITAR')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.type_1 as type_1,
        PLAYER.type_2 as type_2,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), E as(
    select distinct 
        uid, 
        f_uid, 
        type_1,
        type_2,
        f_type,
        c_uid,
        c_type,
        opponent_uid,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as lose_each,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as win_each
    from D
)
select distinct
    uid as pokemon,
    type_1 as type_1,
    type_2 as type_2,
    f_uid as fastmove, 
    f_type as f_type,
    c_uid as chargemove,
    c_type as c_type,
    5500 as cap,
    win,
    lose,
    sum(case when win_each > 0 then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win_unique,
    sum(case when win_each > 0 then 0 else 1 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose_unique
from E
);
COMMIT;
select now();

select now();
BEGIN;
insert into win_lose 
WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 2500, 15,15,15) B on true
--    where A.pokemon_uid in ('GIRATINA_ALTERED','DRAGONITE','MUK_ALOLA','SNORLAX','TYRANITAR')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.type_1 as type_1,
        PLAYER.type_2 as type_2,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), E as(
    select distinct 
        uid, 
        f_uid, 
        type_1,
        type_2,
        f_type,
        c_uid,
        c_type,
        opponent_uid,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as lose_each,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as win_each
    from D
)
select distinct
    uid as pokemon,
    type_1 as type_1,
    type_2 as type_2,
    f_uid as fastmove, 
    f_type as f_type,
    c_uid as chargemove,
    c_type as c_type,
    2500 as cap,
    win,
    lose,
    sum(case when win_each > 0 then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win_unique,
    sum(case when win_each > 0 then 0 else 1 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose_unique
from E
;
COMMIT;
select now();






WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('GIRATINA_ALTERED','DRAGONITE','MUK_ALOLA','SNORLAX','TYRANITAR')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.type_1 as type_1,
        PLAYER.type_2 as type_2,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), E as(
    select distinct 
        uid, 
        f_uid, 
        type_1,
        type_2,
        f_type,
        c_uid,
        c_type,
        opponent_uid,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as lose,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid) as win,
        sum(case when kill > death and kill_b > death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as lose_each,
        sum(case when kill <= death or kill_b <= death_b then 1 else 0 end) over (PARTITION by uid, f_uid, f_type, c_uid, opponent_uid) as win_each
    from D
)



WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('GIRATINA_ALTERED','DRAGONITE','MUK_ALOLA','SNORLAX','TYRANITAR')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.type_1 as type_1,
        PLAYER.type_2 as type_2,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
)
select 
    uid,f_uid,c_uid,opponent_uid,opponent_f_uid,opponent_c_uid,
    kill,
    death,
    case when death<kill then 'X' else null end as lose,
    case when death>=kill then 'X' else null end as win,
    kill_b,
    death_b,
    case when death_b<kill_b then 'X' else null end as lose_b,
    case when death_b>=kill_b then 'X' else null end as win_b,
    case when death<kill and death_b<kill_b then 'X' else null end as counter
from D
where uid='GIRATINA_ALTERED' and f_uid='SHADOW_CLAW' and c_uid='DRAGON_CLAW';





WITH A as (
    select *
    from pokemon_pattern_combat A
    join calc_all(A.pokemon_uid, 5500, 15,15,15) B on true
    where A.pokemon_uid in ('GIRATINA_ALTERED','LATIAS','MUK_ALOLA','TYRANITAR')
),B as(
    select
        PLAYER.pokemon_uid as uid,
        PLAYER.type_1 as type_1,
        PLAYER.type_2 as type_2,
        PLAYER.f_uid as f_uid,
        PLAYER.f_type as f_type,
        PLAYER.c_uid as c_uid,
        PLAYER.c_type as c_type,
        PLAYER.atk as atk,
        PLAYER.def as def,
        PLAYER.hpt as hpt,
        PLAYER.f_stab_pow as f_stab_pow,
        PLAYER.c_stab_pow as c_stab_pow,
        Epf1.mlp * (case when Epf2.mlp is not null then Epf2.mlp else 1.0 end) as f_eff,
        Epc1.mlp * (case when Epc2.mlp is not null then Epc2.mlp else 1.0 end) as c_eff,
        OPPONENT.pokemon_uid as opponent_uid,
        OPPONENT.f_uid as opponent_f_uid,
        OPPONENT.c_uid as opponent_c_uid,
        OPPONENT.atk as opponent_atk,
        OPPONENT.def as opponent_def,
        OPPONENT.hpt as opponent_hpt,
        OPPONENT.f_stab_pow as opponent_f_stab_pow,
        OPPONENT.c_stab_pow as opponent_c_stab_pow,
        Eof1.mlp * (case when Eof2.mlp is not null then Eof2.mlp else 1.0 end) as opponent_f_eff,
        Eoc1.mlp * (case when Eoc2.mlp is not null then Eoc2.mlp else 1.0 end) as opponent_c_eff
    
    from A as PLAYER
    join A as OPPONENT on true
    left join effectiveness as Epf1 on Epf1.attacker=PLAYER.f_type and Epf1.defender=OPPONENT.type_1
    left join effectiveness as Epf2 on Epf2.attacker=PLAYER.f_type and Epf2.defender=OPPONENT.type_2
    left join effectiveness as Epc1 on Epc1.attacker=PLAYER.c_type and Epc1.defender=OPPONENT.type_1
    left join effectiveness as Epc2 on Epc2.attacker=PLAYER.c_type and Epc2.defender=OPPONENT.type_2
    left join effectiveness as Eof1 on Eof1.attacker=OPPONENT.f_type and Eof1.defender=PLAYER.type_1
    left join effectiveness as Eof2 on Eof2.attacker=OPPONENT.f_type and Eof2.defender=PLAYER.type_2
    left join effectiveness as Eoc1 on Eoc1.attacker=OPPONENT.c_type and Eoc1.defender=PLAYER.type_1
    left join effectiveness as Eoc2 on Eoc2.attacker=OPPONENT.c_type and Eoc2.defender=PLAYER.type_2
), C as(
    select
        *, 
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * f_stab_pow * f_eff * 1.3) + 1)::numeric as f_dmg,
        (FLOOR(0.5 * ROUND(atk::NUMERIC / opponent_def, 2) * c_stab_pow * c_eff * 1.3) + 1)::numeric as c_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_f_stab_pow * opponent_f_eff * 1.3) + 1)::numeric as opponent_f_dmg,
        (FLOOR(0.5 * ROUND(opponent_atk::NUMERIC / def, 2) * opponent_c_stab_pow * opponent_c_eff * 1.3) + 1)::numeric as opponent_c_dmg
    from B 
), D as(
    select
        *,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 0) as kill,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,0)as death,
        calc_killtime_combat(opponent_hpt, f_dmg, f_uid, c_dmg, c_uid, 2) as kill_b,
        calc_killtime_combat(hpt, opponent_f_dmg,opponent_f_uid,opponent_c_dmg,opponent_c_uid,2)as death_b
    from C
), E as(
    select 
        *,
        case when death<kill then 1 else 0 end as lose,
        case when death>=kill then 1 else 0 end as win,
        case when death_b<kill_b then 1 else 0 end as lose_b,
        case when death_b>=kill_b then 1 else 0 end as win_b,
--        case when death<kill and death_b<kill_b then 1 else 0 end as counter
        sum(case when death<kill and death_b<kill_b then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid) as counter
    ,   sum(case when death<kill and death_b<kill_b then 1 else 0 end) over (partition by uid, f_uid, f_type, c_uid, opponent_uid) as counter_unique
    from D
)
select distinct
    uid,f_uid,f_type,c_uid,opponent_uid,
--    opponent_uid,opponent_f_uid,opponent_c_uid,
--    kill,death,lose,win,kill_b,death_b,lose_b,win_b,counter,
    counter, 
    counter_unique,
    sum(case when counter_unique=0 then 0 else -1 end) over (partition by uid, f_uid, f_type, c_uid) as temp
from E
where uid='GIRATINA_ALTERED' and f_uid='SHADOW_CLAW' and c_uid='DRAGON_CLAW';



