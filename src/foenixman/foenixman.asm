init_pm
    lda #CONST_PM_INIT_TILE_X
    sta m_pacman_tile_x
    lda #CONST_PM_INIT_TILE_Y
    sta m_pacman_tile_y
    lda #0
    sta m_pacman_pixel_x
    sta m_pacman_pixel_y

    lda #CONST_DIRECTION_RIGHT
    sta m_pacman_direction
    rts 

handle_pc_sprite
    lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number
    lda m_animation
    cmp #1
    beq _close_mouth
    bne _open_mouth
_close_mouth
    lda #<CONST_PC_SPRITE_COSED
    ldx #>CONST_PC_SPRITE_COSED
    ldy #`CONST_PC_SPRITE_COSED
    jsr sprite_set_address
    rts
_open_mouth
    lda m_pacman_direction
    cmp #CONST_DIRECTION_RIGHT
    bne _check_left
    lda #<CONST_PC_SPRITE_RIGHT
    ldx #>CONST_PC_SPRITE_RIGHT
    ldy #`CONST_PC_SPRITE_RIGHT
    jsr sprite_set_address
    rts
_check_left
    lda m_pacman_direction
    cmp #CONST_DIRECTION_LEFT
    bne _check_up
    lda #<CONST_PC_SPRITE_LEFT
    ldx #>CONST_PC_SPRITE_LEFT
    ldy #`CONST_PC_SPRITE_LEFT
    jsr sprite_set_address
    rts 
_check_up
    lda m_pacman_direction
    cmp #CONST_DIRECTION_UP
    bne _check_down 
    lda #<CONST_PC_SPRITE_UP
    ldx #>CONST_PC_SPRITE_UP
    ldy #`CONST_PC_SPRITE_UP
    jsr sprite_set_address
    rts 
_check_down
    lda m_pacman_direction
    cmp #CONST_DIRECTION_DOWN
    bne _end
    lda #<CONST_PC_SPRITE_DOWN
    ldx #>CONST_PC_SPRITE_DOWN
    ldy #`CONST_PC_SPRITE_DOWN
    jsr sprite_set_address
_end 
    rts

handle_movement
    lda m_pm_move
    cmp #0
    beq _end
_loop
    jsr check_paths
    jsr move_player
    dec m_pm_move
    lda m_pm_move
    cmp #0
    bne _loop 
_end 
    rts 
move_player
    jsr is_joy_b_right_pressed
    bcc _move_pc_right
    bra _check_move_pc_left  
_move_pc_right
    lda m_right_tile_blocked
    cmp #1
    beq _end
    lda #CONST_DIRECTION_RIGHT
    sta m_pacman_direction
    bra _end
_check_move_pc_left 
    jsr is_joy_b_left_pressed
    bcc _move_pc_left
    bra _check_move_pc_up
_move_pc_left
    lda m_left_tile_blocked
    cmp #1
    beq _end
    lda m_left_tile_blocked
    cmp #1
    beq _end
    lda #CONST_DIRECTION_LEFT
    sta m_pacman_direction
    bra _end  

_check_move_pc_up
    jsr is_joy_b_up_pressed
    bcc _move_pc_up  
    bra _check_move_pc_down
_move_pc_up
    lda m_up_tile_blocked
    cmp #1
    beq _end

    lda #CONST_DIRECTION_UP
    sta m_pacman_direction
    bra _end

_check_move_pc_down
    jsr is_joy_b_down_pressed
    bcc _move_pc_down
    bra _end
_move_pc_down
    lda m_down_tile_blocked
    cmp #1
    beq _end

    lda #CONST_DIRECTION_DOWN
    sta m_pacman_direction
_end 
    jsr auto_move
    jsr check_dot
    jsr check_power_dot
    rts 

auto_move
    lda m_pacman_direction
    cmp #CONST_DIRECTION_RIGHT
    bne _check_left
    jsr move_pc_right
    rts
_check_left
    lda m_pacman_direction
    cmp #CONST_DIRECTION_LEFT
    bne _check_up
    jsr move_pc_left
    rts 
_check_up
    lda m_pacman_direction
    cmp #CONST_DIRECTION_UP
    bne _check_down
    jsr move_pc_up
    rts 
_check_down
    lda m_pacman_direction
    cmp #CONST_DIRECTION_DOWN
    bne _end
    jsr move_pc_down
