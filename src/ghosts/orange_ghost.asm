

init_og
    lda #CONST_og_INIT_TILE_X
    sta m_og_tile_x
    lda #CONST_og_INIT_TILE_Y
    sta m_og_tile_y
    lda #0
    sta m_og_pixel_x
    sta m_og_pixel_y

    lda #CONST_DIRECTION_RIGHT
    sta m_og_direction

    lda #CONST_SPRITE_NUMBER_ORANGE_GHOST
    jsr sprite_set_number
    jsr handle_og_direction
    jsr sprite_enable
    jsr plot_orange_ghost
    rts 

handle_og_frightened
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

handle_og_eaten
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

handle_og_direction
    lda m_orange_ghost_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    bne _not_frightened
    jsr handle_og_frightened
    rts
_not_frightened
    lda m_orange_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    jsr handle_og_eaten
    rts 
_not_eaten
    lda m_og_direction
    cmp #CONST_DIRECTION_RIGHT
    bne _check_up
    
    lda m_animation
    cmp #1
    beq _motion_1right 
    bne _motion_2right
_motion_1right
    lda #<CONST_og_SPRITE_RIGHT_1
    ldx #>CONST_og_SPRITE_RIGHT_1
    ldy #`CONST_og_SPRITE_RIGHT_1
    jsr sprite_set_address
    rts
_motion_2right 
    lda #<CONST_og_SPRITE_RIGHT_2
    ldx #>CONST_og_SPRITE_RIGHT_2
    ldy #`CONST_og_SPRITE_RIGHT_2
    jsr sprite_set_address
    rts 
_check_up
    lda m_og_direction
    cmp #CONST_DIRECTION_UP
    bne _check_left

    lda m_animation
    cmp #1
    beq _motion_1up 
    bne _motion_2up
_motion_1up
    lda #<CONST_og_SPRITE_UP_1
    ldx #>CONST_og_SPRITE_UP_1
    ldy #`CONST_og_SPRITE_UP_1
    jsr sprite_set_address
    rts 
_motion_2up
    lda #<CONST_og_SPRITE_UP_2
    ldx #>CONST_og_SPRITE_UP_2
    ldy #`CONST_og_SPRITE_UP_2
    jsr sprite_set_address
    rts 
_check_left
    lda m_og_direction
    cmp #CONST_DIRECTION_LEFT
    bne _check_down

    lda m_animation
    cmp #1
    beq _motion_1left  
    bne _motion_2left 
_motion_1left 
    lda #<CONST_og_SPRITE_LEFT_1
    ldx #>CONST_og_SPRITE_LEFT_1
    ldy #`CONST_og_SPRITE_LEFT_1
    jsr sprite_set_address
    rts 
_motion_2left
    lda #<CONST_og_SPRITE_LEFT_2
    ldx #>CONST_og_SPRITE_LEFT_2
    ldy #`CONST_og_SPRITE_LEFT_2
    jsr sprite_set_address
    rts 
_check_down
    lda m_og_direction
    cmp #CONST_DIRECTION_DOWN
    bne _end
    
    lda m_animation
    cmp #1
    beq _motion_1down  
    bne _motion_2down 
_motion_1down
    lda #<CONST_og_SPRITE_DOWN_1
    ldx #>CONST_og_SPRITE_DOWN_1
    ldy #`CONST_og_SPRITE_DOWN_1
    jsr sprite_set_address
    rts 
_motion_2down 
    lda #<CONST_og_SPRITE_DOWN_2
    ldx #>CONST_og_SPRITE_DOWN_2
    ldy #`CONST_og_SPRITE_DOWN_2
    jsr sprite_set_address
_end
    rts

plot_orange_ghost
    lda #CONST_SPRITE_NUMBER_ORANGE_GHOST
    jsr sprite_set_number

    lda m_og_tile_x
    ldx m_og_pixel_x
    jsr plot_ghost_x

    lda m_og_tile_y
    ldx m_og_pixel_y
    jsr plot_ghost_y

    rts 

handle_og_movement
    lda m_og_move
    cmp #0
    beq _og_end
_loop
    jsr og_auto_move
    dec m_og_move
    lda m_og_move
    cmp #0
    bne _loop
_og_end
    jsr plot_orange_ghost
    rts

