fruit_controller
    jsr display_level
    lda p1_dots_count
    cmp #70
    bne _not_70
    jsr display_fruit
    rts
_not_70
    lda p1_dots_count
    cmp #140
    bne _not_140
    jsr display_fruit
_not_140
    rts

display_fruit
    lda #<600
    sta m_fruit_timer
    lda #>600
    sta m_fruit_timer + 1
    lda p1_screen_num
    cmp #0
    beq  _display_cherry

    cmp #1
    beq _display_strawberry

    cmp #2
    beq _display_orange

    cmp #3
    beq _display_orange

    cmp #4
    beq _display_apple

    cmp #5
    beq _display_apple

    cmp #6
    beq _display_melon

    cmp #7
    beq _display_melon

    cmp #8
    beq _display_galaxian

    cmp #9
    beq _display_galaxian

    cmp #10
    beq _display_bell

    cmp #11
    beq _display_bell

    cmp #12
    beq _display_key
    rts
_display_cherry
    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr display_cherry
    jsr plot_bonus
    rts
_display_strawberry
    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr display_strawberry
    jsr plot_bonus
    rts
_display_orange
    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr display_orange
    jsr plot_bonus
    rts
_display_apple
    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr display_apple
    jsr plot_bonus
    rts
_display_melon
    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr display_melon
    jsr plot_bonus
    rts
_display_galaxian
    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr display_galaxian
    jsr plot_bonus
    rts
_display_bell
    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr display_bell
    jsr plot_bonus
    rts
_display_key
    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr display_key
    jsr plot_bonus
    rts

display_cherry
    lda #<CONST_CHERRY_SPRITE
    ldx #>CONST_CHERRY_SPRITE
    ldy #`CONST_CHERRY_SPRITE
    jsr sprite_set_address
    rts

display_level
    lda p1_screen_num
    cmp #0
    beq _display_cherry_level

    cmp #1
    beq  _display_strawberry_level

    cmp #2
    beq _display_orange_level

    cmp #3
    beq _display_orange_level

    cmp #4
    beq _display_apple_level

    cmp #5
    beq _display_apple_level

    cmp #6
    beq _display_melon_level

    cmp #7
    beq _display_melon_level

    cmp #8
    beq _display_galaxian_level

    cmp #9
    beq _display_galaxian_level

    cmp #10
    beq _display_bell_level

    cmp #11
    beq _display_bell_level

    cmp #12
    bcs _display_key_level
    rts
_display_cherry_level
    jsr display_cherry_level
    rts
_display_strawberry_level
    jsr display_strawberry_level
    rts
_display_orange_level
    jsr display_orange_level
    rts
_display_apple_level
    jsr display_apple_level
    rts
_display_melon_level
    jsr display_melon_level
    rts
_display_galaxian_level
    jsr display_galaxian_level
    rts
_display_bell_level
    jsr display_bell_level
    rts
_display_key_level
    jsr display_key_level
    rts

display_cherry_level
    lda #CONST_SPRITE_BOARD_1
    jsr sprite_set_number
    jsr display_cherry
    lda #38
    ldx #0
    jsr plot_ghost_x

    lda #12
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts

display_strawberry_level
    lda #CONST_SPRITE_BOARD_2
    jsr sprite_set_number
    jsr display_strawberry
    lda #38
    ldx #0
    jsr plot_ghost_x

    lda #14
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts
display_orange_level
    lda #CONST_SPRITE_BOARD_3
    jsr sprite_set_number
    jsr display_orange
    lda #38
    ldx #0
    jsr plot_ghost_x

    lda #16
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts
display_apple_level
    lda #CONST_SPRITE_BOARD_4
    jsr sprite_set_number
    jsr display_apple
    lda #38
    ldx #0
    jsr plot_ghost_x

    lda #18
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts
display_melon_level
    lda #CONST_SPRITE_BOARD_5
    jsr sprite_set_number
    jsr display_melon
    lda #38
    ldx #0
    jsr plot_ghost_x

    lda #20
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts
display_galaxian_level
    lda #CONST_SPRITE_BOARD_6
    jsr sprite_set_number
    jsr display_galaxian
    lda #38
    ldx #0
    jsr plot_ghost_x

    lda #22
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts
display_bell_level
     lda #CONST_SPRITE_BOARD_7
    jsr sprite_set_number
    jsr display_bell
    lda #38
    ldx #0
    jsr plot_ghost_x

    lda #24
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts
display_key_level
    lda #CONST_SPRITE_BOARD_8
    jsr sprite_set_number
    jsr display_key
    lda #38
    ldx #0
    jsr plot_ghost_x

    lda #26
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts

display_strawberry
    lda #<CONST_STRAWBERRY_SPRITE
    ldx #>CONST_STRAWBERRY_SPRITE
    ldy #`CONST_STRAWBERRY_SPRITE
    jsr sprite_set_address
    rts

display_orange
    lda #<CONST_ORANGE_SPRITE
    ldx #>CONST_ORANGE_SPRITE
    ldy #`CONST_ORANGE_SPRITE
    jsr sprite_set_address
    rts

display_apple
    lda #<CONST_APPLE_SPRITE
    ldx #>CONST_APPLE_SPRITE
    ldy #`CONST_APPLE_SPRITE
    jsr sprite_set_address
    rts

display_melon
    lda #<CONST_MELON_SPRITE
    ldx #>CONST_MELON_SPRITE
    ldy #`CONST_MELON_SPRITE
    jsr sprite_set_address
    rts

display_galaxian
    lda #<CONST_GALAXIAN_SPRITE
    ldx #>CONST_GALAXIAN_SPRITE
    ldy #`CONST_GALAXIAN_SPRITE
    jsr sprite_set_address
    rts

display_bell
    lda #<CONST_BELL_SPRITE
    ldx #>CONST_BELL_SPRITE
    ldy #`CONST_BELL_SPRITE
    jsr sprite_set_address
    rts

display_key
    lda #<CONST_KEY_SPRITE
    ldx #>CONST_KEY_SPRITE
    ldy #`CONST_KEY_SPRITE
    jsr sprite_set_address
    rts

plot_bonus
    lda #CONST_FRUIT_TILE_X
    ldx #0
    jsr plot_ghost_x

    lda #CONST_FRUIT_TILE_Y
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts

fruit_timer
    lda m_fruit_timer + 1
    cmp #0
    bne _count_down

    lda m_fruit_timer
    cmp #1
    bne _count_down

    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr sprite_disable
_count_down
    lda m_fruit_timer
    cmp #0
    bne _continue

    lda m_fruit_timer + 1
    cmp #0
    beq _end
_continue
    sec
    lda m_fruit_timer
    sbc #1
    sta m_fruit_timer
    lda m_fruit_timer + 1
    sbc #0
    sta m_fruit_timer + 1
_end
    rts
