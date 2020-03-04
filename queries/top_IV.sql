-- pre-calculate top IV pattern

BEGIN;
DROP TABLE if exists top_IV;
CREATE TABLE top_IV(
    uid text,
    cp integer,
    lv numeric,
    hp integer, at integer, df integer, 
    hpt integer, atk numeric, def numeric,
    cap integer 
);
-- cap 1500
INSERT INTO top_IV
With A as(
    select distinct pokemon_uid as uid from pokemon_pattern_combat -- where pokemon_uid!~'_FALL_2019'
    -- select uid from pokemon where uid !~'_SHADOW' and uid !~ '_PURIFIED' and uid !~ '_FALL_2019'
), B as(
    select A.uid, B.*,
    rank() over (
        partition by uid
        order by hpt*def desc, hpt desc, def*atk desc, atk desc, lv, cp desc, hp desc,df desc,at desc
    ) rnk,
    1500 as cap
    from A 
    join calc_all_IV_pattern(A.uid,1500,41) B on true 
)
select
    uid,cp,lv,hp,at,df,hpt,atk,def,cap
from B where rnk=1
;
COMMIT;


-- cap 2500
BEGIN;
INSERT INTO top_IV
With A as(
    select distinct pokemon_uid as uid from pokemon_pattern_combat -- where pokemon_uid!~'_FALL_2019'
    -- select uid from pokemon where uid !~'_SHADOW' and uid !~ '_PURIFIED' and uid !~ '_FALL_2019'
), B as(
    select A.uid, B.*,
    rank() over (
        partition by uid
        order by hpt*def desc, hpt desc, def*atk desc, atk desc, lv, cp desc, hp desc,df desc,at desc
    ) rnk,
    2500 as cap
    from A 
    join calc_all_IV_pattern(A.uid,2500,41) B on true 
)
select
    uid,cp,lv,hp,at,df,hpt,atk,def,cap
from B where rnk=1;
COMMIT;


-- cap 5500
BEGIN;
INSERT INTO top_IV
With A as(
    select distinct pokemon_uid as uid from pokemon_pattern_combat -- where pokemon_uid!~'_FALL_2019'
    -- select uid from pokemon where uid !~'_SHADOW' and uid !~ '_PURIFIED' and uid !~ '_FALL_2019'
), B as(
    select B.*,
    5500 as cap
    from A 
    join calc_cp(CONCAT_WS(',', A.uid,41,15,15,15)) B on true 
)
select
    uid,cp,lv,15 as hp,15 as at, 15 as df,hpt,atk,def,cap
from B;
COMMIT;

