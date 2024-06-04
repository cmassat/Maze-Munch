

init_rg
    lda #CONST_RG_INIT_TILE_X
    sta m_rg_tile_x
    lda #CONST_RG_INIT_TILE_Y
    sta m_rg_tile_y
    lda #0
    sta m_rg_pixel_x
    sta m_rg_pixel_y

    lda #CONST_DIRECTION_RIGHT
    sta m_rg_direction

    lda #CONST_SPRITE_NUMBER_RED_GHOST
    jsr sprite_set_number
    jsr handle_rg_direction
    jsr sprite_enable
    jsr plot_red_ghost
    rts 

handle_rg_frightened
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

handle_rg_eaten
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

handle_rg_direction
    lda m_red_ghost_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    bne _not_frightened
    jsr handle_rg_frightened
    rts
_not_frightened
    lda m_red_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    jsr handle_rg_eaten
    rts 
_not_eaten
    lda m_rg_direction
    cmp #CONST_DIRECTION_RIGHT
    bne _check_up
    
    lda m_animation
    cmp #1
    beq _motion_1right 
    bne _motion_2right
_motion_1right
    lda #<CONST_rg_SPRITE_RIGHT_1
    ldx #>CONST_rg_SPRITE_RIGHT_1
    ldy #`CONST_rg_SPRITE_RIGHT_1
    jsr sprite_set_address
    rts
_motion_2right
    lda #<CONST_rg_SPRITE_RIGHT_2
    ldx #>CONST_rg_SPRITE_RIGHT_2
    ldy #`CONST_rg_SPRITE_RIGHT_2
    jsr sprite_set_address
    rts 

_check_up
    lda m_rg_direction
    cmp #CONST_DIRECTION_UP
    bne _check_left

    lda m_animation
    cmp #1
    beq _motion_1up 
    bne _motion_2up
_motion_1up
    lda #<CONST_rg_SPRITE_UP_1
    ldx #>CONST_rg_SPRITE_UP_1
    ldy #`CONST_rg_SPRITE_UP_1
    jsr sprite_set_address
    rts 
_motion_2up
    lda #<CONST_rg_SPRITE_UP_2
    ldx #>CONST_rg_SPRITE_UP_2
    ldy #`CONST_rg_SPRITE_UP_2
    jsr sprite_set_address
    rts 

_check_left
    lda m_rg_direction
    cmp #CONST_DIRECTION_LEFT
    bne _check_down

    lda m_animation
    cmp #1
    beq _motion_1left  
    bne _motion_2left 
_motion_1left 
    lda #<CONST_rg_SPRITE_LEFT_1
    ldx #>CONST_rg_SPRITE_LEFT_1
    ldy #`CONST_rg_SPRITE_LEFT_1
    jsr sprite_set_address
    rts 
_motion_2left 
    lda #<CONST_rg_SPRITE_LEFT_2
    ldx #>CONST_rg_SPRITE_LEFT_2
    ldy #`CONST_rg_SPRITE_LEFT_2
    jsr sprite_set_address
    rts 
_check_down
    lda m_rg_direction
    cmp #CONST_DIRECTION_DOWN
    bne _end
    
    lda m_animation
    cmp #1
    beq _motion_1down 
    bne _motion_2down 
_motion_1down 
    lda #<CONST_rg_SPRITE_DOWN_1
    ldx #>CONST_rg_SPRITE_DOWN_1
    ldy #`CONST_rg_SPRITE_DOWN_1
    jsr sprite_set_address
    rts 
_motion_2down
    lda #<CONST_rg_SPRITE_DOWN_2
    ldx #>CONST_rg_SPRITE_DOWN_2
    ldy #`CONST_rg_SPRITE_DOWN_2
    jsr sprite_set_address
_end
    rts

plot_red_ghost
    lda #CONST_SPRITE_NUMBER_RED_GHOST
    jsr sprite_set_number

    lda m_rg_tile_x
    ldx m_rg_pixel_x
    jsr plot_ghost_x

    lda m_rg_tile_y
    ldx m_rg_pixel_y
    jsr plot_ghost_y
    rts 

handle_rg_movement
    lda m_rg_move
    beq _rg_end
_loop
    jsr rg_auto_move
    dec m_rg_move
    lda m_rg_move
    cmp #0
    bne _loop