_end

rts 

check_power_dot 
    lda m_pacman_tile_x
    cmp #CONST_SPRITE_PD_1_X
    bne _check_pp_2
    lda m_pacman_tile_y
    cmp #CONST_SPRITE_PD_1_Y
    bne _check_pp_2
    lda p1_pp_eaten
    cmp #1
    bne _not_eaten
    rts
_not_eaten
    lda #CONST_SPRITE_NUMBER_POWER_DOT_1
    jsr sprite_set_number
    jsr sprite_disable
    inc p1_pp_eaten
    jsr play_eat_pp
    jsr game_mode_set_frightened
    rts 
_check_pp_2 
    lda m_pacman_tile_x
    cmp #CONST_SPRITE_PD_2_X
    bne _check_pp_3

    lda m_pacman_tile_y
    cmp #CONST_SPRITE_PD_2_Y
    bne _check_pp_3
  
    lda p1_pp_eaten + 1
    cmp #1
    bne _not_eaten_2
    rts
_not_eaten_2
    lda #CONST_SPRITE_NUMBER_POWER_DOT_2
    jsr sprite_set_number
    jsr sprite_disable
    inc p1_pp_eaten + 1
    jsr play_eat_pp
    jsr game_mode_set_frightened
    rts 
_check_pp_3
    lda m_pacman_tile_x
    cmp #CONST_SPRITE_PD_3_X
    bne _check_pp_4

    lda m_pacman_tile_y
    cmp #CONST_SPRITE_PD_3_Y
    bne _check_pp_4

    lda p1_pp_eaten + 2
    cmp #1
    bne _not_eaten_3
    rts
_not_eaten_3
    lda #CONST_SPRITE_NUMBER_POWER_DOT_3
    jsr sprite_set_number
    jsr sprite_disable
    inc p1_pp_eaten + 2
    jsr play_eat_pp
    jsr play_eat_pp
    jsr game_mode_set_frightened
    rts 
_check_pp_4
    lda m_pacman_tile_x
    cmp #CONST_SPRITE_PD_4_X
    bne _end

    lda m_pacman_tile_y
    cmp #CONST_SPRITE_PD_4_Y
    bne _end
    
    lda p1_pp_eaten + 3
    cmp #1
    beq _end
    lda #CONST_SPRITE_NUMBER_POWER_DOT_4
    jsr sprite_set_number
    jsr sprite_disable
    inc p1_pp_eaten + 3
    jsr play_eat_pp
    jsr game_mode_set_frightened
_end
    rts 

check_dot
    ldx m_pacman_tile_x
    inx 
    ldy m_pacman_tile_y
    iny
    jsr get_tile_number
    txa 
    cmp #57
    beq _eat_dot 
    rts 
_eat_dot 
    jsr play_eat_dot
_play
    ldx m_pacman_tile_x
    inx 
    ldy m_pacman_tile_y
    iny
    jsr change_tile 
    jsr score_dot
    jsr extra_life
    jsr count_dots
    rts 

score_ghost
    inc m_ghost_number_eaten
    lda m_ghost_number_eaten
    cmp #1
    beq _first_ghost

    lda m_ghost_number_eaten
    cmp #2
    beq _second_ghost

    lda m_ghost_number_eaten
    cmp #3
    beq _third_ghost

    lda m_ghost_number_eaten
    cmp #4
    beq _fourth_ghost
    rts 
_first_ghost
    sed
    clc
    lda p1_score
    adc #%00000000
    sta p1_score

    lda p1_score+1
    adc #%00000010
    sta p1_score+1
    
    lda p1_score+2
    adc #0
    sta p1_score+2
    
    lda p1_score+3
    adc #0
    sta p1_score+3
    cld
    rts
_second_ghost
    sed
    clc
    lda p1_score
    adc #%00000000
    sta p1_score
   
    lda p1_score+1
    adc #%00000100
    sta p1_score+1
    
    lda p1_score+2
    adc #0
    sta p1_score+2
    
    lda p1_score+3
    adc #0
    sta p1_score+3
    cld
    rts  
_third_ghost
    sed
    clc
    lda p1_score
    adc #%00000000
    sta p1_score
    lda p1_score+1
    adc #%00001000
    sta p1_score+1
    lda p1_score+2
    adc #0
    sta p1_score+2
    lda p1_score+3
    adc #0
    sta p1_score+3
    cld
   rts  
