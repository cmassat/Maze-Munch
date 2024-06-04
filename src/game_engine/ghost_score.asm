display_ghost_score
    pha
    txa
    clc
    adc #2
    tax
    pla
    jsr print_set_tile_position
    lda m_ghost_number_eaten
    cmp #1
    beq _display_200

    lda m_ghost_number_eaten
    cmp #2
    beq _display_400

    lda m_ghost_number_eaten
    cmp #3
    beq _display_800

    lda m_ghost_number_eaten
    cmp #4
    beq _display_1600
    rts
_display_200
    lda #<m_score_200
    ldx #>m_score_200
    ldy m_score_200_len
    jsr print_set_text_address
    jsr print_text
    rts

_display_400
    lda #<m_score_400
    ldx #>m_score_400
    ldy m_score_400_len
    jsr print_set_text_address
    jsr print_text
     rts
_display_800
    jsr print_set_tile_position
    lda #<m_score_800
    ldx #>m_score_800
    ldy m_score_800_len
    jsr print_set_text_address
    jsr print_text
     rts
_display_1600
    jsr print_set_tile_position
    lda #<m_score_1600
    ldx #>m_score_1600
    ldy m_score_1600_len
    jsr print_set_text_address
    jsr print_text
    rts