_rg_end
    jsr plot_red_ghost
    rts

rg_auto_move
    lda #CONST_SPRITE_NUMBER_RED_GHOST
    jsr sprite_set_number

    lda m_rg_pixel_x
    cmp #0 
    bne _rg_try_move

    lda m_rg_pixel_y
    cmp #0
    bne _rg_try_move 
  
    lda m_rg_direction
    sta m_rg_chosen_direction
    jsr rg_find_available_direction
    lda m_rg_chosen_direction
    sta m_rg_direction
    jsr plot_red_ghost
_rg_try_move
_try_move
    lda m_red_ghost_mode
    cmp #CONST_GAME_MODE_SCATTER
    bne _not_scatter
_scatter_mode 
    lda #CONST_SPRITE_PD_1_X
    sta m_pacman_red_tile_x

    lda #CONST_SPRITE_PD_1_Y
    sta m_pacman_red_tile_y
    bra _move
_not_scatter
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
_eaten_mode
    lda #CONST_GHOST_HOME_TILE_X
    sta m_pacman_red_tile_x
    lda #CONST_GHOST_HOME_TILE_Y
    sta m_pacman_red_tile_y
    bra _move
_not_eaten
    cmp #CONST_GAME_MODE_HOME
    bne _not_home
_home_mode
    lda #20
    sta m_pacman_red_tile_x
    lda #11
    sta m_pacman_red_tile_y
    bra _move
_not_home 

_set_ghost_path
    lda m_pacman_tile_x
    sta m_pacman_red_tile_x

    lda m_pacman_tile_y
    sta m_pacman_red_tile_y
    lda m_pacman_red_tile_x
    cmp #35
    bcc _move
    lda #35
    sta m_pacman_red_tile_y
_move
    jsr rg_move_current_direction
    jsr handle_rg_direction
_rg_end
    rts

rg_move_current_direction
    lda m_rg_direction
    cmp #CONST_DIRECTION_RIGHT
    beq _rg_move_right
_rg_check_up 
    jsr check_rg_up
 rts 
_rg_move_right
    lda m_rg_pixel_y
    cmp #0
    bne _rg_end

    lda m_rg_pixel_x
    cmp #7
    beq _rg_move_by_tile
    
    inc m_rg_pixel_x
    bra _rg_plot
_rg_move_by_tile
    inc m_rg_tile_x
    stz m_rg_pixel_x
    
    lda m_rg_tile_x
    cmp #37
    bne _rg_plot 
    lda #3
    sta m_rg_tile_x
    bra _rg_plot
_rg_plot
    rts 
_rg_end
    rts 

check_rg_up
    lda m_rg_direction
    cmp #CONST_DIRECTION_UP
    beq _rg_move_up 
    jsr check_rg_down
    rts 
_rg_move_up
    lda m_rg_pixel_x
    cmp #0
    bne _rg_end
    
    lda m_rg_pixel_y
    cmp #0
    beq _rg_move_by_tile
    dec m_rg_pixel_y
    rts 
_rg_move_by_tile
    dec m_rg_tile_y
    lda #7
    sta m_rg_pixel_y
_rg_end
    rts 

check_rg_down
    lda m_rg_direction
    cmp #CONST_DIRECTION_DOWN
    beq _rg_move_down
    jsr check_rg_left
    rts 
_rg_move_down
    lda m_rg_pixel_x
    cmp #0
    bne _rg_end
    
    lda m_rg_pixel_y
    cmp #7
    beq _rg_move_by_tile
    inc m_rg_pixel_y
    rts 
_rg_move_by_tile
    inc m_rg_tile_y
    stz m_rg_pixel_y
_rg_end
    rts 

check_rg_left
    lda m_rg_direction
    cmp #CONST_DIRECTION_LEFT
    beq _rg_move_left
    rts 
_rg_move_left
    lda m_rg_pixel_y
    cmp #0
    bne _rg_end
    
    lda m_rg_pixel_x 
    cmp #0
    beq _rg_move_by_tile
    dec m_rg_pixel_x
    rts 
_rg_move_by_tile
    dec  m_rg_tile_x
    lda #7
    sta m_rg_pixel_x

    lda m_rg_tile_x
    cmp #3
    bne _rg_end
    lda #37
    sta m_rg_tile_x
    bra _rg_end
_rg_end
    rts 