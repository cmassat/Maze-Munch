spash_event_processing
    lda m_game_state
    cmp #CONST_STATE_ON
    bne _end
    jsr wait_for_keypress
_end
    rts 

splash_offscreen_processing
    lda m_game_state
    cmp #CONST_STATE_ON
    bne _end
    jsr load_splash
_end 
    rts 


load_splash
    lda #$22
    sta psg_start_note_counter
    jsr sprite_disable_all
    jsr init_splash
    rts 

wait_for_keypress
    lda keypress 
    cmp #$81
    beq _unload_splash 
    rts 
_unload_splash
    jsr vcky_tile_sprite
    stz $D100 
    jsr state_next 
    stz keypress
    rts 
