game_over_event_processing
    lda m_game_state
    cmp #CONST_STATE_GAME_OVER
    bne _end
    jsr psg_turn_off
    jsr wait_for_restart_menu_keypress
_end
    rts

game_over_offscreen_processing
    lda m_game_state
    cmp #CONST_STATE_GAME_OVER
    bne _end
    stz MMU_IO_CTRL
    jsr sprite_disable_all
    jsr init_text_score
    jsr init_text_hi_score
    jsr display_hi_score
    jsr display_p1_score
    jsr game_over_display_text
    jsr game_over_restart_text
_end
    rts

wait_for_restart_menu_keypress
    lda keypress
    cmp #$81
    beq _reload_menu
    rts
_reload_menu
    jsr state_next
    stz keypress
    rts

game_over_display_text
    lda #<m_game_over_message
    sta POINTER_TXT
    lda #>m_game_over_message
    sta POINTER_TXT + 1
    lda #2
    sta MMU_IO_CTRL

    ldy #0
_text_1
    lda (POINTER_TXT),y
    sta CONST_LINE_15 + 15, y
    iny
    cpy m_game_over_message_len
    bne _text_1

_end
    rts

game_over_restart_text
    lda #<m_game_over_reset_message
    sta POINTER_TXT
    lda #>m_game_over_reset_message
    sta POINTER_TXT + 1
    lda #2
    sta MMU_IO_CTRL

    ldy #0
_text_1
    lda (POINTER_TXT),y
    sta CONST_LINE_17 + 15, y
    iny
    cpy m_game_over_restart_message_len
    bne _text_1

_end
    rts

m_game_over_timer
    .byte 0

m_game_over_message
    .text 'GAME OVER'
m_game_over_message_len
    .byte m_game_over_message_len - m_game_over_message

m_game_over_reset_message
    .text 'PRESS F1'
m_game_over_restart_message_len
    .byte m_game_over_restart_message_len - m_game_over_reset_message