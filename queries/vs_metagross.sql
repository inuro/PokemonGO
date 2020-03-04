-- METAGROSS

select * from calc_counter_combat('METAGROSS',5500,15,15,15,'BULLET_PUNCH','METEOR_MASH') where kill < 8.0 order by dps desc;

select jp,fastmove,chargemove,set, per, sec, dps, kill, death, kill_b, death_b, ofd, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',5500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
where kill < 8.0 
order by dps desc;


select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',5500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
--where kill < 8.0 
order by dps desc
limit 10;


select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',5500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
where kill < death
order by kill
limit 10;


select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',5500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
order by kill_b/death_b, kill_b
limit 100;


select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',5500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
where kill<death and kill_b<death_b
order by kill_b/death_b
;


select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',5500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
order by x desc
;



select jp,fastmove,chargemove,
set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',2500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill_b, index, kill
limit 100;






select jp,fastmove,chargemove,
set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',1500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
where kill<death and kill_b<death_b and kill<8.0
order by kill_b/death_b, kill_b, index, kill
limit 100;

select jp,fastmove,chargemove,
set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',1500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
where kill < sec and kill<death and kill_b<death_b and kill<8.0
order by kill*ofdpsp
limit 100;

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',1500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',2500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;


select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('METAGROSS',5500,15,15,15,'BULLET_PUNCH','METEOR_MASH') 
where kill<death and kill_b<death_b
order by kill_b/death_b, kill/death, kill_b, kill, index, dps desc
limit 100;

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','THUNDERBOLT') 
where kill<death and kill_b<death_b
order by kill_b/death_b

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('MELMETAL',5500,15,15,15,'THUNDER_SHOCK','ROCK_SLIDE') 
where kill<death and kill_b<death_b
order by kill_b/death_b

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('TYRANITAR',5500,15,15,15,'BITE','CRUNCH') 
where kill<death and kill_b<death_b
order by kill_b/death_b



select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','ANCIENT_POWER') 
where kill<death and kill_b<death_b
order by kill_b/death_b


select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('GIRATINA_ALTERED',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW') 
where kill<death and kill_b<death_b
order by kill_b/death_b


select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('HEATRAN',5500,15,15,15,'FIRE_SPIN','FIRE_BLAST') 
where kill<death and kill_b<death_b
order by kill_b/death_b


RHYPERIOR

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('RHYPERIOR',5500,15,15,15,'MUD_SLAP','SURF') 
where kill<death and kill_b<death_b
order by kill_b/death_b;

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('RHYPERIOR',5500,15,15,15,'MUD_SLAP','STONE_EDGE') 
where kill<death and kill_b<death_b
order by kill_b/death_b;


select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('RHYPERIOR',5500,15,15,15,'SMACK_DOWN','SURF') 
where kill<death and kill_b<death_b
order by kill_b/death_b;

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('RHYPERIOR',5500,15,15,15,'SMACK_DOWN','STONE_EDGE') 
where kill<death and kill_b<death_b
order by kill_b/death_b;

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('LATIAS',5500,15,15,15,'DRAGON_BREATH','OUTRAGE') 
where kill<death and kill_b<death_b
order by kill_b/death_b;

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('LATIOS',5500,15,15,15,'DRAGON_BREATH','DRAGON_CLAW') 
where kill<death and kill_b<death_b
order by kill_b/death_b;


select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('CRESSELIA',5500,15,15,15,'PSYCHO_CUT','MOONBLAST') 
where kill<death and kill_b<death_b
order by kill_b/death_b;

KYOGRE

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('KYOGRE',5500,15,15,15,'WATERFALL','HYDRO_PUMP') 
where kill<death and kill_b<death_b
order by kill_b/death_b;

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('KYOGRE',5500,15,15,15,'WATERFALL','BLIZZARD') 
where kill<death and kill_b<death_b
order by kill_b/death_b;

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('KYOGRE',5500,15,15,15,'DRAGON_TAIL','THUNDER') 
where kill<death and kill_b<death_b
order by kill_b/death_b;

GROUDON

select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('GROUDON',5500,15,15,15,'MUD_SHOT','EARTHQUAKE') 
where kill<death and kill_b<death_b
order by kill_b/death_b;
select jp,fastmove,chargemove,
--set, per, sec, 
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('GROUDON',5500,15,15,15,'MUD_SHOT','SOLAR_BEAM') 
where kill<death and kill_b<death_b
order by kill_b/death_b;

TYRANITAR
select jp,fastmove,chargemove,
dps, kill, death, kill_b, death_b, fdpsp, ofdpsp, x
from calc_counter_combat('TYRANITAR',5500,15,15,15,'BITE','CRUNCH') 
where kill<death and kill_b<death_b
order by kill_b/death_b;
