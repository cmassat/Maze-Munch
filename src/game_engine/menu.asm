menu_event_processing
    lda m_game_state
    cmp #CONST_STATE_GAME_MENU_LOADED
    bne _end
    jsr animate_menu
    jsr wait_for_game_start_keypress
_end
    rts

menu_offscreen_processing
    lda m_game_state
    cmp #CONST_STATE_GAME_MENU
    bne _end
    jsr sprite_disable_all
    jsr clear_screen
    jsr clut_set_clut1
    jsr vcky_sprite_text
    jsr vcky_double_text_x
    jsr vcky_background_black
    jsr menu_set_pacman_address
    jsr menu_init_muncher
    jsr menu_init_ghost
    jsr init_text_score
    jsr init_text_hi_score
    jsr display_hi_score
    jsr display_p1_score
    jsr menu_display_text
    stz keypress
    jsr state_next
_end
    rts

wait_for_game_start_keypress
    stz VCKY_BMP0_CTRL_REG
    stz VCKY_BMP1_CTRL_REG
    lda keypress
    cmp #$81
    beq _set_3_lives
    bra _wait_for_f3
_set_3_lives
    lda #3
    sta p1_lives
    bra _next_state
_wait_for_f3
    lda keypress
    cmp #$83
    beq _set_5_lives
    rts
_set_5_lives
    lda #5
    sta p1_lives
    bra _next_state
    rts
_next_state
    jsr sprite_disable_all
    jsr clear_screen
    stz m_text_init
    stz psg_start_time
    jsr state_next
    stz keypress
    rts

animate_menu
    jsr menu_set_pacman_address
    jsr move_pacman_right
    jsr menu_set_ghost_address
    jsr menu_move_rg_right
    rts

menu_init_muncher
    lda #CONST_SPRITE_NUMBER_MENU_PLAYER
    jsr sprite_set_number
    lda #<320
    sta m_menu_pacman_x
    lda #>320
    sta m_menu_pacman_x + 1
    lda #200
    sta m_menu_pacman_y
    stz m_menu_pacman_y + 1

    lda m_menu_pacman_x
    ldx m_menu_pacman_x + 1
    jsr sprite_set_x

    lda m_menu_pacman_y
    ldx m_menu_pacman_y + 1
    jsr sprite_set_y
    jsr sprite_enable
    rts

menu_init_ghost
    lda #1
    jsr sprite_set_number
    lda #<320 + 32
    sta m_menu_rg_x
    lda #>320 + 32
    sta m_menu_rg_x + 1
    lda #200
    sta m_menu_rg_y
    stz m_menu_rg_y + 1

    lda m_menu_rg_x
    ldx m_menu_rg_x + 1
    jsr sprite_set_x

    lda m_menu_rg_y
    ldx m_menu_rg_y + 1
    jsr sprite_set_y
    jsr sprite_enable
    rts

menu_set_pacman_address
    lda #CONST_SPRITE_NUMBER_MENU_PLAYER
    jsr sprite_set_number
    lda m_animation
    cmp #0
    bne _frame1
    lda #<CONST_PC_SPRITE_RIGHT
    ldx #>CONST_PC_SPRITE_RIGHT
    ldy #`CONST_PC_SPRITE_RIGHT
    jsr sprite_set_address
    rts
_frame1
    lda #<CONST_PC_SPRITE_COSED
    ldx #>CONST_PC_SPRITE_COSED
    ldy #`CONST_PC_SPRITE_COSED
    jsr sprite_set_address
    rts

menu_set_ghost_address
    lda #1
    jsr sprite_set_number
    lda m_animation
    cmp #0
    bne _frame1
    lda #<CONST_RG_SPRITE_RIGHT_1
    ldx #>CONST_RG_SPRITE_RIGHT_1
    ldy #`CONST_RG_SPRITE_RIGHT_1
    jsr sprite_set_address
    rts
_frame1
    lda #<CONST_RG_SPRITE_RIGHT_2
    ldx #>CONST_RG_SPRITE_RIGHT_2
    ldy #`CONST_RG_SPRITE_RIGHT_2
    jsr sprite_set_address
    rts

move_pacman_right
    lda m_menu_pacman_x
    clc
    adc #1
    sta m_menu_pacman_x
    lda m_menu_pacman_x + 1
    adc #0
    sta m_menu_pacman_x + 1

    lda #CONST_SPRITE_NUMBER_MENU_PLAYER
    jsr sprite_set_number

    lda m_menu_pacman_x
    ldx m_menu_pacman_x + 1
    jsr sprite_set_x

    lda m_menu_pacman_y
    ldx m_menu_pacman_y + 1
    jsr sprite_set_y
    jsr sprite_enable
    rts
menu_move_rg_right
    lda #1
    jsr sprite_set_number
    lda m_menu_rg_x
    clc
    adc #1
    sta m_menu_rg_x
    lda m_menu_rg_x + 1
    adc #0
    sta m_menu_rg_x + 1
    lda m_menu_rg_x
    ldx m_menu_rg_x + 1
    jsr sprite_set_x

    lda m_menu_rg_y
    ldx m_menu_rg_y + 1
    jsr sprite_set_y
    rts

menu_display_text
    lda #<m_menu_text_1
    sta POINTER_TXT
    lda #>m_menu_text_1
    sta POINTER_TXT + 1
    lda #2
    sta MMU_IO_CTRL

    ldy #0
_text_1
    lda (POINTER_TXT),y
    sta CONST_LINE_5 + 5, y
    iny
    cpy m_menu_text_1_len
    bne _text_1

    lda #<m_menu_text_2
    sta POINTER_TXT
    lda #>m_menu_text_2
    sta POINTER_TXT + 2

    ldy #0
_text_2
    lda (POINTER_TXT),y
    sta CONST_LINE_7 + 5, y
    iny
    cpy #20
    bne _text_2

    lda #<m_menu_text_3
    sta POINTER_TXT
    lda #>m_menu_text_3
    sta POINTER_TXT + 2

    ldy #0
_text_3
    lda (POINTER_TXT),y
    sta CONST_LINE_9 + 5, y
    iny
    cpy m_menu_text_3_len
    bne _text_3

    lda #<m_menu_text_4
    sta POINTER_TXT
    lda #>m_menu_text_4
    sta POINTER_TXT + 2

    ldy #0
_text_4
    lda (POINTER_TXT),y
    sta CONST_LINE_10 + 5, y
    iny
    cpy m_menu_text_4_len
    bne _text_4

    stz MMU_IO_CTRL

    rts
