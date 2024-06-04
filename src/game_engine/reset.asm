reset_all
    jsr sprite_disable_all
    jsr vcky_tile_sprite
    jsr psg_turn_off

    jsr clear_screen
    jsr init_maze
    jsr init_pacman
    jsr init_power_dots
    jsr init_ghosts
    stz p1_screen_num
    stz p1_score
    stz p1_dots_count
    stz p1_pp_eaten
    rts 