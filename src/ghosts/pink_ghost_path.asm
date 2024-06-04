
pg_find_available_direction 
    lda m_pg_direction
    cmp #CONST_DIRECTION_UP
    beq _find_up_direction_paths
    
    lda m_pg_direction
    cmp #CONST_DIRECTION_LEFT
    beq _find_left_direction_paths

    lda m_pg_direction
    cmp #CONST_DIRECTION_RIGHT
    beq _find_right_direction_paths

    lda m_pg_direction
    cmp #CONST_DIRECTION_DOWN
    beq _find_down_direction_paths
    rts
_find_up_direction_paths 
    jsr pg_find_up_direction_paths
    lda m_pg_chosen_direction
    sta m_pg_direction
_end_up
rts 

_find_left_direction_paths
    jsr pg_find_left_direction_paths
    lda m_pg_chosen_direction
    sta m_pg_direction
    rts

_find_right_direction_paths
    jsr pg_find_right_direction_paths
     lda m_pg_chosen_direction
    sta m_pg_direction
_end_right
rts 

_find_down_direction_paths
    jsr pg_find_down_direction_paths
    lda m_pg_chosen_direction
    sta m_pg_direction
_end_down
rts 

pg_find_up_direction_paths
    jsr pg_check_ghost_up 
    jsr pg_check_ghost_right 
    jsr pg_check_ghost_left
    

_init_new_direction
    lda m_pg_up_distance
    sta m_compare
    lda #CONST_DIRECTION_UP
    sta m_pg_chosen_direction

_check_right
    lda m_pg_right_distance
    cmp m_compare
    bcc _right_wins 
    bra _check_left
_right_wins 
    sta m_compare
    lda #CONST_DIRECTION_RIGHT
    sta m_pg_chosen_direction
_check_left
    lda m_pg_left_distance
    cmp m_compare
    bcc _left_wins 
    bra _done
_left_wins
    sta m_compare
    lda #CONST_DIRECTION_LEFT
    sta m_pg_chosen_direction
_done
    rts 


pg_find_left_direction_paths

    jsr pg_check_ghost_left  
    jsr pg_check_ghost_up  
    jsr pg_check_ghost_down

_init_new_direction
    lda m_pg_left_distance
    sta m_compare
    lda #CONST_DIRECTION_LEFT
    sta m_pg_chosen_direction
_check_up
    lda m_pg_up_distance
    cmp m_compare
    bcc _up_wins 
    bra _check_down
_up_wins 
    sta m_compare
    lda #CONST_DIRECTION_UP
    sta m_pg_chosen_direction
_check_down
    lda m_pg_down_distance
    cmp m_compare
    bcc _down_wins 
    bra _done
_down_wins
    sta m_compare
    lda #CONST_DIRECTION_DOWN
    sta m_pg_chosen_direction
_done
    rts 

pg_find_right_direction_paths
    lda m_pink_ghost_mode
    cmp #CONST_GAME_MODE_HOME
    bne _not_home

    lda m_pg_tile_x
    cmp #CONST_GHOST_HOME_TILE_X
    bne _not_home
    lda #CONST_DIRECTION_UP
    sta m_pg_chosen_direction
    rts  
_not_home 

    jsr pg_check_ghost_right  
    jsr pg_check_ghost_up 
    jsr pg_check_ghost_down

_init_new_direction
    lda m_pg_right_distance
    sta m_compare
    lda #CONST_DIRECTION_RIGHT
    sta m_pg_chosen_direction

_check_up
    lda m_pg_up_distance
    cmp m_compare
    bcc _up_wins 
    bra _check_down
_up_wins 
    sta m_compare
    lda #CONST_DIRECTION_UP
    sta m_pg_chosen_direction
_check_down
    lda m_pg_down_distance
    cmp m_compare
    bcc _down_wins 
    bra _done
_down_wins
    sta m_compare
    lda #CONST_DIRECTION_down
    sta m_pg_chosen_direction
_done
    rts 

pg_find_down_direction_paths
    jsr pg_check_ghost_down  
    jsr pg_check_ghost_left 
    jsr pg_check_ghost_right

_init_new_direction
    lda m_pg_down_distance
    sta m_compare
    lda #CONST_DIRECTION_DOWN
    sta m_pg_chosen_direction

