
; a reg = tile x 
; x reg = pixel x
plot_pink_ghost_x  
    lda m_pg_tile_x
    ASL A
    STA m_pink_ghost_sp_x
    ROL m_pink_ghost_sp_x+1
    ASL A
    STA m_pink_ghost_sp_x
    ROL m_pink_ghost_sp_x+1
    ASL A
    STA m_pink_ghost_sp_x
    ROL m_pink_ghost_sp_x+1

    lda m_pink_ghost_sp_x
    clc
    adc #24
    sta m_pink_ghost_sp_x
    lda m_pink_ghost_sp_x + 1
    adc #0
    sta m_pink_ghost_sp_x + 1

    lda m_pink_ghost_sp_x
    clc
    adc #8
    sta m_pink_ghost_sp_x

    lda m_pink_ghost_sp_x 
    sec 
    sbc #8
    sta m_pink_ghost_sp_x
    
    lda m_pg_pixel_x
    clc 
    adc m_pink_ghost_sp_x
    sta m_pink_ghost_sp_x
    lda m_pink_ghost_sp_x + 1
    adc #0
    sta m_pink_ghost_sp_x + 1
  rts

; a reg = tile y
; x reg = pixel y
plot_pink_ghost_y
    lda m_pg_tile_y
    ASL A
    STA m_pink_ghost_sp_y
    ROL m_pink_ghost_sp_y+1
    ASL A
    STA m_pink_ghost_sp_y
    ROL m_pink_ghost_sp_y+1
    ASL A
    STA m_pink_ghost_sp_y
    ROL m_pink_ghost_sp_y+1

    sta m_pink_ghost_sp_y
    stx m_pink_ghost_sp_y+1

    lda m_pg_pixel_y
    clc 
    adc m_pink_ghost_sp_y
    sta m_pink_ghost_sp_y

    lda m_pink_ghost_sp_y
    clc 
    adc #32
    sta m_pink_ghost_sp_y

    lda m_pink_ghost_sp_x
    ldx m_pink_ghost_sp_x+1
    jsr sprite_set_x
    
    lda m_pink_ghost_sp_y
    ldx m_pink_ghost_sp_y+1
    jsr sprite_set_y
    rts 