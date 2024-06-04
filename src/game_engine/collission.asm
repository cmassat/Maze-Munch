PACMAN_MUNCHED_FRAME_1 = sprite_0 + CONST_SPRITE_SIZE * 3
PACMAN_MUNCHED_FRAME_2 = PACMAN_MUNCHED_FRAME_1 + CONST_SPRITE_SIZE
PACMAN_MUNCHED_FRAME_3 = PACMAN_MUNCHED_FRAME_2 + CONST_SPRITE_SIZE
PACMAN_MUNCHED_FRAME_4 = PACMAN_MUNCHED_FRAME_3 + CONST_SPRITE_SIZE
PACMAN_MUNCHED_FRAME_5 = PACMAN_MUNCHED_FRAME_4 + CONST_SPRITE_SIZE
PACMAN_MUNCHED_FRAME_6 = PACMAN_MUNCHED_FRAME_5 + CONST_SPRITE_SIZE
PACMAN_MUNCHED_FRAME_7 = PACMAN_MUNCHED_FRAME_6 + CONST_SPRITE_SIZE
PACMAN_MUNCHED_FRAME_8 = PACMAN_MUNCHED_FRAME_7 + CONST_SPRITE_SIZE
PACMAN_MUNCHED_FRAME_9 = PACMAN_MUNCHED_FRAME_8 + CONST_SPRITE_SIZE
PACMAN_MUNCHED_FRAME_10 = PACMAN_MUNCHED_FRAME_9 + CONST_SPRITE_SIZE

check_rg_munched_pacman
    lda m_red_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    rts
_not_eaten
    lda m_pacman_tile_x
    cmp m_rg_tile_x
    beq _check_y

    lda m_rg_tile_x
    clc
    adc #1
    cmp m_pacman_tile_x
    beq _check_y

    rts
_check_y
    lda m_pacman_tile_y
    cmp m_rg_tile_y
    beq _gobbled
    rts
_gobbled
    lda m_red_ghost_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    beq _frightened
    jsr gobbled
    rts
_frightened
    jsr gobbled_red_ghost
    ldx m_rg_tile_x
    ldy m_rg_tile_y
    jsr display_ghost_score
    rts

check_bg_munched_pacman
    lda m_blue_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    rts
_not_eaten
    lda m_pacman_tile_x
    cmp m_bg_tile_x
    beq _check_y

    lda m_bg_tile_x
    clc
    adc #1
    cmp m_pacman_tile_x
    beq _check_y
    rts
_check_y
    lda m_pacman_tile_y
    cmp m_bg_tile_y
    beq _gobbled
    rts
_gobbled
    lda m_blue_ghost_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    beq _frightened
    jsr gobbled
    rts
_frightened
    jsr gobbled_blue_ghost
    ldx m_bg_tile_x
    ldy m_bg_tile_y
    jsr display_ghost_score
    rts

check_pg_munched_pacman
    lda m_pink_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    rts
_not_eaten
    lda m_pacman_tile_x
    cmp m_pg_tile_x
    beq _check_y

    lda m_pg_tile_x
    clc
    adc #1
    cmp m_pacman_tile_x
    beq _check_y
    rts
_check_y
    lda m_pacman_tile_y
    cmp m_pg_tile_y
    beq _gobbled
    rts
_gobbled
    lda m_pink_ghost_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    beq _frightened
    jsr gobbled
    rts
_frightened
    jsr gobbled_pink_ghost
    ldx m_pg_tile_x
    ldy m_pg_tile_y
    jsr display_ghost_score
    rts

check_og_munched_pacman
    lda m_orange_ghost_mode
    cmp #CONST_GAME_MODE_EATEN
    bne _not_eaten
    rts
_not_eaten
    lda m_pacman_tile_x
    cmp m_og_tile_x
    beq _check_y

    lda m_og_tile_x
    clc
    adc #1
    cmp m_pacman_tile_x
    beq _check_y
    rts
_check_y
    lda m_pacman_tile_y
    cmp m_og_tile_y
    beq _gobbled
    rts
_gobbled
    lda m_orange_ghost_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    beq _frightened
    jsr gobbled
    rts
_frightened
    jsr gobbled_orange_ghost
    ldx m_og_tile_x
    ldy m_og_tile_y
    jsr display_ghost_score
    rts

gobbled
    lda #1
    sta m_pacman_caught
    stz m_pacman_eat_animation

    lda #15
    jsr psg_1_volume_mono
    lda #15
    jsr psg_2_volume_mono

    lda #1
    jsr sprite_set_number
    jsr sprite_disable

    lda #2
    jsr sprite_set_number
    jsr sprite_disable

    lda #3
    jsr sprite_set_number
    jsr sprite_disable

    lda #4
    jsr sprite_set_number
    jsr sprite_disable

    rts

gobbled_red_ghost
    jsr play_eat_ghost
    jsr score_ghost
    lda #CONST_SPRITE_NUMBER_RED_GHOST
    jsr sprite_set_number
    lda #CONST_GAME_MODE_EATEN
    sta m_red_ghost_mode
    rts

gobbled_blue_ghost
    jsr play_eat_ghost
    jsr score_ghost
    lda #CONST_SPRITE_NUMBER_BLUE_GHOST
    jsr sprite_set_number
    lda #CONST_GAME_MODE_EATEN
    sta m_blue_ghost_mode
    rts

