sprite_set_number
    pha
    lda #<SPRITE_0_REG_CTRL
    sta m_sprite_current_register
    lda #>SPRITE_0_REG_CTRL
    sta m_sprite_current_register+1
    pla
    tay
_loop
    cpy #0
    beq _end
    lda  m_sprite_current_register
    clc
    adc #8
    sta m_sprite_current_register
    lda m_sprite_current_register+1
    adc #0
    sta m_sprite_current_register+1
    dey
    bra _loop
_end
    rts

sprite_set_address
    pha
_set_low_address
    lda m_sprite_current_register
    sta POINTER_SPRITE
    lda m_sprite_current_register+1
    sta POINTER_SPRITE+1

    pla
    phy
    ldy #1
    clc
    sta (POINTER_SPRITE),y
_set_med_address
    ldy #2
    txa
    sta (POINTER_SPRITE),y
_set_high_address
    ply
    tya
    ldy #3
    sta (POINTER_SPRITE),y
    rts

sprite_set_x
    pha
    lda m_sprite_current_register
    clc
    adc #SPRITE_X_OFFSET

    sta POINTER_SPRITE

    lda m_sprite_current_register+1
    adc #0
    sta POINTER_SPRITE+1

    pla
    sta (POINTER_SPRITE)

    ldy #1
    txa
    sta (POINTER_SPRITE),y
    rts

sprite_set_y
    pha
    lda m_sprite_current_register
    clc
    adc #SPRITE_Y_OFFSET
    sta POINTER_SPRITE

    lda m_sprite_current_register + 1
    adc #0
    sta POINTER_SPRITE + 1
    pla
    sta (POINTER_SPRITE)
    phy
    ldy #1
    txa
    sta (POINTER_SPRITE),y
    ply
    rts

;0 0 32 × 32
;0 1 24 × 24
;1 0 16 × 16
;1 1 8 × 8

sprite_enable
    lda m_sprite_current_register
    sta POINTER_SPRITE
    lda m_sprite_current_register+1
    sta POINTER_SPRITE+1

    lda #%01000011
    sta (POINTER_SPRITE)

    rts

sprite_disable
    lda m_sprite_current_register
    sta POINTER_SPRITE
    lda m_sprite_current_register+1
    sta POINTER_SPRITE+1

    lda #%00000000
    sta (POINTER_SPRITE)

    rts

sprite_disable_all
    lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_PINK_GHOST
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_RED_GHOST
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_BLUE_GHOST
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_ORANGE_GHOST
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_POWER_DOT_1
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_POWER_DOT_2
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_POWER_DOT_3
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_POWER_DOT_4
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_BOARD_1
    jsr sprite_set_number
    jsr sprite_disable
    lda #CONST_SPRITE_BOARD_2

    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_BOARD_3
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_BOARD_4
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_BOARD_5
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_BOARD_6
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_BOARD_7
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_BOARD_8
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_LIFE_1
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_LIFE_2
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_LIFE_3
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_MENU_PLAYER
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_MENU_GHOST
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_LIFE_1
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_LIFE_2
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_LIFE_3
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_LIFE_4
    jsr sprite_set_number
    jsr sprite_disable

    lda #CONST_SPRITE_NUMBER_LIFE_5
    jsr sprite_set_number
    jsr sprite_disable
    rts