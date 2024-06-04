.include "./data/data.asm"
*= $2000
main
jsr start 
.include "./api/api.asm"
.include "events.asm"
.include "init.asm"
.include "./game_engine/includes.asm"
.include "./ghosts/includes.asm"
.include "./foenixman/includes.asm"
.include "./sounds/sound.asm"

start
    lda #CONST_STATE_ON
    sta m_game_state
    jsr init_events
    jsr set_frame_timer
    jsr handle_events
_loop
    jsr set_frame_timer
    bra _loop
rts 

main_data_memory
event	.dstruct	 kernel.event.event_t
keypress
   .byte 0