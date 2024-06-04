CONST_LINE_0 = $c000
CONST_LINE_1 = CONST_LINE_0 + 40
CONST_LINE_2 = CONST_LINE_1 + 40
CONST_LINE_3 = CONST_LINE_2 + 40
CONST_LINE_4 = CONST_LINE_3 + 40
CONST_LINE_5 = CONST_LINE_4 + 40
CONST_LINE_6 = CONST_LINE_5 + 40
CONST_LINE_7 = CONST_LINE_6 + 40
CONST_LINE_8 = CONST_LINE_7 + 40
CONST_LINE_9 = CONST_LINE_8 + 40
CONST_LINE_10 = CONST_LINE_9 + 40
CONST_LINE_11 = CONST_LINE_10 + 40
CONST_LINE_12 = CONST_LINE_11 + 40
CONST_LINE_13 = CONST_LINE_12 + 40
CONST_LINE_14 = CONST_LINE_13 + 40
CONST_LINE_15 = CONST_LINE_14 + 40
CONST_LINE_16 = CONST_LINE_15 + 40
CONST_LINE_17 = CONST_LINE_16 + 40
CONST_LINE_18 = CONST_LINE_17 + 40
CONST_LINE_19 = CONST_LINE_18 + 40
CONST_LINE_20 = CONST_LINE_19 + 40
CONST_LINE_21 = CONST_LINE_20 + 40
CONST_LINE_22 = CONST_LINE_21 + 40
CONST_LINE_23 = CONST_LINE_22 + 40
CONST_LINE_24 = CONST_LINE_23 + 40
CONST_LINE_25 = CONST_LINE_24 + 40
CONST_LINE_26 = CONST_LINE_25 + 40
CONST_LINE_27 = CONST_LINE_26 + 40
CONST_LINE_28 = CONST_LINE_27 + 40
CONST_LINE_29 = CONST_LINE_28 + 40
CONST_LINE_30 = CONST_LINE_29 + 40

display_p1_score
    lda #<hex_values
    sta POINTER_DEBUG
    lda #>hex_values
    sta POINTER_DEBUG + 1

    lda #2
    sta MMU_IO_CTRL

    lda p1_score + 3
    and #$0f
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 11

    lda p1_score + 2
    lsr
    lsr
    lsr
    lsr
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 12

    lda p1_score + 2
    and #$0f
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 13

    lda p1_score + 1
    lsr
    lsr
    lsr
    lsr
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 14

    lda p1_score + 1
    and #$0f
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 15

    lda p1_score
    lsr
    lsr
    lsr
    lsr
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 16

    lda p1_score
    and #$0f
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 17

    stz MMU_IO_CTRL
    rts

display_hi_score
    lda #<hex_values
    sta POINTER_DEBUG
    lda #>hex_values
    sta POINTER_DEBUG + 1

    lda #2
    sta MMU_IO_CTRL

    lda hi_score + 3
    and #$0f
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 28

    lda hi_score + 2
    lsr
    lsr
    lsr
    lsr
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 29

    lda hi_score + 2
    and #$0f
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 30

    lda hi_score + 1
    lsr
    lsr
    lsr
    lsr
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 31

    lda hi_score + 1
    and #$0f
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 32

    lda hi_score
    lsr
    lsr
    lsr
    lsr
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 33

    lda hi_score
    and #$0f
    tay
    lda (POINTER_DEBUG), y
    sta CONST_LINE_0 + 34

    stz MMU_IO_CTRL
    rts

print_set_text_address
    sta m_print_text_address
    txa
    sta m_print_text_address + 1
    tya
    sta m_print_text_length
    rts

print_set_tile_position
    txa
    sta m_print_to_tile_x
    tya
    sta m_print_to_tile_y
    rts

print_text
    jsr print_setup
    jsr print_to_screen
    rts

print_setup
    lda m_print_to_tile_y
    clc
    adc m_print_to_tile_y
    tay

    lda #<m_row_number
    sta POINTER_DEBUG
    lda #>m_row_number
    sta POINTER_DEBUG + 1

    lda (POINTER_DEBUG), y
    sta m_print_row_chosen
    iny
    lda (POINTER_DEBUG), y
    sta m_print_row_chosen + 1
    rts

print_to_screen
    lda m_print_row_chosen
    sta POINTER_DEBUG
    lda m_print_row_chosen + 1
    sta POINTER_DEBUG + 1

    lda POINTER_DEBUG
    clc
    adc m_print_to_tile_x
    sta POINTER_DEBUG

    lda POINTER_DEBUG + 1
    adc #0
    sta POINTER_DEBUG + 1

    lda m_print_text_address
    sta POINTER_MSG

    lda m_print_text_address + 1
    sta POINTER_MSG + 1

    lda #2
    sta MMU_IO_CTRL

    ldy #0
