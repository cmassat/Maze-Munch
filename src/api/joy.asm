JOY_PORT_B_REG      = $DC00
JOY_PORT_A_REG      = $DC01

JOY_UP              = %11111110
JOY_DOWN            = %11111101
JOY_LEFT            = %11111011
JOY_RIGHT           = %11110111
JOY_BUTTON_0        = %11101111
JOY_BUTTON_1        = %11011111
JOY_BUTTON_2        = %10111111

JOY_UP_MASK         = %00000001
JOY_DOWN_MASK       = %00000010
JOY_LEFT_MASK       = %00000100
JOY_RIGHT_MASK      = %00001000
JOY_BUTTON_0_MASK   = %00010000
JOY_BUTTON_1_MASK   = %00100000
JOY_BUTTON_2_MASK   = %01000000

handle_joy_ports
    stz MMU_IO_CTRL
    lda JOY_PORT_A_REG
    sta JOY_PORT_A_DATA

    lda JOY_PORT_B_REG
    sta JOY_PORT_B_DATA
    rts

; JOY_PORT_A_DATA
is_joy_a_up_pressed
    lda JOY_PORT_A_REG
    and #JOY_UP_MASK
    jsr joy_result
    rts

is_joy_a_down_pressed
    lda JOY_PORT_A_REG
    and  #JOY_DOWN_MASK
    jsr joy_result
    rts

is_joy_a_left_pressed
    lda JOY_PORT_A_REG
    and  #JOY_LEFT_MASK
    jsr joy_result
    rts

is_joy_a_right_pressed
    lda JOY_PORT_A_REG
    and #JOY_RIGHT_MASK
    cmp #$0
    jsr joy_result
    rts

is_joy_a_btn_0_pressed
    lda JOY_PORT_A_REG
    and #JOY_BUTTON_0_MASK
    jsr joy_result
    rts

is_joy_a_btn_1_pressed
    lda JOY_PORT_A_REG
    and #JOY_BUTTON_1_MASK
    jsr joy_result
    rts

is_joy_a_btn_2_pressed
    lda JOY_PORT_A_REG
    and #JOY_BUTTON_2_MASK
    jsr joy_result
    rts

; JOY_PORT_B_DATA
is_joy_b_up_pressed
    lda JOY_PORT_B_REG
    and #JOY_UP_MASK
    jsr joy_result
    rts

is_joy_b_down_pressed
    lda JOY_PORT_B_REG
    and  #JOY_DOWN_MASK
    jsr joy_result
    rts

is_joy_b_left_pressed
    lda JOY_PORT_B_REG
    and  #JOY_LEFT_MASK
    jsr joy_result
    rts

is_joy_b_right_pressed
    lda JOY_PORT_B_REG
    and #JOY_RIGHT_MASK
    cmp #$0
    jsr joy_result
    rts

is_joy_b_btn_0_pressed
    lda JOY_PORT_B_REG
    and #JOY_BUTTON_0_MASK
    jsr joy_result
    rts

is_joy_b_btn_1_pressed
    lda JOY_PORT_B_REG
    and #JOY_BUTTON_1_MASK
    jsr joy_result
    rts

is_joy_b_btn_2_pressed
    lda JOY_PORT_B_REG
    and #JOY_BUTTON_2_MASK
    jsr joy_result
    rts

joy_result
    cmp #0
    beq _yes
    sec
    rts
_yes
    clc
    rts

JOY_PORT_B_DATA
    .byte 0
JOY_PORT_A_DATA
    .byte 0
