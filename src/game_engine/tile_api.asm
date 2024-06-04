change_tile
    stx m_calc_tile_number_x
    sty m_calc_tile_number_y
    
    lda #$b3
    sta MMU_MEM_CTRL

    lda #<MMU_BANK_5_RAM_ADDR
    sta POINTER_MMU
    lda #>MMU_BANK_5_RAM_ADDR
    sta POINTER_MMU+1

    lda m_calc_tile_number_y
    cmp #0
    beq _add_x

    ldx #0
    clc
_8multiply
    lda POINTER_MMU
    adc #80
    sta POINTER_MMU
    lda POINTER_MMU+1
    adc #0
    sta POINTER_MMU+1
    inx
    cpx m_calc_tile_number_y
    bne _8multiply
_add_x
    ldx #0
    clc
 _xmultiply
     lda POINTER_MMU
     adc m_calc_tile_number_x
     sta POINTER_MMU
     lda POINTER_MMU+1
     adc #0
     sta POINTER_MMU+1
     inx
     cpx #2
     bne _xmultiply

    lda #81
    sta (POINTER_MMU)

    rts

reset_dots
    lda #<MMU_BANK_5_RAM_ADDR
    sta POINTER_MMU
    lda #>MMU_BANK_5_RAM_ADDR
    sta POINTER_MMU+1

    stz m_calc_tile_number_x
    stz m_calc_tile_number_y
    
    lda #$b3
    sta MMU_MEM_CTRL

    lda #8
    sta MMU_BANK_5_REG
    
    ldy #0
_loop_row 
    ldx #0
_loop_col
    lda (POINTER_MMU)
    cmp #81
    bne  _continue
    lda #57 
    sta (POINTER_MMU)
_continue 
    inx
    clc 
    lda POINTER_MMU
    adc #1
    sta POINTER_MMU
    lda POINTER_MMU+1
    adc #0
    sta POINTER_MMU+1 
    cmp #40
    bne _loop_col 
    iny 
    cpy #30 
    bne _loop_row

    lda #0
    sta p1_dots_count
    sta p1_dots_count + 1
    rts

get_tile_number
    lda MMU_MEM_CTRL
    pha
    stx m_calc_tile_number_x
    sty m_calc_tile_number_y
    stz MMU_IO_CTRL

    lda #$b3
    sta MMU_MEM_CTRL

    jsr check_map_sect_0

    pla 
    sta MMU_MEM_CTRL
    rts
_end_routine
    lda #5
    sta MMU_BANK_5_REG

    pla
    sta MMU_MEM_CTRL
    rts

check_map_sect_0
    lda #8
    sta MMU_BANK_5_REG
    jsr load_map_tile
    rts

load_map_tile
    lda #<MMU_BANK_5_RAM_ADDR
    sta POINTER_MMU
    lda #>MMU_BANK_5_RAM_ADDR
    sta POINTER_MMU+1

    lda m_calc_tile_number_y
    cmp #0
    beq _add_x

    ldx #0
    clc
_8multiply
    lda POINTER_MMU
    adc #80
    sta POINTER_MMU
    lda POINTER_MMU+1
    adc #0
    sta POINTER_MMU+1
    inx
    cpx m_calc_tile_number_y
    bne _8multiply


_add_x
    ldx #0
    clc
 _xmultiply
     lda POINTER_MMU
     adc m_calc_tile_number_x
     sta POINTER_MMU
     lda POINTER_MMU+1
     adc #0
     sta POINTER_MMU+1
     inx
     cpx #2
     bne _xmultiply

    lda (POINTER_MMU)
    sta m_calc_tile_number

    ldx m_calc_tile_number
    rts
tile_number_memory
m_calc_tile_number_y
    .byte 0
m_calc_tile_number_x
    .byte 0 
m_calc_tile_number 
    .byte 0