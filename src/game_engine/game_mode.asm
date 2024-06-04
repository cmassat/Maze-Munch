game_mode_set_ghost_home
    lda #CONST_GAME_MODE_HOME
    sta m_game_mode
    sta m_pink_ghost_mode
    sta m_blue_ghost_mode
    sta m_orange_ghost_mode
    sta m_red_ghost_mode
    rts

game_mode_set_frightened
    stz m_ghost_number_eaten
    stz m_ghost_number_eaten+1
    stz m_ghost_number_eaten+2
    stz m_ghost_number_eaten+3
    lda #CONST_GAME_MODE_FRIGHTENED
    sta m_game_mode
    sta m_red_ghost_mode
    #ghost_frightened m_red_ghost_mode
    #ghost_frightened m_pink_ghost_mode
    #ghost_frightened m_blue_ghost_mode
    #ghost_frightened m_orange_ghost_mode
    ;10 seconds 600 frames
    lda p1_screen_num
    cmp #14
    bcs _no_more_blue
    bra _look_up_time
_no_more_blue
    lda #1
    sta m_game_mode_timer
    stz m_game_mode_timer+1
    bra _reverse_ghost_direction
_look_up_time
    lda p1_screen_num
    asl a
    clc
    adc #<m_ghost_blue_timer
    sta POINTER_TABLE_LOOKUP

    lda #>m_ghost_blue_timer
    adc #0
    sta POINTER_TABLE_LOOKUP+1
    ldy #0
    lda (POINTER_TABLE_LOOKUP),y
    sta m_game_mode_timer
    iny
    lda (POINTER_TABLE_LOOKUP),y
    sta m_game_mode_timer+1
_reverse_ghost_direction
    jsr reverse_ghost_direction
    rts

ghost_frightened .macro ghost_mode
    lda \ghost_mode
    cmp #CONST_GAME_MODE_CHASE
    beq _ghost_change_frighened

    cmp #CONST_GAME_MODE_SCATTER
    beq _ghost_change_frighened
    bra _do_not_change
_ghost_change_frighened
    lda #CONST_GAME_MODE_FRIGHTENED
    sta \ghost_mode
_do_not_change
.endmacro

game_mode_set_scatter
    lda #CONST_GAME_MODE_SCATTER
    sta m_game_mode
    jsr reset_free_ghosts

    ; 7 seconds 420 frames
    lda #<420
    sta m_game_mode_timer

    lda #>420
    sta m_game_mode_timer+1
rts

game_mode_set_chase
    lda #CONST_GAME_MODE_CHASE
    sta m_game_mode
    jsr reset_free_ghosts

    ; 20 seconds 1200 frames
    lda #<1200
    sta m_game_mode_timer

    lda #>1200
    sta m_game_mode_timer+1
    rts

reset_eaten_ghosts
    lda m_red_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _red_not_home
    lda m_rg_tile_x
    cmp #CONST_GHOST_HOME_TILE_X
    bne _red_not_home
    lda m_rg_tile_y
    cmp #CONST_GHOST_HOME_TILE_Y
    bne _red_not_home
    lda #CONST_GAME_MODE_SCATTER
    sta m_red_ghost_mode
    lda #CONST_DIRECTION_UP
    sta m_rg_direction
_red_not_home
    lda m_pink_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _pink_not_home
    lda m_pg_tile_x
    cmp #CONST_GHOST_HOME_TILE_X
    bne _pink_not_home
    lda m_pg_tile_y
    cmp #CONST_GHOST_HOME_TILE_Y
    bne _pink_not_home
    lda #CONST_GAME_MODE_SCATTER
    sta m_pink_ghost_mode ;this ok
    lda #CONST_DIRECTION_UP
    sta m_pg_direction
_pink_not_home
    lda m_blue_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _blue_not_home
    lda m_bg_tile_x
    cmp #CONST_GHOST_HOME_TILE_X
    bne _blue_not_home
    lda m_bg_tile_y
    cmp #CONST_GHOST_HOME_TILE_Y
    bne _blue_not_home
    lda #CONST_GAME_MODE_SCATTER
    sta m_blue_ghost_mode ;this ok
    lda #CONST_DIRECTION_UP
    sta m_bg_direction
