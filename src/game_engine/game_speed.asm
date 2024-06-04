ghost_speed
    inc m_pm_speed
    inc m_rg_speed
    inc m_pg_speed
    inc m_bg_speed
    inc m_og_speed
rts

ghost_set_speed
    jsr screen0_speed
    jsr screen1_speed
    jsr screen2_speed
    jsr screen3_speed
    jsr screen4_speed
    jsr screen5_speed
    jsr screen6_speed
    jsr screen7_speed
    rts

screen0_speed
    lda p1_screen_num
    cmp #0
    beq _continue
    rts
_continue
    lda m_rg_speed
    cmp #10
    beq _set_faster_ghost_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_pm_default_speed
    rts
_set_faster_ghost_speed
    jsr set_rg_double_speed
    jsr set_pg_double_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_pm_double_speed
    stz m_rg_speed
    stz m_pg_speed
    stz m_bg_speed
    stz m_og_speed
    rts

screen1_speed
    lda p1_screen_num
    cmp #1
    beq _continue
    rts
_continue
    lda m_rg_speed
    cmp #8
    beq _set_faster_ghost_speed

    lda m_bg_speed
    cmp #10
    beq _set_slower_ghost_speed

    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_pm_default_speed
    rts
_set_faster_ghost_speed
    jsr set_rg_double_speed
    jsr set_pg_double_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_pm_double_speed
    rts
_set_slower_ghost_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_bg_double_speed
    jsr set_og_double_speed
    jsr set_pm_default_speed
    rts

screen2_speed
    lda p1_screen_num
    cmp #2
    beq _continue
    rts
_continue
    lda m_rg_speed
    cmp #7
    beq _set_faster_ghost_speed
    lda m_bg_speed
    cmp #9
    beq _set_slower_ghost_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_pm_default_speed
    rts
_set_faster_ghost_speed
    jsr set_rg_double_speed
    jsr set_pg_double_speed
    jsr set_pm_double_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    rts
_set_slower_ghost_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_bg_double_speed
    jsr set_og_double_speed
    jsr set_pm_default_speed
    rts

screen3_speed
    lda p1_screen_num
    cmp #3
    beq _continue
    rts
_continue
    lda m_rg_speed
    cmp #6
    beq _set_faster_ghost_speed
    lda m_bg_speed
    cmp #8
    beq _set_slower_ghost_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_pm_default_speed
    rts
_set_faster_ghost_speed
    jsr set_rg_double_speed
    jsr set_pg_double_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_pm_double_speed
    rts
_set_slower_ghost_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_bg_double_speed
    jsr set_og_double_speed
    jsr set_pm_default_speed
   rts

screen4_speed
    lda p1_screen_num
    cmp #4
    beq _continue
    rts
_continue
    lda m_rg_speed
    cmp #5
    beq _set_faster_ghost_speed
    lda m_bg_speed
    cmp #7
    beq _set_slower_ghost_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_pm_default_speed
    rts
_set_faster_ghost_speed
    jsr set_rg_double_speed
    jsr set_pg_double_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_pm_double_speed
    rts
_set_slower_ghost_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_bg_double_speed
    jsr set_og_double_speed
    jsr set_pm_default_speed
    rts
screen5_speed
    lda p1_screen_num
    cmp #5
    beq _continue
    rts
_continue
    lda m_rg_speed
    cmp #4
    beq _set_faster_ghost_speed
    lda m_bg_speed
    cmp #6
    beq _set_slower_ghost_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_pm_default_speed
    rts
_set_faster_ghost_speed
    jsr set_rg_double_speed
    jsr set_pg_double_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_pm_double_speed
    rts
_set_slower_ghost_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_bg_double_speed
    jsr set_og_double_speed
    jsr set_pm_default_speed
    rts

screen6_speed
    lda p1_screen_num
    cmp #6
    beq _continue
    rts
_continue
    lda m_rg_speed
    cmp #3
    beq _set_faster_ghost_speed
    lda m_bg_speed
    cmp #6
    beq _set_slower_ghost_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_pm_default_speed
    rts
_set_faster_ghost_speed
    jsr set_rg_double_speed
    jsr set_pg_double_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_pm_double_speed
    rts
_set_slower_ghost_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_bg_double_speed
    jsr set_og_double_speed
    jsr set_pm_default_speed
    rts
screen7_speed
    lda p1_screen_num
    cmp #7
    bcs _continue
    rts
_continue
    lda m_rg_speed
    cmp #3
    beq _set_faster_ghost_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_rg_default_speed
    jsr set_pg_default_speed
    jsr set_pm_default_speed
    rts
_set_faster_ghost_speed
    jsr set_rg_double_speed
    jsr set_pg_double_speed
    jsr set_bg_default_speed
    jsr set_og_default_speed
    jsr set_pm_double_speed
    rts

set_rg_double_speed
    stz m_rg_speed
    ldx m_rg_tile_x
    ldy m_rg_tile_y
    jsr get_tile_number
    jsr is_tile_tunnel
    bcc _slow
    lda #2
    sta m_rg_move
    rts
_slow
    lda #0
    sta m_rg_move
    rts

set_pg_double_speed
    stz m_pg_speed
    ldx m_pg_tile_x
    ldy m_pg_tile_y
    jsr get_tile_number
    jsr is_tile_tunnel
    bcc _slow
    lda #2
    sta m_pg_move
    stz m_pg_speed
    rts
_slow
    lda #0
    sta m_pg_move
    rts

set_bg_double_speed
    stz m_bg_speed
    ldx m_bg_tile_x
    ldy m_bg_tile_y
    jsr get_tile_number
    jsr is_tile_tunnel
    bcc _slow
    lda #2
    sta m_bg_move
    rts
_slow
    lda #0
    sta m_bg_move
    rts
set_og_double_speed
    stz m_og_speed
    ldx m_og_tile_x
    ldy m_og_tile_y
    jsr get_tile_number
    jsr is_tile_tunnel
    bcc _slow
    lda #2
    sta m_og_move
    rts
_slow
    lda #0
    sta m_og_move
    rts
set_pm_double_speed
    lda #2
    sta m_pm_move
    stz m_pm_speed
    rts

set_rg_default_speed
    lda #1
    sta m_rg_move
    rts

set_pg_default_speed
    lda #1
    sta m_pg_move
    rts

set_bg_default_speed
    lda #1
    sta m_bg_move
    rts

set_og_default_speed
    lda #1
    sta m_og_move
    rts

set_pm_default_speed
    lda #1
    sta m_pm_move
    rts