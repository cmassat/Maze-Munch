

init_pg
    lda #CONST_PG_INIT_TILE_X
    sta m_pg_tile_x
    lda #CONST_PG_INIT_TILE_Y
    sta m_pg_tile_y
    lda #0
    sta m_pg_pixel_x
    sta m_pg_pixel_y

    lda #CONST_DIRECTION_RIGHT
    sta m_pg_direction

    lda #CONST_SPRITE_NUMBER_PINK_GHOST
    jsr sprite_set_number
    jsr handle_pg_direction
    jsr sprite_enable
    jsr plot_pink_ghost
    rts 

handle_pg_frightened
    lda m_animation
    cmp #1
    beq _motion_1 
    bne _motion_2
_motion_1
    jsr blink_white
    bcc _white_motion1
    lda #<CONST_FR_SPRITE_BLUE_1
    ldx #>CONST_FR_SPRITE_BLUE_1
    ldy #`CONST_FR_SPRITE_BLUE_1
    jsr sprite_set_address
    rts
_white_motion1
    lda #<CONST_FR_SPRITE_WHITE_1
    ldx #>CONST_FR_SPRITE_WHITE_1
    ldy #`CONST_FR_SPRITE_WHITE_1
    jsr sprite_set_address
    rts
_motion_2
    lda #<CONST_FR_SPRITE_BLUE_2
    ldx #>CONST_FR_SPRITE_BLUE_2
    ldy #`CONST_FR_SPRITE_BLUE_2
    jsr sprite_set_address
rts 

handle_pg_eaten
    lda m_animation
    cmp #1
    beq _motion_1 
    bne _motion_2
_motion_1
    lda #<CONST_EYE_SPRITE_RIGHT
    ldx #>CONST_EYE_SPRITE_RIGHT
    ldy #`CONST_EYE_SPRITE_RIGHT
    jsr sprite_set_address
    rts
_motion_2
    lda #<CONST_EYE_SPRITE_LEFT
    ldx #>CONST_EYE_SPRITE_LEFT
    ldy #`CONST_EYE_SPRITE_LEFT
    jsr sprite_set_address
    rts

handle_pg_direction
    lda m_pink_ghost_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    bne _not_frightened
    jsr handle_pg_frightened
    rts
_not_frightened
    lda m_pink_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    jsr handle_pg_eaten
    rts 
_not_eaten
    lda m_pg_direction
    cmp #CONST_DIRECTION_RIGHT
    bne _check_up
    
    lda m_animation
    cmp #1
    beq _motion_1right 
    bne _motion_2right
_motion_1right
    lda #<CONST_PG_SPRITE_RIGHT_1
    ldx #>CONST_PG_SPRITE_RIGHT_1
    ldy #`CONST_PG_SPRITE_RIGHT_1
    jsr sprite_set_address
    rts
_motion_2right 
    lda #<CONST_PG_SPRITE_RIGHT_2
    ldx #>CONST_PG_SPRITE_RIGHT_2
    ldy #`CONST_PG_SPRITE_RIGHT_2
    jsr sprite_set_address
    rts 
_check_up
    lda m_pg_direction
    cmp #CONST_DIRECTION_UP
    bne _check_left

    lda m_animation
    cmp #1
    beq _motion_1up 
    bne _motion_2up
_motion_1up
    lda #<CONST_PG_SPRITE_UP_1
    ldx #>CONST_PG_SPRITE_UP_1
    ldy #`CONST_PG_SPRITE_UP_1
    jsr sprite_set_address
    rts 
_motion_2up
    lda #<CONST_PG_SPRITE_UP_2
    ldx #>CONST_PG_SPRITE_UP_2
    ldy #`CONST_PG_SPRITE_UP_2
    jsr sprite_set_address
    rts 
_check_left
    lda m_pg_direction
    cmp #CONST_DIRECTION_LEFT
    bne _check_down

    lda m_animation
    cmp #1
    beq _motion_1left  
    bne _motion_2left 
_motion_1left 
    lda #<CONST_PG_SPRITE_LEFT_1
    ldx #>CONST_PG_SPRITE_LEFT_1
    ldy #`CONST_PG_SPRITE_LEFT_1
    jsr sprite_set_address
    rts 
_motion_2left
    lda #<CONST_PG_SPRITE_LEFT_2
    ldx #>CONST_PG_SPRITE_LEFT_2
    ldy #`CONST_PG_SPRITE_LEFT_2
    jsr sprite_set_address
    rts 
_check_down
    lda m_pg_direction
    cmp #CONST_DIRECTION_DOWN
    bne _end
    
    lda m_animation
    cmp #1
    beq _motion_1down  
    bne _motion_2down 
_motion_1down
    lda #<CONST_PG_SPRITE_DOWN_1
    ldx #>CONST_PG_SPRITE_DOWN_1
    ldy #`CONST_PG_SPRITE_DOWN_1
    jsr sprite_set_address
    rts 