_blue_not_home
    lda m_orange_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _orange_not_home
    lda m_og_tile_x
    cmp #CONST_GHOST_HOME_TILE_X
    bne _orange_not_home
    lda m_og_tile_y
    cmp #CONST_GHOST_HOME_TILE_Y
    bne _orange_not_home
    lda #CONST_GAME_MODE_SCATTER
    sta m_orange_ghost_mode ;this ok
    lda #CONST_DIRECTION_UP
    sta m_og_direction
_orange_not_home
    rts

reset_home_ghosts
   lda m_pink_ghost_mode
   cmp #CONST_GAME_MODE_HOME
   bne _pink_not_home
   lda m_pg_tile_x
   cmp #CONST_GHOST_EXIT_TILE_X
   bne _pink_not_home
   lda m_pg_tile_y
   cmp #CONST_GHOST_EXIT_TILE_Y
   bne _pink_not_home
   lda m_game_mode
   sta m_pink_ghost_mode
_pink_not_home
    lda m_blue_ghost_mode
    cmp #CONST_GAME_MODE_HOME
    bne _blue_not_home
    lda m_bg_tile_x
    cmp #CONST_GHOST_EXIT_TILE_X
    bne _blue_not_home
    lda m_bg_tile_y
    cmp #CONST_GHOST_EXIT_TILE_Y
    bne _blue_not_home
    lda m_game_mode
    sta m_blue_ghost_mode
_blue_not_home
    lda m_orange_ghost_mode
    cmp #CONST_GAME_MODE_HOME
    bne _orange_not_home
    lda m_og_tile_x
    cmp #CONST_GHOST_EXIT_TILE_X
    bne _orange_not_home
    lda m_og_tile_y
    cmp #CONST_GHOST_EXIT_TILE_Y
    bne _orange_not_home
    lda m_game_mode
    sta m_orange_ghost_mode
_orange_not_home
    rts

set_ghost_mode
    lda m_game_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    beq _end

    lda m_red_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    beq _red_eaten

    cmp #CONST_GAME_MODE_HOME
    beq _red_eaten

    lda m_game_mode
    sta m_red_ghost_mode
_red_eaten
    lda m_pink_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    beq _pink_eaten

    cmp #CONST_GAME_MODE_HOME
    beq _pink_eaten

    lda m_game_mode
    sta m_pink_ghost_mode ; This is ok
_pink_eaten
    lda m_blue_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    beq _blue_eaten

    cmp #CONST_GAME_MODE_HOME
    beq _blue_eaten

    lda m_game_mode
    sta m_blue_ghost_mode ; This is
_blue_eaten
    lda m_orange_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    beq _orange_eaten

    cmp #CONST_GAME_MODE_HOME
    beq _orange_eaten

    lda m_game_mode
    sta m_orange_ghost_mode ; This is
_orange_eaten
_end
    rts

reset_free_ghosts
    lda m_pink_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    beq _pink_eaten
    lda m_game_mode
    ;sta m_pink_ghost_mode
_pink_eaten
    lda m_blue_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    beq _blue_eaten
    lda m_game_mode
   ; sta m_blue_ghost_mode
_blue_eaten
    lda m_orange_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    beq _orange_eaten
    lda m_game_mode
    ;sta m_orange_ghost_mode
_orange_eaten
    lda m_red_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _red_not_eaten
    rts
_red_not_eaten
    lda m_game_mode
    sta m_red_ghost_mode
    rts

game_mode_track_mode
    jsr reset_eaten_ghosts
    jsr reset_home_ghosts
    jsr set_ghost_mode
    lda m_game_mode_timer
    cmp #0
    bne _count_down

    lda m_game_mode_timer+1
    cmp #0
    bne _count_down

    lda m_game_mode
    cmp #CONST_GAME_MODE_SCATTER
    bne _not_scatter
    jsr game_mode_set_chase
    rts
_not_scatter
    lda m_game_mode
    cmp #CONST_GAME_MODE_CHASE
    bne _not_chase
    jsr game_mode_set_scatter
    rts
_not_chase
    lda m_game_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    bne _not_frightened
    jsr game_mode_set_chase
_not_frightened
    rts
_count_down
    sec
    lda m_game_mode_timer
    sbc #1
    sta m_game_mode_timer
    lda m_game_mode_timer+1
    sbc #0
    sta m_game_mode_timer+1
    rts
rts
