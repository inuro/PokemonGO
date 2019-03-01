drop function if exists calc_evolve_border(to_uid TEXT, from_uid TEXT, cap_cp integer);
create or replace function calc_evolve_border(to_uid TEXT, from_uid TEXT, cap_cp integer)
returns table(
    pattern text,
    lvl numeric, 
    cp integer,
    hp integer,
    at integer,
    df integer
) as'
DECLARE
    to_pokemon record;
    from_pokemon record;
    hp integer;
    at integer;
    df integer;

    temp record;
    cp_min_temp integer;
    cp_max_temp integer;
    cp_min integer := 5500;
    cp_max integer := 5550;
    lvl_min numeric;
    lvl_max numeric;
    hp_min integer;
    at_min integer;
    df_min integer;
    hp_max integer;
    at_max integer;
    df_max integer;

BEGIN
    select * into to_pokemon from pokemon where uid=to_uid;
    select * into from_pokemon from pokemon where uid=from_uid;

    FOR hp in 0..15 LOOP
    FOR at in 0..15 LOOP
    FOR df in 0..15 LOOP
        With A as(select
            (floor((to_pokemon.at+at) * (sqrt(to_pokemon.df+df)) * (sqrt(to_pokemon.hp+hp)) * (mlp * mlp) / 10))::INTEGER as to_cp,
            lv,
            mlp
        from cpm)
        select A.* into temp from A
        where A.to_cp > cap_cp order by A.to_cp limit 1;

        select (floor((from_pokemon.at+at) * (sqrt(from_pokemon.df+df)) * (sqrt(from_pokemon.hp+hp)) * (mlp * mlp) / 10))::INTEGER into cp_min_temp
        from cpm
        where lv = (temp.lv - 0.5);

        select (floor((from_pokemon.at+at) * (sqrt(from_pokemon.df+df)) * (sqrt(from_pokemon.hp+hp)) * (mlp * mlp) / 10))::INTEGER into cp_max_temp
        from cpm
        where lv = temp.lv;

        --raise info ''%, %'',cp_min_temp, cp_max_temp;
        IF cp_min_temp < cp_min THEN
            cp_min = cp_min_temp;
            lvl_min = temp.lv - 0.5;
            hp_min = hp;
            at_min = at;
            df_min = df;
        END IF;
        IF cp_max_temp < cp_max THEN
            cp_max = cp_max_temp;
            lvl_max = temp.lv;
            hp_max = hp;
            at_max = at;
            df_max = df;
        END IF;
         
    END LOOP;
    END LOOP;
    END LOOP;

    return query
        select 
            ''min'', 
            lvl_min, 
            cp_min,
            hp_min, at_min, df_min
        ;
    return query
        select 
            ''max'', 
            lvl_max, 
            cp_max,
            hp_max, at_max, df_max
        ;
    return;
END
' LANGUAGE 'plpgsql';





-- select * from calc_evolve_border('サーナイト,キルリア,2500');
--  title | to_cp | from_cp | lvl  | hpiv | ativ | dfiv | rank 
-- -------+-------+---------+------+------+------+------+------
--  min   |  2483 |     690 | 34.5 |    1 |    0 |    0 | D
--  max   |  2498 |     778 | 28.5 |   12 |   15 |   15 | A
drop function if exists calc_evolve_border(condition TEXT);
create or replace function calc_evolve_border(condition TEXT)
returns table(
    title text,
    to_cp integer, 
    from_cp integer,
    lvl numeric,
    hpiv integer,
    ativ integer,
    dfiv integer,
    rank text
) as'
DECLARE
    temp text[];
    to_uid TEXT;
    from_uid TEXT;
    cap_cp INTEGER;
BEGIN
    temp := string_to_array(condition,'','');
    to_uid := puid(temp[1]);
    from_uid := puid(temp[2]);
    cap_cp := temp[3];
    return query 
        With A as(
            select * from calc_all_IV_pattern(to_uid,cap_cp)
        ), B as(
            select
                A.*,
                (floor((B.at+A.at) * (sqrt(B.df+A.df)) * (sqrt(B.hp+A.hp)) * (c.mlp * c.mlp) / 10))::INTEGER as _from_cp
            from A
            join pokemon B on B.uid=from_uid
            join cpm C on C.lv=A.lv
        )
        select ''min'', cp, _from_cp, lv, hp, at, df, overall from B order by _from_cp limit 1;

    return query 
        With A as(
            select * from calc_all_IV_pattern(to_uid,cap_cp)
        ), B as(
            select
                A.*,
                (floor((B.at+A.at) * (sqrt(B.df+A.df)) * (sqrt(B.hp+A.hp)) * (c.mlp * c.mlp) / 10))::INTEGER as _from_cp
            from A
            join pokemon B on B.uid=from_uid
            join cpm C on C.lv=A.lv
        )
        select ''max'', cp, _from_cp, lv, hp, at, df, overall from B order by _from_cp desc limit 1;

    return;
END
' LANGUAGE 'plpgsql';



With A as(
    select * from calc_all_IV_pattern('MAMOSWINE',1500)
), B as(
    select
        A.*,
        (floor((B.at+A.at) * (sqrt(B.df+A.df)) * (sqrt(B.hp+A.hp)) * (c.mlp * c.mlp) / 10))::INTEGER as from_cp
    from A
    join pokemon B on B.uid='SWINUB'
    join cpm C on C.lv=A.lv
)
select 'min' as title, cp, from_cp, lv, hp, at, df from B order by from_cp limit 1;