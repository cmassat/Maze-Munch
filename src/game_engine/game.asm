sounds
    jsr psg_eat_ghost_sound
    jsr psg_eat_dot_sound
    jsr psg_eat_dot_pp_sound
    jsr psg_eat_pacman_sound
    jsr psg_start_music
    rts

show_text
    jsr init_text_score
    jsr init_text_hi_score
    jsr display_hi_score
    jsr display_p1_score
    jsr init_lives_sprites
    jsr init_text_bonus
    jsr init_text_lives
    jsr init_text_hi_score
    rts

init_ghosts
    jsr init_rg
    jsr init_pg
    jsr init_bg
    jsr init_og
    lda #CONST_GAME_MODE_HOME
    sta m_game_mode
    sta m_red_ghost_mode
    sta m_pink_ghost_mode
    sta m_blue_ghost_mode
    sta m_orange_ghost_mode
    stz m_rg_speed
    stz m_pg_speed
    stz m_bg_speed
    stz m_og_speed
    stz m_pm_speed
    rts

m_init_game
    .byte 0

init_game
    lda m_init_game
    cmp #1
    bne _init_game
    rts
_init_game
    jsr reset_board
    lda #1
    sta m_init_game
    rts

game_event_processing
    jsr sounds
    lda m_game_state
    cmp #CONST_STATE_GAME_PLAY
    beq _event_processing
    lda #$11
    sta $d200
    rts
_event_processing
    lda psg_start_time
    cmp #0
    bne _wait_start
    jsr ghost_set_speed
    jsr handle_game
    jsr handle_blue_screen_timer
    jsr ghost_speed
    jsr check_game_over_event
_wait_start
    rts

reset_game_text
    stz m_text_init
    rts

game_offscreen_processing
    lda m_game_state
    cmp #CONST_STATE_GAME_START
    beq _offscreen_init_game

    lda m_game_state
    cmp #CONST_STATE_GAME_PLAY
    beq _offscreen_playing
    rts
_offscreen_playing
    jsr show_text
    jsr display_hi_score
    jsr display_p1_score
    jsr set_hi_score
    jsr fruit_controller
    rts
_offscreen_init_game
    lda m_text_init
    cmp #0
    beq _init_text
    jsr reset_dots
    jsr init_power_dots
    jsr display_p1_score
    jsr display_hi_score
    stz psg_start_time
    stz note_time
    stz m_extra_life
    rts
_init_text
    jsr display_hi_score
    jsr vcky_disable_all_bmp
    jsr init_maze
    jsr init_pacman
    jsr init_pm
    jsr init_power_dots
    jsr init_ghosts
    jsr screen_cleared
    jsr reset_board
    jsr vcky_double_text_x
    jsr clear_screen
    stz p1_screen_num
    stz p1_score
    stz p1_score + 1
    stz p1_score + 2
    stz p1_score + 3
    stz p1_dots_count
    stz p1_pp_eaten
    stz psg_eat_ghost_time
    stz m_screen_cleared
    jsr play_start_music

    jsr game_mode_set_ghost_home
    jsr game_mode_set_chase
    lda #1
    sta m_text_init
    jsr state_next
    rts

handle_blue_screen_timer
   lda m_screen_blink_timer
   cmp #0
   bne _count_down
   rts
_count_down
   dec m_screen_blink_timer
   rts

handle_game
    lda m_game_state
    cmp #CONST_STATE_GAME_PLAY
    beq _play_game
    rts
_play_game
    jsr is_screen_clear
    bcs _keep_playing
    jsr blink_screen_bkg
    jsr text_load_default_palette
    jsr text_bw_screen
    rts
_keep_playing
    jsr fruit_timer
    lda m_pacman_caught
    cmp #1
    bne _still_alive
    jsr munched_animation
    jsr play_eat_pacman
    jsr game_mode_set_chase
    rts
_still_alive
    lda psg_eat_ghost_time
    cmp #1
    bne _freeze_eat_ghost
    jsr clear_screen
    jsr reset_game_text
_freeze_eat_ghost
    lda psg_eat_ghost_time
    cmp #0
    beq _continue
    rts
_continue
    jsr game_mode_track_mode
    jsr check_rg_munched_pacman
    jsr check_bg_munched_pacman
    jsr check_og_munched_pacman
    jsr check_pg_munched_pacman
    jsr check_fruit_munched
    jsr play_start_siren

    jsr handle_joy_ports
    jsr handle_movement
    jsr handle_pc_sprite
    jsr handle_ghost_movement
    rts

reset_board
    stz m_pacman_caught
    jsr init_ghosts
    jsr init_pm
    rts

screen_cleared
    jsr blink_screen
    jsr reset_board
    jsr reset_dots
    jsr init_power_dots
    jsr game_mode_set_ghost_home

    lda #CONST_GAME_MODE_SCATTER
    sta m_game_mode
    stz p1_dots_count
    stz p1_dots_count + 1
    stz p1_pp_eaten
    stz p1_pp_eaten + 1
    stz p1_pp_eaten + 2
    stz p1_pp_eaten + 3
    lda #1
    sta m_screen_cleared
    stz m_rg_speed
    stz m_pg_speed
    stz m_bg_speed
    stz m_og_speed
    stz m_pm_speed
    jsr psg_turn_off

    lda p1_screen_num
    clc
    adc #1
    sta p1_screen_num
_not_cleared
rts

is_screen_clear
    lda m_screen_cleared
    cmp #1
    beq _clear
    sec
    rts
_clear
    clc
    rts

blink_screen
    lda #61
    sta m_screen_blink_timer
    rts

blink_screen_bkg
    lda m_screen_blink_timer
    cmp #0
    bne _blink_screen

    lda m_screen_cleared
    cmp #1
    bne _end_blink
    stz m_screen_cleared
_end_blink
    rts
_blink_screen
    lda m_screen_blink_timer
    cmp #60
    bne _blink_screen_45
    jsr clut_set_clut_blank
    rts
_blink_screen_45
    lda m_screen_blink_timer
    cmp #45
    bne _blink_screen_30
    jsr clut_set_clut0
    rts
_blink_screen_30
    lda m_screen_blink_timer
    cmp #30
    bne _blink_screen_15
    jsr clut_set_clut_blank
    rts
_blink_screen_15
    lda m_screen_blink_timer
    cmp #15
    bne _blink_screen_0
    jsr clut_set_clut0
_blink_screen_0
    lda m_screen_blink_timer
    cmp #0
    bne _end
    stz m_screen_cleared
_end
    rts

blink_white
    lda m_game_mode
    cmp #CONST_GAME_MODE_FRIGHTENED
    bne _not_frightened

    lda m_game_mode_timer + 1
    cmp #0
    bne _not_frightened

    lda m_game_mode_timer
    cmp #120
    bcs _not_frightened
    clc
    rts
_not_frightened
    sec
    rts

check_game_over_event
    lda psg_eat_pacman_time
    cmp #0
    bne _not_game_over
    lda p1_lives
    bne _not_game_over
    jsr state_next
    jsr clear_screen
    jsr psg_turn_off
_not_game_over
    rts