gobbled_orange_ghost
    jsr play_eat_ghost
    jsr score_ghost
    lda #CONST_SPRITE_NUMBER_ORANGE_GHOST
    jsr sprite_set_number
    lda #CONST_GAME_MODE_EATEN
    sta m_orange_ghost_mode
    rts

gobbled_pink_ghost
    jsr play_eat_ghost
    jsr score_ghost
    lda #CONST_SPRITE_NUMBER_PINK_GHOST
    jsr sprite_set_number
    lda #CONST_GAME_MODE_EATEN
    sta m_pink_ghost_mode
    rts

munched_animation
    jsr play_eat_pacman

    inc m_pacman_eat_animation
    lda m_pacman_eat_animation
    cmp #1
    beq _frame_1

    cmp #20
    beq _frame_2

    cmp #40
    beq _frame_3

    cmp #60
    beq _frame_4

    cmp #80
    beq _frame_5

    cmp #100
    beq _frame_6

    cmp #120
    beq _frame_7

    cmp #140
    beq _frame_8

    cmp #160
    beq _frame_9

    lda m_pacman_eat_animation
    cmp #180
    beq _frame_10
    rts
_frame_1
    jsr pc_anim1
    rts

_frame_2
    jsr pc_anim2
    rts
_frame_3
    jsr pc_anim3
    rts

_frame_4
    jsr pc_anim4
    rts

_frame_5
    jsr pc_anim5
rts

_frame_6
    jsr pc_anim6
    rts
_frame_7
    jsr pc_anim7
rts

_frame_8
    jsr pc_anim8
rts

_frame_9
    jsr pc_anim9
rts

_frame_10
    jsr pc_anim10
    dec p1_lives
rts

pc_anim1
    lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number
    lda #<PACMAN_MUNCHED_FRAME_1
    ldx #>PACMAN_MUNCHED_FRAME_1
    ldy #`PACMAN_MUNCHED_FRAME_1
    jsr sprite_set_address
    jsr sprite_enable
    rts

pc_anim2
    lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number

    lda #<PACMAN_MUNCHED_FRAME_2
    ldx #>PACMAN_MUNCHED_FRAME_2
    ldy #`PACMAN_MUNCHED_FRAME_2
    jsr sprite_set_address
    jsr sprite_enable
    rts

pc_anim3
     lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number

    lda #<PACMAN_MUNCHED_FRAME_3
    ldx #>PACMAN_MUNCHED_FRAME_3
    ldy #`PACMAN_MUNCHED_FRAME_3
    jsr sprite_set_address
    jsr sprite_enable
    rts

pc_anim4
    lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number

    lda #<PACMAN_MUNCHED_FRAME_4
    ldx #>PACMAN_MUNCHED_FRAME_4
    ldy #`PACMAN_MUNCHED_FRAME_4
    jsr sprite_set_address
    jsr sprite_enable
    rts

pc_anim5
     lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number

    lda #<PACMAN_MUNCHED_FRAME_5
    ldx #>PACMAN_MUNCHED_FRAME_5
    ldy #`PACMAN_MUNCHED_FRAME_5
    jsr sprite_set_address
    jsr sprite_enable
    rts

pc_anim6
     lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number

    lda #<PACMAN_MUNCHED_FRAME_6
    ldx #>PACMAN_MUNCHED_FRAME_6
    ldy #`PACMAN_MUNCHED_FRAME_6
    jsr sprite_set_address
    jsr sprite_enable
    rts

pc_anim7
     lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number

    lda #<PACMAN_MUNCHED_FRAME_7
    ldx #>PACMAN_MUNCHED_FRAME_7
    ldy #`PACMAN_MUNCHED_FRAME_7
    jsr sprite_set_address
    jsr sprite_enable
    rts

pc_anim8
     lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number

    lda #<PACMAN_MUNCHED_FRAME_8
    ldx #>PACMAN_MUNCHED_FRAME_8
    ldy #`PACMAN_MUNCHED_FRAME_8
    jsr sprite_set_address
    jsr sprite_enable
    rts

pc_anim9
     lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number

    lda #<PACMAN_MUNCHED_FRAME_9
    ldx #>PACMAN_MUNCHED_FRAME_9
    ldy #`PACMAN_MUNCHED_FRAME_9
    jsr sprite_set_address
    jsr sprite_enable
    rts

pc_anim10
     lda #CONST_SPRITE_NUMBER_PACMAN
    jsr sprite_set_number

    lda #<PACMAN_MUNCHED_FRAME_10
    ldx #>PACMAN_MUNCHED_FRAME_10
    ldy #`PACMAN_MUNCHED_FRAME_10
    jsr sprite_set_address
    jsr sprite_enable
    jsr reset_board
    rts

check_fruit_munched
    lda m_fruit_timer
    cmp #0
    bne _not_eaten
    rts
_not_eaten
    lda m_pacman_tile_x
    cmp #CONST_FRUIT_TILE_X
    beq _check_y
    rts
_check_y
    lda m_pacman_tile_y
    cmp #CONST_FRUIT_TILE_Y
    beq _gobbled
    rts
_gobbled
    lda #CONST_SPRITE_NUMBER_FRUIT
    jsr sprite_set_number
    jsr sprite_disable
    jsr score_fruit
    stz m_fruit_timer
    stz m_fruit_timer + 1
    rts