plot_pm
    lda m_pacman_tile_x
    ldx #0
    jsr calc_sprite_coords
    sta m_pacman_sp_x
    stx m_pacman_sp_x+1
    
    ;add sprite offset
    lda m_pacman_sp_x
    clc
    adc #24
    sta m_pacman_sp_x
    lda m_pacman_sp_x + 1
    adc #0
    sta m_pacman_sp_x + 1

    ;add 8 for sprite_tileset size differenct
    lda m_pacman_sp_x
    clc
    adc #8
    sta m_pacman_sp_x

    ;substract 8 for tileset offset
    lda m_pacman_sp_x 
    sec 
    sbc #8
    sta m_pacman_sp_x

    ;add pixel offset
    lda m_pacman_sp_x
    clc
    adc m_pacman_pixel_x
    sta m_pacman_sp_x
    lda m_pacman_sp_x + 1
    adc #0
    sta m_pacman_sp_x + 1

_check_y
; Y_____________________________
    lda m_pacman_tile_y
    ldx #0
    jsr calc_sprite_coords
    sta m_pacman_sp_y
    stx m_pacman_sp_y+1

    lda m_pacman_sp_y
    clc 
    adc m_pacman_pixel_y
    sta m_pacman_sp_y

    lda m_pacman_sp_y
    clc 
    adc #32
    sta m_pacman_sp_y
    
    lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number

    lda m_pacman_sp_x
    ldx m_pacman_sp_x+1
    jsr sprite_set_x

    lda m_pacman_sp_y
    ldx m_pacman_sp_y+1
    jsr sprite_set_y

    rts 

;a and x for low and hi
calc_sprite_coords 
   ; lda m_pacman_pixel_x
    sta $DE00 
    lda #0
    sta $DE01
    lda #8
    sta $DE02
    lda #0
    sta $DE03

    lda $DE10
    ldx $DE11
    rts