og_auto_move
    lda #CONST_SPRITE_NUMBER_ORANGE_GHOST
    jsr sprite_set_number

    lda m_og_pixel_x
    cmp #0 
    bne _og_try_move

    lda m_og_pixel_y
    cmp #0
    bne _og_try_move 
  
    lda m_og_direction
    sta m_og_chosen_direction
    jsr og_find_available_direction
    lda m_og_chosen_direction
    sta m_og_direction
    jsr plot_orange_ghost
    
_og_try_move
    lda m_orange_ghost_mode
    cmp #CONST_GAME_MODE_SCATTER
    bne _not_scatter
    lda #CONST_SPRITE_PD_4_X
    sta m_pacman_orange_tile_x

    lda #CONST_SPRITE_PD_4_Y
    sta m_pacman_orange_tile_y
    bra _move
_not_scatter
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    lda #16
    sta m_pacman_orange_tile_x
    lda #14
    sta m_pacman_orange_tile_y
    bra _move
_not_eaten
    cmp #CONST_GAME_MODE_HOME
    bne _not_home
_home_mode
    lda #CONST_GHOST_EXIT_TILE_X
    sta m_pacman_orange_tile_x
    lda #CONST_GHOST_EXIT_TILE_Y
    sta m_pacman_orange_tile_y
    bra _move
_not_home 
    lda m_pacman_tile_y
    cmp #4
    bcs _set_og_y_target
    lda #1
    sta m_pacman_orange_tile_y
    bra _set_og_x_target 
_set_og_y_target
    sta m_pacman_orange_tile_y
    dec m_pacman_orange_tile_y
    dec m_pacman_orange_tile_y
    dec m_pacman_orange_tile_y
    dec m_pacman_orange_tile_y
_set_og_x_target
    lda m_pacman_tile_x
    sta m_pacman_orange_tile_x

    lda m_pacman_orange_tile_y
    cmp #27
    bcc _move
    lda #27
    sta m_pacman_orange_tile_y
_move
    jsr og_move_current_direction
    jsr handle_og_direction
_og_end
    rts

og_move_current_direction
    lda m_og_direction
    cmp #CONST_DIRECTION_RIGHT
    beq _og_move_right
_og_check_up 
    jsr check_og_up
 rts 
_og_move_right
    lda m_og_pixel_y
    cmp #0
    bne _og_end

    lda m_og_pixel_x
    cmp #7
    beq _og_move_by_tile
    
    inc m_og_pixel_x
    bra _og_plot
_og_move_by_tile
    inc m_og_tile_x
    stz m_og_pixel_x
    
    lda m_og_tile_x
    cmp #37
    bne _og_plot 
    lda #3
    sta m_og_tile_x
    bra _og_plot
_og_plot
    rts 
_og_end
    rts 

check_og_up
    lda m_og_direction
    cmp #CONST_DIRECTION_UP
    beq _og_move_up 
    jsr check_og_down
    rts 
_og_move_up
    lda m_og_pixel_x
    cmp #0
    bne _og_end
    
    lda m_og_pixel_y
    cmp #0
    beq _og_move_by_tile
    dec m_og_pixel_y
    rts 
_og_move_by_tile
    dec m_og_tile_y
    lda #7
    sta m_og_pixel_y
_og_end
    rts 

check_og_down
    lda m_og_direction
    cmp #CONST_DIRECTION_DOWN
    beq _og_move_down
    jsr check_og_left
    rts 
_og_move_down
    lda m_og_pixel_x
    cmp #0
    bne _og_end
    
    lda m_og_pixel_y
    cmp #7
    beq _og_move_by_tile
    inc m_og_pixel_y
    rts 
_og_move_by_tile
    inc m_og_tile_y
    stz m_og_pixel_y
_og_end
    rts 

check_og_left
    lda m_og_direction
    cmp #CONST_DIRECTION_LEFT
    beq _og_move_left
    rts 
_og_move_left
    lda m_og_pixel_y
    cmp #0
    bne _og_end
    
    lda m_og_pixel_x 
    cmp #0
    beq _og_move_by_tile
    dec m_og_pixel_x
    rts 
_og_move_by_tile
    dec  m_og_tile_x
    lda #7
    sta m_og_pixel_x

    lda m_og_tile_x
    cmp #3
    bne _og_end
    lda #37
    sta m_og_tile_x
    bra _og_end
_og_end
    rts 