_check_left
    lda m_pg_left_distance
    cmp m_compare
    bcc _left_wins 
    bra _check_right
_left_wins 
    sta m_compare
    lda #CONST_DIRECTION_LEFT
    sta m_pg_chosen_direction
_check_right
    lda m_pg_right_distance
    cmp m_compare
    bcc _right_wins 
    bra _done
_right_wins
    sta m_compare
    lda #CONST_DIRECTION_RIGHT
    sta m_pg_chosen_direction
_done
    rts 

pg_check_ghost_up 
    jsr pg_check_up_available
    bcs _blocked
    jsr pg_get_up_distance
    stz m_pg_up_blocked
    rts  
_blocked
    lda #1
    sta m_pg_up_blocked
    lda #$ff
    sta m_pg_up_distance
    rts 

pg_check_ghost_right 
    jsr pg_check_right_available
    bcs _blocked
    jsr pg_get_right_distance
    stz m_pg_right_blocked
    rts  
_blocked 
    lda #1
    sta m_pg_right_blocked
    lda #$ff
    sta m_pg_right_distance
    rts 

pg_check_ghost_down
    jsr pg_check_down_available
    bcs _blocked
    jsr pg_get_down_distance
    stz m_pg_down_blocked
    rts 
_blocked 
    lda #1 
    sta m_pg_down_blocked
    lda #$ff
    sta m_pg_down_distance
rts 

pg_check_ghost_left
    jsr pg_check_left_available
    bcs _blocked
    jsr pg_get_left_distance
    stz m_pg_left_blocked
    rts 
_blocked 
    lda #1 
    sta m_pg_left_blocked
    lda #$ff
    sta m_pg_left_distance
    rts 

pg_get_up_distance
    lda m_pacman_pink_tile_y
    cmp m_pg_tile_y
    bcs _ghost_is_higher
    clc
    lda m_pg_tile_y
    sec
    sbc m_pacman_pink_tile_y
    sta m_pg_up_distance
_end 
    rts
_ghost_is_higher
    clc 
    lda #$f0
    sta m_pg_up_distance
    rts 

pg_get_down_distance
    lda m_pacman_pink_tile_y
    cmp m_pg_tile_y
    bcs _ghost_is_higher
    lda #$f0
    sta m_pg_down_distance
    rts
_ghost_is_higher
    clc
    lda m_pacman_pink_tile_y
    sec
    sbc m_pg_tile_y
    ;lda #$7
    sta m_pg_down_distance
    lda m_pg_down_distance
    cmp #0
    bne _end 
    lda #$f0
    sta m_pg_down_distance
_end
    rts 

pg_get_right_distance
    lda m_pacman_pink_tile_x
    cmp m_pg_tile_x
    bcs _ghost_is_left_of_pacman
    lda #$f0
    sta m_pg_right_distance
    rts
_ghost_is_left_of_pacman
    clc
    lda m_pacman_pink_tile_x
    sec
    sbc m_pg_tile_x
    sta m_pg_right_distance
    lda m_pg_right_distance
    cmp #0
    bne _end
    lda #$f0
    sta m_pg_right_distance
_end
    rts 

pg_get_left_distance
    lda m_pacman_pink_tile_x
    cmp m_pg_tile_x
    bcs _pacman_is_right_of_ghost
    lda m_pg_tile_x
    sec
    sbc m_pacman_pink_tile_x
    sta m_pg_left_distance
_end
    rts
_pacman_is_right_of_ghost
    lda #$f0
    sta m_pg_left_distance
    rts 


pg_check_down_available
     ldx m_pg_tile_x
     ldy m_pg_tile_y
     jsr check_down_tile
     bcs _blocked
     clc
     rts 
_blocked
     sec 
     rts 

pg_check_up_available
    lda m_pink_ghost_mode
    ldx m_pg_tile_x
    ldy m_pg_tile_y
    jsr check_up_tile
    bcs _blocked
    clc 
    rts 
_blocked
     sec 
     rts 
pg_check_left_available
     ldx m_pg_tile_x
     ldy m_pg_tile_y
     jsr check_left_tile
     bcs _blocked
     clc 
     rts 
_blocked
     sec 
     rts

pg_check_right_available
     ldx m_pg_tile_x
     ldy m_pg_tile_y
     jsr check_right_tile
     bcs _blocked
     clc
     rts 
_blocked
     sec 
     rts 