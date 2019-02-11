24,null,ARBOK,253,false
89,76,MUK_ALOLA,278,false
141,null,KABUTOPS,283,false
217,null,URSARING,213,false
226,null,MANTINE,271,false
232,null,DONPHAN,233,false
250,null,HO_OH,281,false
373,null,SALAMENCE,202,false
405,null,LUXRAY,281,false
452,null,DRAPION,202,false

BEGIN;
create table temp_newmoves_fast (
    index text,
    form text,
    uid text,
    fastmove text,
    legacy boolean
);
insert into temp_newmoves_fast values
('24','null','ARBOK','253',false),
('89','76','MUK_ALOLA','278',false),
('141','null','KABUTOPS','283',false),
('217','null','URSARING','213',false),
('226','null','MANTINE','271',false),
('232','null','DONPHAN','233',false),
('250','null','HO_OH','281',false),
('373','null','SALAMENCE','202',false),
('405','null','LUXRAY','281',false),
('452','null','DRAPION','202',false)
;
COMMIT;



select 
    A.index,
    B.jp,B.en,
    CONCAT('{{< type ' , D.type_1, ' >}}') as type1,
    case when D.type_2 is not null then CONCAT('{{< type ' , D.type_2, ' >}}') else '' end as type2,
    C.jp,C.en,
    CONCAT('{{< type ' , F.uid, ' >}}') as type
from temp_newmoves_fast A
join localize_pokemon B on B.uid=A.uid
join localize_fastmove C on C.index=A.fastmove
join pokemon D on D.uid=A.uid
join _fastmove_combat E on E.index=A.fastmove
join localize_type F on F.index=E.type
;




BEGIN;
create table temp_newmoves_charge (
    index text,
    form text,
    uid text,
    chargemove text,
    legacy boolean
);
insert into temp_newmoves_charge values
('36','null','CLEFABLE','301',false),
('38','null','NINETALES','60',false),
('38','58','NINETALES_ALOLA','60',false),
('38','57','NINETALES_NORMAL','60',false),
('40','null','WIGGLYTUFF','39',false),
('65','null','ALAKAZAM','115',false),
('68','null','MACHAMP','64',false),
('89','null','MUK','77',false),
('89','75','MUK_NORMAL','77',false),
('110','null','WEEZING','79',false),
('121','null','STARMIE','78',false),
('121','null','STARMIE','39',false),
('124','null','JYNX','247',false),
('142','null','AERODACTYL','64',false),
('143','null','SNORLAX','277',false),
('181','null','AMPHAROS','65',false),
('229','null','HOUNDOOM','24',false),
('241','null','MILTANK','79',false),
('241','null','MILTANK','39',false),
('243','null','RAIKOU','70',false),
('244','null','ENTEI','74',false),
('245','null','SUICUNE','39',false),
('272','null','LUDICOLO','39',false),
('358','null','CHIMECHO','60',false),
('407','null','ROSERADE','272',false),
('430','null','HONCHKROW','257',false),
('467','null','MAGMORTAR','108',false),
('468','null','TOGEKISS','24',false),
('474','null','PORYGON_Z','40',false)
;
COMMIT;



select 
    A.index,
    B.jp,B.en,
    CONCAT('{{< type ' , D.type_1, ' >}}') as type1,
    case when D.type_2 is not null then CONCAT('{{< type ' , D.type_2, ' >}}') else '' end as type2,
    C.jp,C.en,
    CONCAT('{{< type ' , F.uid, ' >}}') as type
from temp_newmoves_charge A
join localize_pokemon B on B.uid=A.uid
join localize_chargemove C on C.index=A.chargemove
join pokemon D on D.uid=A.uid
join _chargemove_combat E on E.index=A.chargemove
join localize_type F on F.index=E.type
;


With A as(
select 
    A.index,
    B.jp,B.en,
    CONCAT('{{< type ' , D.type_1, ' >}}') as type1,
    case when D.type_2 is not null then CONCAT('{{< type ' , D.type_2, ' >}}') else '' end as type2,
    C.jp,C.en,
    CONCAT('{{< type ' , F.uid, ' >}}') as type,
    '' as note
from temp_newmoves_fast A
join localize_pokemon B on B.uid=A.uid
join localize_fastmove C on C.index=A.fastmove
join pokemon D on D.uid=A.uid
join _fastmove_combat E on E.index=A.fastmove
join localize_type F on F.index=E.type
union all 
select 
    A.index,
    B.jp,B.en,
    CONCAT('{{< type ' , D.type_1, ' >}}') as type1,
    case when D.type_2 is not null then CONCAT('{{< type ' , D.type_2, ' >}}') else '' end as type2,
    C.jp,C.en,
    CONCAT('{{< type ' , F.uid, ' >}}') as type,
    '' as note
from temp_newmoves_charge A
join localize_pokemon B on B.uid=A.uid
join localize_chargemove C on C.index=A.chargemove
join pokemon D on D.uid=A.uid
join _chargemove_combat E on E.index=A.chargemove
join localize_type F on F.index=E.type
) select * from A order by (index::INTEGER);

