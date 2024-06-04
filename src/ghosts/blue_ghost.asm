init_bg
    lda #CONST_BG_INIT_TILE_X
    sta m_bg_tile_x
    lda #CONST_BG_INIT_TILE_Y
    sta m_bg_tile_y
    lda #0
    sta m_bg_pixel_x
    sta m_bg_pixel_y

    lda #CONST_DIRECTION_LEFT
    sta m_bg_direction

    lda #CONST_SPRITE_NUMBER_BLUE_GHOST
    jsr sprite_set_number
       
    jsr handle_bg_direction

    jsr sprite_enable
    jsr plot_blue_ghost
    rts 

handle_bg_frightened
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

handle_bg_eaten
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

handle_bg_direction
    lda m_blue_ghost_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    bne _not_frightened
    jsr handle_bg_frightened
    rts
_not_frightened
    lda m_blue_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    jsr handle_bg_eaten
    rts 
_not_eaten
    lda m_bg_direction
    cmp #CONST_DIRECTION_RIGHT
    bne _check_up

    lda m_animation
    cmp #1
    beq _motion_1 
    bne _motion_2
_motion_1
    lda #<CONST_bg_SPRITE_RIGHT_1
    ldx #>CONST_bg_SPRITE_RIGHT_1
    ldy #`CONST_bg_SPRITE_RIGHT_1
    jsr sprite_set_address
    rts
_motion_2
    lda #<CONST_bg_SPRITE_RIGHT_2
    ldx #>CONST_bg_SPRITE_RIGHT_2
    ldy #`CONST_bg_SPRITE_RIGHT_2
    jsr sprite_set_address
rts 

_check_up
    lda m_bg_direction
    cmp #CONST_DIRECTION_UP
    bne _check_left

    lda m_animation
    cmp #1
    beq _motion_1up 
    bne _motion_2up
_motion_1up
    lda #<CONST_bg_SPRITE_UP_1
    ldx #>CONST_bg_SPRITE_UP_1
    ldy #`CONST_bg_SPRITE_UP_1
    jsr sprite_set_address
    rts 
_motion_2up
    lda #<CONST_bg_SPRITE_UP_2
    ldx #>CONST_bg_SPRITE_UP_2
    ldy #`CONST_bg_SPRITE_UP_2
    jsr sprite_set_address
    rts 

_check_left
    lda m_bg_direction
    cmp #CONST_DIRECTION_LEFT
    bne _check_down

    lda m_animation
    cmp #1
    beq _motion_1left 
    bne _motion_2left
_motion_1left
    lda #<CONST_bg_SPRITE_LEFT_1
    ldx #>CONST_bg_SPRITE_LEFT_1
    ldy #`CONST_bg_SPRITE_LEFT_1
    jsr sprite_set_address
    rts 
_motion_2left
    lda #<CONST_bg_SPRITE_LEFT_2
    ldx #>CONST_bg_SPRITE_LEFT_2
    ldy #`CONST_bg_SPRITE_LEFT_2
    jsr sprite_set_address
    rts 
_check_down
    lda m_bg_direction
    cmp #CONST_DIRECTION_DOWN
    bne _end

    lda m_animation
    cmp #1
    beq _motion_1down 
    bne _motion_2down
_motion_1down
    lda #<CONST_bg_SPRITE_DOWN_1
    ldx #>CONST_bg_SPRITE_DOWN_1
    ldy #`CONST_bg_SPRITE_DOWN_1
    jsr sprite_set_address
    rts 
_motion_2down
    lda #<CONST_bg_SPRITE_DOWN_2
    ldx #>CONST_bg_SPRITE_DOWN_2
    ldy #`CONST_bg_SPRITE_DOWN_2
    jsr sprite_set_address
_end
    rts

plot_blue_ghost
    lda #CONST_SPRITE_NUMBER_BLUE_GHOST
    jsr sprite_set_number

    lda m_bg_tile_x
    ldx m_bg_pixel_x
    jsr plot_ghost_x

    lda m_bg_tile_y
    ldx m_bg_pixel_y
    jsr plot_ghost_y
    rts 

handle_bg_movement
    lda m_bg_move
    beq _bg_end
_loop
    jsr bg_auto_move
    dec m_bg_move
    lda m_bg_move
    cmp #0
    bne _loop
_bg_end
    jsr plot_blue_ghost
    rts

