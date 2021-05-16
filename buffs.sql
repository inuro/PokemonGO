with a as(
    select *, 
    buff * (attacker_at + attacker_df) as at_buff, 
    buff*(target_at + target_df) as tg_buff 
from _chargemove_combat where buff>0
) select * from a order by at_buff,tg_buff;