_loop
    lda (POINTER_MSG), y
    sta (POINTER_DEBUG), y
    iny
    cpy m_print_text_length
    bne _loop
    stz MMU_IO_CTRL
    rts

clear_screen
    jsr clear
    jsr text_load_default_palette
    jsr text_bw_screen
    rts

clear
    lda #2
    sta MMU_IO_CTRL
    ldy #0
_loop
    lda #' '
    sta TEXT_COLOR_MATRIX,y
    sta $c000 + (255 * 1),y
    sta $c000 + (255 * 2),y
    sta $c000 + (255 * 3),y
    sta $c000 + (255 * 4),y
    sta $c000 + (255 * 5),y
    sta $c000 + (255 * 6),y
    sta $c000 + (255 * 7),y
    sta $c000 + (255 * 8),y
    sta $c000 + (255 * 9),y
    sta $c000 + (255 * 10),y
    sta $c000 + (255 * 11),y
    sta $c000 + (255 * 12),y
    sta $c000 + (255 * 13),y
    sta $c000 + (255 * 14),y
    sta $c000 + (255 * 15),y
    sta $c000 + (255 * 16),y
    sta $c000 + (255 * 17),y
    sta $c000 + (255 * 18),y
    ;sta $c000 + (255 * 17) + 80,y
    iny
    bne _loop
    stz MMU_IO_CTRL
    rts

text_bw_screen
    lda #TEXT_COLOR_MATRIX_IO
    sta MMU_IO_CTRL
    ldx #0
_loop
    lda #$f0
    sta $c000,x
    sta $c000 + (80 * 1),x
    sta $c000 + (80 * 2),x
    sta $c000 + (80 * 3),x
    sta $c000 + (80 * 4),x
    sta $c000 + (80 * 5),x
    sta $c000 + (80 * 6),x
    sta $c000 + (80 * 7),x
    sta $c000 + (80 * 8),x
    inx
    cpx #80
    bne _loop
    stz MMU_IO_CTRL
    rts

text_load_default_palette
    lda #<default_text_palette
    sta POINTER_TXT
    lda #>default_text_palette
    sta POINTER_TXT + 1

    lda #TEXT_LUT_IO
    sta MMU_IO_CTRL

    ldx #0
    ldy #0
_loop

    lda (POINTER_TXT),y
    sta TEXT_LUT_FG, y
    sta TEXT_LUT_BG, y
    iny
    lda (POINTER_TXT),y
    sta TEXT_LUT_FG, y
    sta TEXT_LUT_BG, y
    iny
    lda (POINTER_TXT),y
    sta TEXT_LUT_FG, y
    sta TEXT_LUT_BG, y
    iny
    lda (POINTER_TXT),y
    sta TEXT_LUT_FG, y
    sta TEXT_LUT_BG, y
    inx
    cpx #16
    bne _loop
    stz MMU_IO_CTRL
rts
default_text_palette
    .byte 0, 0, 0 ,0        ; black 0
    .byte 255, 255, 255,0   ; white 1
    .byte 0, 0, 136,0       ; red 2
    .byte 238, 255, 170, 0  ; cyan 3
    .byte 204, 68, 204,0    ; purple 4
    .byte 85, 204, 0,0      ; green 5
    .byte 170,0,0,0         ; blue 6
    .byte 119, 238,238,0    ; yellow 7
    .byte 85,136, 221,0     ; orange 8
    .byte 0, 68, 192,0      ; brown 9
    .byte 119, 119, 255,0   ; light red a
    .byte 51, 51, 51,0      ; dark grey b
    .byte 119, 119, 119,0   ; grey c
    .byte 102, 255, 119, 0  ; light green d
    .byte 255, 136,0,0      ; light blue e
    .byte 187, 187, 187,0   ; light grey f
default_text_palette_end

hex_values
    .byte '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
m_row_number
    .word CONST_LINE_0
    .word CONST_LINE_1
    .word CONST_LINE_2
    .word CONST_LINE_3
    .word CONST_LINE_4
    .word CONST_LINE_5
    .word CONST_LINE_6
    .word CONST_LINE_7
    .word CONST_LINE_8
    .word CONST_LINE_9
    .word CONST_LINE_10
    .word CONST_LINE_11
    .word CONST_LINE_12
    .word CONST_LINE_13
    .word CONST_LINE_14
    .word CONST_LINE_15
    .word CONST_LINE_16
    .word CONST_LINE_17
    .word CONST_LINE_18
    .word CONST_LINE_19
    .word CONST_LINE_20
    .word CONST_LINE_21
    .word CONST_LINE_22
    .word CONST_LINE_23
    .word CONST_LINE_24
    .word CONST_LINE_25
    .word CONST_LINE_26
    .word CONST_LINE_27
    .word CONST_LINE_28
    .word CONST_LINE_29
    .word CONST_LINE_30