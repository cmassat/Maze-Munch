
; a reg = tile x 
; x reg = pixel x
plot_ghost_x  
    sta m_ghost_tile_x
    txa 
    sta m_ghost_pixel_x

    lda m_ghost_tile_x
    ASL A
    STA m_ghost_sp_x
    ROL m_ghost_sp_x+1
    ASL A
    STA m_ghost_sp_x
    ROL m_ghost_sp_x+1
    ASL A
    STA m_ghost_sp_x
    ROL m_ghost_sp_x+1

    lda m_ghost_sp_x
    clc
    adc #24
    sta m_ghost_sp_x
    lda m_ghost_sp_x + 1
    adc #0
    sta m_ghost_sp_x + 1

  ;add 8 for sprite_tileset size differenct
    lda m_ghost_sp_x
    clc
    adc #8
    sta m_ghost_sp_x


    ;substract 8 for tileset offset
    lda m_ghost_sp_x 
    sec 
    sbc #8
    sta m_ghost_sp_x
    
    lda m_ghost_pixel_x
    clc 
    adc m_ghost_sp_x
    sta m_ghost_sp_x
    lda m_ghost_sp_x + 1
    adc #0
    sta m_ghost_sp_x + 1

      
    lda m_ghost_sp_x
    ldx m_ghost_sp_x+1
    jsr sprite_set_x
rts

; a reg = tile y
; x reg = pixel y
plot_ghost_y
    sta m_ghost_tile_y
    txa
    sta m_ghost_pixel_y

    lda m_ghost_tile_y
    ASL A
    STA m_ghost_sp_y
    ROL m_ghost_sp_y+1
    ASL A
    STA m_ghost_sp_y
    ROL m_ghost_sp_y+1
    ASL A
    STA m_ghost_sp_y
    ROL m_ghost_sp_y+1

    lda m_ghost_pixel_y
    clc 
    adc m_ghost_sp_y
    sta m_ghost_sp_y

    lda m_ghost_sp_y
    clc 
    adc #32
    sta m_ghost_sp_y

    lda m_ghost_sp_y
    ldx m_ghost_sp_y+1
    jsr sprite_set_y
    rts 