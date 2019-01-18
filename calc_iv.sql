-- calc_iv
-- select * from calc_iv('MISDREAVUS', 1551, 124, 5000, 'B', 'h', 'a');
-- select * from calc_iv('ムウマ', 1551, 124, 5000, 'B', 'HP', 'A', null);

drop function if exists stats_minmax(_statsanalysis TEXT);
create or replace function stats_minmax(_statsanalysis TEXT)
returns table (min INTEGER, max INTEGER) as $$
BEGIN
    case
        when UPPER(_statsanalysis) ~ 'A' then return query select 15, 15;
        when UPPER(_statsanalysis) ~ 'B' then return query select 13, 14;
        when UPPER(_statsanalysis) ~ 'C' then return query select 8, 12;
        else return query select 0, 7;
    end case;
    return;
END
$$ LANGUAGE 'plpgsql';

drop function if exists overall_minmax(_overall TEXT);
create or replace function overall_minmax(_overall TEXT)
returns table (min INTEGER, max INTEGER) as $$
BEGIN
    case
        when UPPER(_overall) ~ 'A' then return query select 37, 45;
        when UPPER(_overall) ~ 'B' then return query select 30, 36;
        when UPPER(_overall) ~ 'C' then return query select 23, 29;
        else return query select 0, 22;
    end case;
    return;
END
$$ LANGUAGE 'plpgsql';


drop function if exists get_pokemon_uid(name text);
create or replace function get_pokemon_uid(name text)
returns text as '
DECLARE
    temp record;
BEGIN
    IF name ~ ''^\w+$'' THEN
        select * into temp from localize_pokemon where uid=UPPER(name);
    ELSE
        select * into temp from localize_pokemon where jp=name;
    END IF;
    return temp.uid;
END
' LANGUAGE 'plpgsql';


drop function if exists get_move_uid(name text);
create or replace function get_move_uid(name text)
returns text as '
DECLARE
    temp record;
BEGIN
    IF name ~ ''^\w+$'' THEN
        select * into temp from localize_fastmove where uid=UPPER(name)
        union select * from localize_chargemove where uid=UPPER(name);
    ELSE
        select * into temp from localize_fastmove where jp=name
        union select * from localize_chargemove where jp=name;
    END IF;
    return temp.uid;
END
' LANGUAGE 'plpgsql';






drop function if exists calc_iv(_pokemon TEXT, _cp INTEGER, _hp INTEGER, _stardust INTEGER, _overall TEXT, _beststats TEXT, _statsanalysis TEXT, _evolve TEXT);
create or replace function calc_iv(_pokemon TEXT, _cp INTEGER, _hp INTEGER, _stardust INTEGER, _overall TEXT, _beststats TEXT, _statsanalysis TEXT, _evolve TEXT)
returns table(lv NUMERIC, atk INTEGER, def INTEGER, hpt INTEGER, total TEXT, evolved_cp INTEGER) as $$
DECLARE
    temp record;
    f_at boolean;
    f_df boolean;
    f_hp boolean;
    min_at integer := 0;
    min_df integer := 0;
    min_hp integer := 0;
    max_at integer := 15;
    max_df integer := 15;
    max_hp integer := 15;
    min_overall integer := 0;
    max_overall integer := 45;
    pokemon record;
    evolve record;
    lvs record;
    c_lvs cursor for select A.lv,B.mlp from stardust_candy A join cpm B on B.lv=A.lv where A.stardust=_stardust;
    mlp numeric;
    hpIV integer;
    atIV integer;
    dfIV integer;
    calculatedHP integer;
    calculatedCP integer;
    evolveCP integer := 0;
BEGIN
    -- extract _beststats text into flags (e.g. 'ah' into f_at:true, f_df:false, f_hp:true) 
    select UPPER(_beststats) ~ 'A' into f_at;
    select UPPER(_beststats) ~ 'D' into f_df;
    select UPPER(_beststats) ~ 'H' into f_hp;
    select * from stats_minmax(_statsanalysis) into temp;
    IF f_at THEN 
        min_at := temp.min;
        max_at := temp.max;
    ELSE
        max_at := temp.max - 1;
    END IF;
    IF f_df THEN 
        min_df := temp.min;
        max_df := temp.max;
    ELSE
        max_df := temp.max - 1;
    END IF;
    IF f_hp THEN 
        min_hp := temp.min;
        max_hp := temp.max;
    ELSE
        max_hp := temp.max - 1;
    END IF;
    --raise NOTICE 'at:%-% df:%-% hp:%-%', min_at,max_at, min_df,max_df, min_hp,max_hp;

    select * from overall_minmax(_overall) into temp;
    min_overall := temp.min;
    max_overall := temp.max;
    --raise NOTICE 'overall:%-%', min_overall, max_overall;

    -- determine which pokemon
    IF _pokemon ~ '^\w+$' THEN
        select * into pokemon from pokemon where uid=UPPER(_pokemon);
    ELSE
        select A.* into pokemon from pokemon A join localize_pokemon B on B.uid=A.uid where B.jp=_pokemon;
    END IF;
    raise NOTICE 'pokemon:% baseAT:% baseDF:% baseHP:%', pokemon.uid, pokemon.at, pokemon.df, pokemon.hp;

    -- determine evolve target if exists
    IF _evolve is not null THEN
        IF _evolve ~ '^\w+$' THEN
            select * into evolve from pokemon where uid=UPPER(_evolve);
        ELSE
            select A.* into evolve from pokemon A join localize_pokemon B on B.uid=A.uid where B.jp=_evolve;
        END IF;
    END IF;

    -- 1. guess possible LVs from stardust
    FOR lvs in c_lvs loop
        mlp := lvs.mlp;
        --raise NOTICE 'lv:% mlp:%', lvs.lv, mlp;

        -- 1. guess HP first
        FOR hpIV in min_hp..max_hp loop
            calculatedHP = floor((pokemon.hp + hpIV) * mlp);
            IF calculatedHP = _hp THEN
                -- 2. guess AT and DF
                FOR atIV in min_at..max_at LOOP
                FOR dfIV in min_df..max_df LOOP
                    calculatedCP := floor((pokemon.at + atIV) * (sqrt(pokemon.df + dfIV)) * (sqrt(pokemon.hp + hpIV)) * (mlp * mlp) / 10);
                    --raise NOTICE 'LV:% AT:% DF:% HP:% -> CP:%', lvs.lv, atIV, dfIV, hpIV, calculatedCP;
                    IF calculatedCP = _cp and atIV+dfIV+hpIV >= min_overall and atIV+dfIV+hpIV<= max_overall THEN
                        --raise NOTICE '  ** MATCH ** ';
                        IF _evolve is not null THEN
                            evolveCP := floor((evolve.at + atIV) * (sqrt(evolve.df + dfIV)) * (sqrt(evolve.hp + hpIV)) * (mlp * mlp) / 10);
                        END IF;
                        return query 
                            select 
                                lvs.lv, atIV, dfIV, hpIV, 
                                upper(to_hex(atIV)) || upper(to_hex(dfIV)) || upper(to_hex(hpIV)) || '%' || ceil((atIV+dfIV+hpIV)*100 / 45), 
                                evolveCP;
                    END IF;
                end loop;
                end loop;
            END IF;
        end loop;
    end loop;

    return;
END
$$ LANGUAGE 'plpgsql';


