*= $1000
.include "../game_engine/memory.asm"
psg_start
.include "psg_start.asm"
psg_start_end
psg_start_length = (psg_start_end - psg_start)/3
pal_0
.include "maze_pal.asm"
pal_0_end
pal_0_length = pal_0_end - pal_0

pal_1
.include "sprite_pal.asm"
pal_1_end
pal_1_length = pal_1_end - pal_1

pal_2
.include "splash_pal.asm"
pal_2_end
pal_2_length = pal_2_end - pal_2

pal_3
.include "maze_pal1.asm"
pal_3_end
pal_3_length = pal_3_end - pal_3

*= $10000
map_0
.include "maze_map.asm"
*= $20000
set_0
.include "maze_set.asm"
sprite_0
.include "sprite_sheet.asm"

*=$30000
spash_data
.include "splash_bm0.asm"
.include "splash_bm1.asm"