bg_auto_move
    lda #CONST_SPRITE_NUMBER_BLUE_GHOST
    jsr sprite_set_number

    lda m_bg_pixel_x
    cmp #0 
    bne _bg_try_move

    lda m_bg_pixel_y
    cmp #0
    bne _bg_try_move 
  
    lda m_bg_direction
    sta m_bg_chosen_direction
    jsr bg_find_available_direction
    lda m_bg_chosen_direction
    sta m_bg_direction
    jsr plot_blue_ghost
    
_bg_try_move
    lda m_blue_ghost_mode
    cmp #CONST_GAME_MODE_SCATTER
    bne _not_scatter
    lda #CONST_SPRITE_PD_3_X
    sta m_pacman_blue_tile_x

    lda #CONST_SPRITE_PD_3_Y
    sta m_pacman_blue_tile_y
    bra _move
_not_scatter
    lda m_blue_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    lda #CONST_GHOST_HOME_TILE_X
    sta m_pacman_blue_tile_x
    lda #CONST_GHOST_HOME_TILE_Y
    sta m_pacman_blue_tile_y
    bra _move
_not_eaten
    cmp #CONST_GAME_MODE_HOME
    bne _not_home
_home_mode
    lda #CONST_GHOST_EXIT_TILE_X
    sta m_pacman_blue_tile_x
    lda #CONST_GHOST_EXIT_TILE_Y
    sta m_pacman_blue_tile_y
    bra _move
_not_home 
    lda m_pacman_tile_y
    sta m_pacman_blue_tile_y
    inc m_pacman_blue_tile_y
    inc m_pacman_blue_tile_y

    lda m_pacman_tile_x
    sta m_pacman_blue_tile_x
    inc m_pacman_blue_tile_x
    inc m_pacman_blue_tile_x

    lda m_pacman_blue_tile_y
    cmp #27
    bcc _move
    lda #27
    sta m_pacman_blue_tile_y

    lda m_pacman_blue_tile_x
    cmp #35
    bcc _move
    lda #35
    sta m_pacman_blue_tile_x
_move
    jsr bg_move_current_direction
    jsr handle_bg_direction
_bg_end
    rts

bg_move_current_direction
    lda m_bg_direction
    cmp #CONST_DIRECTION_RIGHT
    beq _bg_move_right
_bg_check_up 
    jsr check_bg_up
 rts 
_bg_move_right
    lda m_bg_pixel_y
    cmp #0
    bne _bg_end

    lda m_bg_pixel_x
    cmp #7
    beq _bg_move_by_tile
    
    inc m_bg_pixel_x
    bra _bg_plot
_bg_move_by_tile
    inc m_bg_tile_x
    stz m_bg_pixel_x
    
    lda m_bg_tile_x
    cmp #37
    bne _bg_plot 
    lda #3
    sta m_bg_tile_x
    bra _bg_plot
_bg_plot
    rts 
_bg_end
    rts 

check_bg_up
    lda m_bg_direction
    cmp #CONST_DIRECTION_UP
    beq _bg_move_up 
    jsr check_bg_down
    rts 
_bg_move_up
    lda m_bg_pixel_x
    cmp #0
    bne _bg_end
    
    lda m_bg_pixel_y
    cmp #0
    beq _bg_move_by_tile
    dec m_bg_pixel_y
    rts 
_bg_move_by_tile
    dec m_bg_tile_y
    lda #7
    sta m_bg_pixel_y
_bg_end
    rts 

check_bg_down
    lda m_bg_direction
    cmp #CONST_DIRECTION_DOWN
    beq _bg_move_down
    jsr check_bg_left
    rts 
_bg_move_down
    lda m_bg_pixel_x
    cmp #0
    bne _bg_end
    
    lda m_bg_pixel_y
    cmp #7
    beq _bg_move_by_tile
    inc m_bg_pixel_y
    rts 
_bg_move_by_tile
    inc m_bg_tile_y
    stz m_bg_pixel_y
_bg_end
    rts 

check_bg_left
    lda m_bg_direction
    cmp #CONST_DIRECTION_LEFT
    beq _bg_move_left
    rts 
_bg_move_left
    lda m_bg_pixel_y
    cmp #0
    bne _bg_end
    
    lda m_bg_pixel_x 
    cmp #0
    beq _bg_move_by_tile
    dec m_bg_pixel_x
    rts 
_bg_move_by_tile
    dec  m_bg_tile_x
    lda #7
    sta m_bg_pixel_x

    lda m_bg_tile_x
    cmp #3
    bne _bg_end
    lda #37
    sta m_bg_tile_x
    bra _bg_end
_bg_end
    rts 

