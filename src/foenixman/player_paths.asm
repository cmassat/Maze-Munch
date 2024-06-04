check_paths
    jsr check_right
    jsr check_up
    jsr check_down
    jsr check_left
    rts

check_left
    lda m_pacman_pixel_y
    cmp #0
    bne _block_left 

    lda m_pacman_pixel_x
    cmp #0  
    bne _end 
    lda m_pacman_tile_x 
    sta m_next_tile_x
    dec m_next_tile_x

    lda m_pacman_tile_y
    sta m_next_tile_y

    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_tile_good
    bcs _block_left

    inc m_next_tile_y
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_tile_good
    bcs _block_left
_end
    stz m_left_tile_blocked
    rts 
_block_left
    lda #1
    sta m_left_tile_blocked
    rts

check_down
    lda m_pacman_pixel_x
    cmp #0
    bne _block_down
    jsr get_down_tile
    jsr is_tile_good
    bcs _block_down

    lda m_pacman_tile_x
    clc
    adc #1
    sta m_next_tile_x
    lda m_pacman_tile_y
    clc
    adc #2
    sta m_next_tile_y
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_tile_good
    bcs _block_down

    stz m_down_tile_blocked
    rts 
_block_down
    lda #1
    sta m_down_tile_blocked
    rts

check_right
    lda m_pacman_pixel_y
    cmp #0
    bne _block_right

    lda m_pacman_pixel_x
    cmp #0
    bne _end

    lda m_pacman_tile_x
    sta m_next_tile_x
    inc m_next_tile_x
    inc m_next_tile_x

    lda m_pacman_tile_y
    sta m_next_tile_y

    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_tile_good
    bcs _block_right

    inc m_next_tile_y
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_tile_good
    bcs _block_right
_end
    stz m_right_tile_blocked
    rts
_block_right
    lda #1
    sta m_right_tile_blocked
    rts

check_up
    lda m_pacman_pixel_x
    cmp #0
    bne _block_up

    lda m_pacman_pixel_y
    cmp #0
    bne _end

    lda m_pacman_tile_y
    sta m_next_tile_y
    dec m_next_tile_y
    lda m_pacman_tile_x
    sta m_next_tile_x
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_tile_good
    bcs _block_up

    inc m_next_tile_x
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    jsr is_tile_good
    bcs _block_up
_end
    stz m_up_tile_blocked
    rts
_block_up
    lda #1
    sta m_up_tile_blocked
    rts

get_down_tile
    lda m_pacman_tile_y
    clc 
    adc #2
    sta m_next_tile_y
    lda m_pacman_tile_x
    sta m_next_tile_x
    
    ldx m_next_tile_x
    ldy m_next_tile_y
    jsr get_tile_number
    rts 

is_tile_good
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
    sec 
    rts 
_yes
    clc
    rts