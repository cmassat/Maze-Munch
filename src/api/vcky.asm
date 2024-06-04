

vcky_tile_sprite_bmp
    stz MMU_IO_CTRL
    lda #%00111111
    sta VCKY_CTRL_REG

    lda $40
    sta VCKY_LAYER_1_0_REG

    lda $01
    sta VCKY_LAYER_2_REG
    rts

vcky_double_text_x
    stz MMU_IO_CTRL
    lda #%00000110
    sta VCKY_ATTRIB
    rts

vcky_default_text
    stz MMU_IO_CTRL
    lda #%00000000
    sta VCKY_ATTRIB
    rts

vcky_sprite_text
    stz MMU_IO_CTRL
    lda #%00100111
    sta VCKY_ATTRIB

    lda #0
    sta VCKY_LAYER_1_0_REG
    sta VCKY_LAYER_2_REG
    sta VCKY_BMP0_CTRL_REG
    sta VCKY_BMP1_CTRL_REG
    sta VCKY_BMP3_CTRL_REG
    rts

vcky_tile_sprite
    stz MMU_IO_CTRL
    lda #%00110111
    sta VCKY_CTRL_REG

    lda #$44
    sta VCKY_LAYER_1_0_REG

    lda #$04
    sta VCKY_LAYER_2_REG
    rts

vcky_background_black
    lda #$0
    sta $D00D
    sta $D00E
    sta $D00F
    rts

vcky_background_white
    lda #$ff
    sta $D00D
    sta $D00E
    sta $D00F
    rts

vcky_disable_all_bmp
    lda #0
    sta $d100
    sta $d108
    sta $d110
    rts