clut_set_clut0
    lda #CLUT_IO
    sta MMU_IO_CTRL
    lda #<CLUT_0_ADDR
    sta POINTER_CLUT_DEST
    lda #>CLUT_0_ADDR
    sta POINTER_CLUT_DEST + 1

    lda #<pal_0
    sta POINTER_CLUT_SRC
    lda #>pal_0
    sta POINTER_CLUT_SRC + 1

    ldx #0
_loop
    ldy #0
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y
    iny
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y
    iny
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y

    lda POINTER_CLUT_src
    clc
    adc #4
    sta POINTER_CLUT_SRC
    lda POINTER_CLUT_SRC + 1
    adc #0
    sta POINTER_CLUT_SRC + 1

    lda POINTER_CLUT_DEST
    clc
    adc #4
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    inx
    cpx pal_0_length
    bne _loop
    stz MMU_IO_CTRL
    rts

clut_set_clut1
    lda #CLUT_IO
    sta MMU_IO_CTRL
    lda #<CLUT_1_ADDR
    sta POINTER_CLUT_DEST
    lda #>CLUT_1_ADDR
    sta POINTER_CLUT_DEST + 1

    lda #<pal_1
    sta POINTER_CLUT_SRC
    lda #>pal_1
    sta POINTER_CLUT_SRC + 1

    ldx #0
_loop
    ldy #0
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y
    iny
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y
    iny
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y

    lda POINTER_CLUT_src
    clc
    adc #4
    sta POINTER_CLUT_SRC
    lda POINTER_CLUT_SRC + 1
    adc #0
    sta POINTER_CLUT_SRC + 1

    lda POINTER_CLUT_DEST
    clc
    adc #4
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    inx
    cpx #16
    bne _loop
    stz MMU_IO_CTRL
    rts

clut_set_clut2
    lda #CLUT_IO
    sta MMU_IO_CTRL
    lda #<CLUT_2_ADDR
    sta POINTER_CLUT_DEST
    lda #>CLUT_2_ADDR
    sta POINTER_CLUT_DEST + 1

    lda #<pal_2
    sta POINTER_CLUT_SRC
    lda #>pal_2
    sta POINTER_CLUT_SRC + 1

    ldx #0
_loop
    ldy #0
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y
    iny
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y
    iny
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y

    lda POINTER_CLUT_src
    clc
    adc #4
    sta POINTER_CLUT_SRC
    lda POINTER_CLUT_SRC + 1
    adc #0
    sta POINTER_CLUT_SRC + 1

    lda POINTER_CLUT_DEST
    clc
    adc #4
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    inx
    cpx #$ff
    bne _loop
    stz MMU_IO_CTRL
    rts

clut_set_clut_blank
    lda #CLUT_IO
    sta MMU_IO_CTRL
    lda #<CLUT_0_ADDR
    sta POINTER_CLUT_DEST
    lda #>CLUT_0_ADDR
    sta POINTER_CLUT_DEST + 1

    lda #<pal_3
    sta POINTER_CLUT_SRC
    lda #>pal_3
    sta POINTER_CLUT_SRC + 1

    ldx #0
_loop
    ldy #0
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y
    iny
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y
    iny
    lda (POINTER_CLUT_SRC), y
    sta (POINTER_CLUT_DEST), y

    lda POINTER_CLUT_src
    clc
    adc #4
    sta POINTER_CLUT_SRC
    lda POINTER_CLUT_SRC + 1
    adc #0
    sta POINTER_CLUT_SRC + 1

    lda POINTER_CLUT_DEST
    clc
    adc #4
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    inx
    cpx pal_3_length
    bne _loop
    stz MMU_IO_CTRL
    rts