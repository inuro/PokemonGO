-- weakness

With A as(
    select 
        a.*, 
        b1.attacker as attcker, 
        b1.mlp,b2.mlp,
        COALESCE(b1.mlp,1.0) * COALESCE(b2.mlp,1.0) as eff 
    from _pokemon a 
    left join _effectiveness b1 on b1.defender=a.type_1 
    left join _effectiveness b2 on b2.defender = a.type_2 and b2.attacker=b1.attacker
), B as(
    select
        uid, type_1, type_2
    ,   mlp2mark(max(case when attcker='NORMAL' then eff else 0 end)) as "ノ"
    ,   mlp2mark(max(case when attcker='FIGHTING' then eff else 0 end)) as "闘"
    ,   mlp2mark(max(case when attcker='FLYING' then eff else 0 end)) as "飛"
    ,   mlp2mark(max(case when attcker='POISON' then eff else 0 end)) as "毒"
    ,   mlp2mark(max(case when attcker='GROUND' then eff else 0 end)) as "地"
    ,   mlp2mark(max(case when attcker='ROCK' then eff else 0 end)) as "岩"
    ,   mlp2mark(max(case when attcker='BUG' then eff else 0 end)) as "虫"
    ,   mlp2mark(max(case when attcker='GHOST' then eff else 0 end)) as "ゴ"
    ,   mlp2mark(max(case when attcker='STEEL' then eff else 0 end)) as "鋼"
    ,   mlp2mark(max(case when attcker='FIRE' then eff else 0 end)) as "炎"
    ,   mlp2mark(max(case when attcker='WATER' then eff else 0 end)) as "水"
    ,   mlp2mark(max(case when attcker='GRASS' then eff else 0 end)) as "草"
    ,   mlp2mark(max(case when attcker='ELECTRIC' then eff else 0 end)) as "電"
    ,   mlp2mark(max(case when attcker='PSYCHIC' then eff else 0 end)) as "エ"
    ,   mlp2mark(max(case when attcker='ICE' then eff else 0 end)) as "氷"
    ,   mlp2mark(max(case when attcker='DRAGON' then eff else 0 end)) as "ド"
    ,   mlp2mark(max(case when attcker='DARK' then eff else 0 end)) as "悪"
    ,   mlp2mark(max(case when attcker='FAIRY' then eff else 0 end)) as "フ"
    from A
    group by uid, type_1, type_2
)
select C.jp, B.* from B
join localize_pokemon C using(uid)
where uid in (
    puid('ニョロトノ'),
    puid('ルンパッパ'),
    puid('ライチュウ')
)
;


DROP TABLE if exists weakness;
CREATE TABLE weakness as
With A as(
    select 
        a.*, 
        C.jp,
        b1.attacker as attcker, 
        b1.mlp,b2.mlp,
        COALESCE(b1.mlp,1.0) * COALESCE(b2.mlp,1.0) as eff 
    from _pokemon a 
    left join _effectiveness b1 on b1.defender=a.type_1 
    left join _effectiveness b2 on b2.defender = a.type_2 and b2.attacker=b1.attacker
    left join localize_pokemon C using(uid)
    where a.uid !~ '_SHADOW'
), B as(
    select
        A.pokemon_id, A.jp, A.uid, A.type_1, A.type_2
        ,   (max(case when attcker='NORMAL' then eff else -100.0 end)) as NORMAL
        ,   (max(case when attcker='FIGHTING' then eff else -100.0 end)) as FIGHTING
        ,   (max(case when attcker='FLYING' then eff else -100.0 end)) as FLYING
        ,   (max(case when attcker='POISON' then eff else -100.0 end)) as POISON
        ,   (max(case when attcker='GROUND' then eff else -100.0 end)) as GROUND
        ,   (max(case when attcker='ROCK' then eff else -100.0 end)) as ROCK
        ,   (max(case when attcker='BUG' then eff else -100.0 end)) as BUG
        ,   (max(case when attcker='GHOST' then eff else -100.0 end)) as GHOST
        ,   (max(case when attcker='STEEL' then eff else -100.0 end)) as STEEL
        ,   (max(case when attcker='FIRE' then eff else -100.0 end)) as FIRE
        ,   (max(case when attcker='WATER' then eff else -100.0 end)) as WATER
        ,   (max(case when attcker='GRASS' then eff else -100.0 end)) as GRASS
        ,   (max(case when attcker='ELECTRIC' then eff else -100.0 end)) as ELECTRIC
        ,   (max(case when attcker='PSYCHIC' then eff else -100.0 end)) as PSYCHIC
        ,   (max(case when attcker='ICE' then eff else -100.0 end)) as ICE
        ,   (max(case when attcker='DRAGON' then eff else -100.0 end)) as DRAGON
        ,   (max(case when attcker='DARK' then eff else -100.0 end)) as DARK
        ,   (max(case when attcker='FAIRY' then eff else -100.0 end)) as FAIRY
    from A
    group by pokemon_id, uid, type_1, type_2, jp
)
select * from B
order by pokemon_id
;