_fourth_ghost
    sed
    clc
    lda p1_score
    adc #%00000000   
    sta p1_score
    lda p1_score+1
    adc #%00010110
    sta p1_score+1
    lda p1_score+2
    adc #0
    sta p1_score+2
    lda p1_score+3
    adc #0
    sta p1_score+3
    cld
    rts  

score_dot
    sed
    clc
    lda p1_score
    adc #10
    sta p1_score
    lda p1_score+1
    adc #0
    sta p1_score+1
    lda p1_score+2
    adc #0
    sta p1_score+2
    lda p1_score+3
    adc #0
    sta p1_score+3
    cld
    rts 

count_dots 
    clc 
    lda p1_dots_count
    adc #1
    sta p1_dots_count
    lda p1_dots_count+1
    adc #0
    sta p1_dots_count+1

    lda p1_dots_count
    cmp #<262
    bne _end

    lda p1_dots_count + 1
    cmp #>262
    bne _end
    jsr screen_cleared
_end 
rts 

m_extra_life
    .byte 0

extra_life 
    lda m_extra_life
    beq _check_4_extra_life
    rts
_check_4_extra_life
    lda p1_score + 2
    cmp #%000000001
    bcs _add_life 
    rts 
_add_life
    inc p1_lives
    lda #1
    sta m_extra_life
    rts


move_pc_up
    lda m_up_tile_blocked
    cmp #1
    beq _end

    lda m_pacman_pixel_y
    cmp #0
    beq _move_move_pc_tile_up
    bra _move_pixel_up
_move_move_pc_tile_up
    jsr move_pc_tile_up
    bra _end
_move_pixel_up    
    dec m_pacman_pixel_y
_end
    jsr plot_pm
    rts 

move_pc_left
    lda m_left_tile_blocked
    cmp #1
    beq _end

    lda m_pacman_pixel_x
    cmp #0
    beq _move_pc_tile_left
    bra _move_pixel_left
_move_pc_tile_left
    jsr move_pc_tile_left
    bra _end
_move_pixel_left
    dec m_pacman_pixel_x
_end
    jsr plot_pm
    rts 

move_pc_down
    lda m_down_tile_blocked
    cmp #1
    beq _end
    
    lda m_pacman_pixel_y
    cmp #7
    beq _move_pc_tile_down
    bra _move_pc_pixel_down
_move_pc_tile_down
    jsr move_pc_tile_down
    bra _end
_move_pc_pixel_down
    lda m_pacman_pixel_y
    clc
    adc #1
    sta m_pacman_pixel_y
_end
    jsr plot_pm
    rts 

move_pc_right
    lda m_right_tile_blocked
    cmp #1
    beq _end

    lda m_pacman_pixel_x
    cmp #7
    beq _move_pc_tile_right
    bra _move_pixel_right
_move_pc_tile_right
    jsr move_pc_tile_right
    bra _end
_move_pixel_right
    lda m_pacman_pixel_x
    clc
    adc #1
    sta m_pacman_pixel_x
_end
    jsr plot_pm
    rts 

move_pc_tile_right
    stz m_pacman_pixel_x
    lda m_pacman_tile_x
    clc
    adc #1
    sta m_pacman_tile_x
    lda m_pacman_tile_x   
    cmp #37
    bne _end
    lda #3
    sta m_pacman_tile_x
_end 
    jsr plot_pm
    rts 

move_pc_tile_up
    lda #7
    sta m_pacman_pixel_y
    lda m_pacman_tile_y
    dec m_pacman_tile_y
_end 
    jsr plot_pm
    rts 

move_pc_tile_left
    lda m_left_tile_blocked
    cmp #1
    beq _end
    lda #7
    sta m_pacman_pixel_x
    lda m_pacman_tile_x
    dec m_pacman_tile_x

    lda m_pacman_tile_x   
    cmp #3
    bne _end
    lda #37
    sta m_pacman_tile_x
_end 
    jsr plot_pm
    rts 

move_pc_tile_down
    lda m_down_tile_blocked
    cmp #1
    beq _end
    stz m_pacman_pixel_y
    lda m_pacman_tile_y

    inc m_pacman_tile_y
    lda m_pacman_tile_y   
    cmp #$1f
    bne _end
    stz m_pacman_tile_y
_end 
    jsr plot_pm
    rts 