_motion_2down 
    lda #<CONST_PG_SPRITE_DOWN_2
    ldx #>CONST_PG_SPRITE_DOWN_2
    ldy #`CONST_PG_SPRITE_DOWN_2
    jsr sprite_set_address
_end
    rts

plot_pink_ghost
    lda #CONST_SPRITE_NUMBER_PINK_GHOST
    jsr sprite_set_number

    lda m_pg_tile_x
    ldx m_pg_pixel_x
    jsr plot_ghost_x

    lda m_pg_tile_y
    ldx m_pg_pixel_y
    jsr plot_ghost_y
    rts 

handle_pg_movement
    lda m_pg_move
    beq _pg_end
_loop
    jsr pg_auto_move
    dec m_pg_move
    lda m_pg_move
    cmp #0
    bne _loop
_pg_end
    jsr plot_pink_ghost
    rts

pg_auto_move
    lda #CONST_SPRITE_NUMBER_PINK_GHOST
    jsr sprite_set_number

    lda m_pg_pixel_x
    cmp #0 
    bne _pg_try_move

    lda m_pg_pixel_y
    cmp #0
    bne _pg_try_move 
  
    lda m_pg_direction
    sta m_pg_chosen_direction
    jsr pg_find_available_direction
    lda m_pg_chosen_direction
    sta m_pg_direction
    jsr plot_pink_ghost
    
_pg_try_move
    lda m_pink_ghost_mode
    cmp #CONST_GAME_MODE_SCATTER
    bne _not_scatter
    lda #CONST_SPRITE_PD_2_X
    sta m_pacman_pink_tile_x

    lda #CONST_SPRITE_PD_2_Y
    sta m_pacman_pink_tile_y
    bra _move
_not_scatter
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    lda #16
    sta m_pacman_pink_tile_x
    lda #14
    sta m_pacman_pink_tile_y
    bra _move
_not_eaten
    cmp #CONST_GAME_MODE_HOME
    bne _not_home
_home_mode
    lda #CONST_GHOST_EXIT_TILE_X
    sta m_pacman_pink_tile_x
    lda #CONST_GHOST_EXIT_TILE_Y
    sta m_pacman_pink_tile_y
    bra _move
_not_home 
    lda m_pacman_tile_y
    sta m_pacman_pink_tile_y


    lda m_pacman_tile_x
    inc a
    inc a
    inc a
    sta m_pacman_pink_tile_x

    lda m_pacman_pink_tile_x
    cmp #35
    bcc _move
    lda #35
    sta m_pacman_pink_tile_x
_move
    jsr pg_move_current_direction
    jsr handle_pg_direction
_pg_end
    rts

pg_move_current_direction
    lda m_pg_direction
    cmp #CONST_DIRECTION_RIGHT
    beq _pg_move_right
_pg_check_up 
    jsr check_pg_up
 rts 
_pg_move_right
    lda m_pg_pixel_y
    cmp #0
    bne _pg_end

    lda m_pg_pixel_x
    cmp #7
    beq _pg_move_by_tile
    
    inc m_pg_pixel_x
    bra _pg_plot
_pg_move_by_tile
    inc m_pg_tile_x
    stz m_pg_pixel_x
    
    lda m_pg_tile_x
    cmp #37
    bne _pg_plot 
    lda #3
    sta m_pg_tile_x
    bra _pg_plot
_pg_plot
    rts 
_pg_end
    rts 

check_pg_up
    lda m_pg_direction
    cmp #CONST_DIRECTION_UP
    beq _pg_move_up 
    jsr check_pg_down
    rts 
_pg_move_up
    lda m_pg_pixel_x
    cmp #0
    bne _pg_end
    
    lda m_pg_pixel_y
    cmp #0
    beq _pg_move_by_tile
    dec m_pg_pixel_y
    rts 
_pg_move_by_tile
    dec m_pg_tile_y
    lda #7
    sta m_pg_pixel_y
_pg_end
    rts 

check_pg_down
    lda m_pg_direction
    cmp #CONST_DIRECTION_DOWN
    beq _pg_move_down
    jsr check_pg_left
    rts 
_pg_move_down
    lda m_pg_pixel_x
    cmp #0
    bne _pg_end
    
    lda m_pg_pixel_y
    cmp #7
    beq _pg_move_by_tile
    inc m_pg_pixel_y
    rts 
_pg_move_by_tile
    inc m_pg_tile_y
    stz m_pg_pixel_y
_pg_end
    rts 

check_pg_left
    lda m_pg_direction
    cmp #CONST_DIRECTION_LEFT
    beq _pg_move_left
    rts 
_pg_move_left
    lda m_pg_pixel_y
    cmp #0
    bne _pg_end
    
    lda m_pg_pixel_x 
    cmp #0
    beq _pg_move_by_tile
    dec m_pg_pixel_x
    rts 
_pg_move_by_tile
    dec  m_pg_tile_x
    lda #7
    sta m_pg_pixel_x

    lda m_pg_tile_x
    cmp #3
    bne _pg_end
    lda #37
    sta m_pg_tile_x
    bra _pg_end
_pg_end
    rts 

