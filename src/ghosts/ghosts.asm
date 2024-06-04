

handle_ghost_movement
    jsr handle_rg_movement
    jsr handle_pg_movement    
    jsr handle_bg_movement   
    jsr handle_og_movement
    rts

reverse_ghost_direction
    jsr reverse_red_ghost
    jsr reverse_pink_ghost
    jsr reverse_blue_ghost
    jsr reverse_orange_ghost
    rts

reverse_red_ghost 
    lda m_rg_direction
    cmp #CONST_DIRECTION_UP
    beq _down

    cmp #CONST_DIRECTION_DOWN
    beq _up

    cmp #CONST_DIRECTION_LEFT
    beq _right

    cmp #CONST_DIRECTION_RIGHT
    beq _left
    rts 
_left
    lda #CONST_DIRECTION_RIGHT
    sta m_rg_direction
    rts
_right
    lda #CONST_DIRECTION_RIGHT
    sta m_rg_direction
    rts
_up
    lda #CONST_DIRECTION_DOWN
    sta m_rg_direction
    rts
_down 
    lda #CONST_DIRECTION_DOWN
    sta m_rg_direction
    rts

reverse_pink_ghost
    lda m_pg_direction
    cmp #CONST_DIRECTION_UP
    beq _down

    cmp #CONST_DIRECTION_DOWN
    beq _up

    cmp #CONST_DIRECTION_LEFT
    beq _right

    cmp #CONST_DIRECTION_RIGHT
    beq _left
    rts 
_left
    lda #CONST_DIRECTION_RIGHT
    sta m_pg_direction
    rts
_right
    lda #CONST_DIRECTION_RIGHT
    sta m_pg_direction
    rts
_up
    lda #CONST_DIRECTION_DOWN
    sta m_pg_direction
    rts
_down 
    lda #CONST_DIRECTION_DOWN
    sta m_pg_direction
    rts

reverse_blue_ghost
    lda m_bg_direction
    cmp #CONST_DIRECTION_UP
    beq _down

    cmp #CONST_DIRECTION_DOWN
    beq _up

    cmp #CONST_DIRECTION_LEFT
    beq _right

    cmp #CONST_DIRECTION_RIGHT
    beq _left
    rts 
_left
    lda #CONST_DIRECTION_RIGHT
    sta m_bg_direction
    rts
_right
    lda #CONST_DIRECTION_RIGHT
    sta m_bg_direction
    rts
_up
    lda #CONST_DIRECTION_DOWN
    sta m_bg_direction
    rts
_down 
    lda #CONST_DIRECTION_DOWN
    sta m_bg_direction
    rts
reverse_orange_ghost
    lda m_og_direction
    cmp #CONST_DIRECTION_UP
    beq _down

    cmp #CONST_DIRECTION_DOWN
    beq _up

    cmp #CONST_DIRECTION_LEFT
    beq _right

    cmp #CONST_DIRECTION_RIGHT
    beq _left
    rts 
_left
    lda #CONST_DIRECTION_RIGHT
    sta m_og_direction
    rts
_right
    lda #CONST_DIRECTION_RIGHT
    sta m_og_direction
    rts
_up
    lda #CONST_DIRECTION_DOWN
    sta m_og_direction
    rts
_down 
    lda #CONST_DIRECTION_DOWN
    sta m_og_direction
    rts 

check_up_tile
    sta m_tile_game_mode
    sty m_next_tile_y
    dec m_next_tile_y
    stx m_next_tile_x
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_ghost_tile_good
    bcs _end
    inc m_next_tile_x
    
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_ghost_tile_good
    bcs _end
    clc
    rts
_end
    sec 
    rts 

check_right_tile
    sty m_next_tile_y

    stx m_next_tile_x
    inc m_next_tile_x
    inc m_next_tile_x
    
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_ghost_tile_good
    bcs _end
    
    inc m_next_tile_y
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_ghost_tile_good
    bcs _end
    clc
    rts
_end
    sec 
    rts 

check_down_tile
    sty m_next_tile_y
    stx m_next_tile_x
_continue
    inc m_next_tile_y
    inc m_next_tile_y
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_ghost_tile_good
    bcs _end
    
    inc m_next_tile_x
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_ghost_tile_good
    bcs _end
    clc
    rts
_end
    sec 
    rts 


check_left_tile
    sty m_next_tile_y
    stx m_next_tile_x

    dec m_next_tile_x
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_ghost_tile_good
    bcs _end
    
    inc m_next_tile_y
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_ghost_tile_good
    bcs _end
    clc
    rts
_end
    sec 
    rts 


is_tile_tunnel 
    lda m_calc_tile_number
    cmp #40
    beq _yes
    sec
    rts 
_yes
    clc 
    rts 
is_ghost_tile_good
    lda m_calc_tile_number
    cmp #0
    beq _yes

    lda m_calc_tile_number
    cmp #57
    beq _yes

    lda m_calc_tile_number
    cmp #81
    beq _yes

    lda m_calc_tile_number
    cmp #40
    beq _yes

_check_game_mode_home
    lda m_tile_game_mode
    cmp #CONST_GAME_MODE_HOME
    bne _check_game_mode_eaten
    beq _no 
_check_game_mode_eaten 
    lda m_tile_game_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _no 
    lda m_calc_tile_number
    cmp #18
    beq _yes
_no 
    sec 
    rts 
_yes
    clc
    rts
