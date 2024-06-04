m_game_state
    .byte 0
m_pacman_tile_x
    .byte 0
m_pacman_tile_y
    .byte 0
m_pacman_pixel_x
    .byte 0
m_pacman_pixel_y
    .byte 0
m_pacman_sp_x
    .byte 0,0
m_pacman_sp_y
    .byte 0,0
m_pacman_direction
    .byte 0

m_right_tile_blocked
    .byte 0
m_down_tile_blocked
    .byte 0
m_up_tile_blocked
    .byte 0
m_left_tile_blocked
    .byte 0
m_next_tile_x
    .byte 0,0
m_next_tile_y
    .byte 0,0
m_find_tile
    .byte 0,0,0
m_tile_game_mode
    .byte 0
m_ghost_number_eaten
    .byte 0,0,0,0

m_pg_tile_x
    .byte 0
m_pg_tile_y
    .byte 0
m_pg_pixel_x
    .byte 0
m_pg_pixel_y
    .byte 0
m_pg_direction
    .byte  0
m_pg_chosen_direction
    .byte 0
m_pg_chosen_distance
    .byte 0
m_pg_down_distance
    .byte 0
m_pg_up_distance
    .byte 0
m_pg_right_distance
    .byte 0
m_pg_left_distance
    .byte 0
m_pg_down_blocked
    .byte 0
m_pg_up_blocked
    .byte 0
m_pg_left_blocked
    .byte 0
m_pg_right_blocked
    .byte 0

m_ghost_sp_x
    .byte 0,0
m_ghost_sp_y
    .byte 0,0
m_ghost_tile_x
    .byte 0
m_ghost_pixel_x
  .byte 0
m_ghost_tile_y
  .byte 0
m_ghost_pixel_y
  .byte 0
m_gh_down_blocked
    .byte 0

m_pink_ghost_sp_x
    .byte 0,0
m_pink_ghost_sp_y
    .byte 0,0
m_pink_ghost_tile_x
    .byte 0
m_pink_ghost_pixel_x
  .byte 0
m_pink_ghost_tile_y
  .byte 0
m_pink_ghost_pixel_y
  .byte 0
m_pacman_pink_tile_x
    .byte 0
m_pacman_pink_tile_y
    .byte 0
m_pink_ghost_mode
    .byte 0

m_bg_tile_x
    .byte 0
m_bg_tile_y
    .byte 0
m_bg_pixel_x
    .byte 0
m_bg_pixel_y
    .byte 0
m_bg_direction
    .byte  0
m_bg_chosen_direction
    .byte 0
m_bg_chosen_distance
    .byte 0
m_bg_down_distance
    .byte 0
m_bg_up_distance
    .byte 0
m_bg_right_distance
    .byte 0
m_bg_left_distance
    .byte 0
m_bg_down_blocked
    .byte 0
m_bg_up_blocked
    .byte 0
m_bg_left_blocked
    .byte 0
m_bg_right_blocked
    .byte 0
m_pacman_blue_tile_x
    .byte 0
m_pacman_blue_tile_y
    .byte 0
m_blue_ghost_mode
    .byte 0

m_rg_tile_x
    .byte 0
m_rg_tile_y
    .byte 0
m_rg_pixel_x
    .byte 0
m_rg_pixel_y
    .byte 0
m_rg_direction
    .byte  0
m_rg_chosen_direction
    .byte 0
m_rg_chosen_distance
    .byte 0
m_rg_down_distance
    .byte 0
m_rg_up_distance
    .byte 0
m_rg_right_distance
    .byte 0
m_rg_left_distance
    .byte 0
m_rg_down_blocked
    .byte 0
m_rg_up_blocked
    .byte 0
m_rg_left_blocked
    .byte 0
m_rg_right_blocked
    .byte 0
m_pacman_red_tile_x
    .byte 0
m_pacman_red_tile_y
    .byte 0
m_red_ghost_mode
    .byte 0

m_og_tile_x
    .byte 0
m_og_tile_y
    .byte 0
m_og_pixel_x
    .byte 0
m_og_pixel_y
    .byte 0
m_og_direction
    .byte  0
m_og_chosen_direction
    .byte 0
m_og_chosen_distance
    .byte 0
m_og_down_distance
    .byte 0
m_og_up_distance
    .byte 0
m_og_right_distance
    .byte 0
m_og_left_distance
    .byte 0
m_og_down_blocked
    .byte 0
m_og_up_blocked
    .byte 0
m_og_left_blocked
    .byte 0
m_og_right_blocked
    .byte 0
m_pacman_orange_tile_x
    .byte 0
m_pacman_orange_tile_y
    .byte 0
m_orange_ghost_mode
    .byte 0

m_pacman_caught
    .byte 0
m_pacman_eat_animation
    .byte 0

m_game_mode
    .byte 0
m_game_mode_timer
    .byte 0,0
m_screen_cleared
    .byte 0
m_screen_blink_timer
    .byte 0
m_fruit_timer
    .byte 0,0

p1_screen_num
    .byte 0
p1_dots_count
    .byte 0,0
p1_pp_eaten
    .byte 0,0,0,0
p1_score
    .byte 0,0,0,0
hi_score
    .byte 0,0,0,0
p1_lives
    .byte 0

m_compare
    .byte 0

m_pm_move
    .byte 0
m_rg_move
    .byte 0
m_pg_move
    .byte 0
m_og_move
    .byte 0
m_bg_move
    .byte 0

m_text_b
    .byte 'B','O','N','U','S'

m_text_life
    .byte 'L', 'I','V','E','S'

m_text_score
    .byte 'S','C','O','R','E'
m_text_score_len
    .byte m_text_score_len - m_text_score

m_text_hi_score
    .byte 'H','I', '-' ,'S','C','O','R','E'
m_text_hi_score_len
    .byte m_text_hi_score_len - m_text_hi_score

m_score_100
    .byte '1','0','0'
m_score_100_end
m_score_100_len
    .byte m_score_100_end - m_score_100

m_score_200
    .byte '2','0','0'
m_score_200_end
m_score_200_len
    .byte m_score_200_end - m_score_200

m_score_300
    .byte '3','0','0'
m_score_300_end
m_score_300_len
    .byte m_score_300_end - m_score_300

m_score_400
    .byte '4','0','0'
m_score_400_end
m_score_400_len
    .byte m_score_400_end - m_score_400

m_score_500
    .byte '5','0','0'
m_score_500_end
m_score_500_len
    .byte m_score_500_end - m_score_500

m_score_700
    .byte '7','0','0'
m_score_700_end
m_score_700_len
    .byte m_score_700_end - m_score_700

m_score_800
    .byte '8','0','0'
m_score_800_end
m_score_800_len
    .byte m_score_800_end - m_score_800

m_score_1000
    .byte '1','0','0','0'
m_score_1000_end
m_score_1000_len
    .byte m_score_1000_end - m_score_1000

m_score_1600
    .byte '1','6','0','0'
m_score_1600_end
m_score_1600_len
    .byte m_score_1600_end - m_score_1600

m_score_2000
    .byte '2','0','0','0'
m_score_2000_end
m_score_2000_len
    .byte m_score_2000_end - m_score_2000

m_score_3000
    .byte '3','0','0','0'
m_score_3000_end
m_score_3000_len
    .byte m_score_3000_end - m_score_3000

m_score_5000
    .byte '5','0','0','0'
m_score_5000_end
m_score_5000_len
    .byte m_score_5000_end - m_score_5000

m_print_text_address
    .byte 0,0
m_print_text_length
    .byte 0
m_print_to_tile_x
    .byte 0
m_print_to_tile_y
    .byte 0
m_print_row_chosen
    .byte 0,0

m_ghost_blue_timer
    .byte <$1e0, >$1e0 
    .byte <$1a4, >$1a4 
    .byte <$168, >$168
    .byte <$168, >$168
    .byte <$12c, >$12c
    .byte <$12c, >$12c
    .byte <$12c, >$12c
    .byte <$12c, >$12c
    .byte <$f0, >$f0
    .byte <$f0, >$f0
    .byte <$f0, >$f0
    .byte <$b4, >$b4
    .byte <$78, >$78
    .byte <$78, >$78

m_menu_pacman_x
    .byte 0,0
m_menu_pacman_y
    .byte 0,0

m_menu_rg_x
    .byte 0,0
m_menu_rg_y
    .byte 0,0

m_menu_text_1
    .byte "P","H", "O", "E", "N", "I", "X", " ", "M", "A", "Z" , "E", " ","M", "U", "N", "C", "H"
m_menu_text_1_len
    .byte m_menu_text_1_len - m_menu_text_1

m_menu_text_2
    .text "For the F256K 8 bit."

m_menu_text_3
    .text "Press F1 for 3 lives."
m_menu_text_3_len
    .byte m_menu_text_3_len - m_menu_text_3
m_menu_text_4
    .text "Press F3 for 5 lives."
m_menu_text_4_len
    .byte m_menu_text_4_len - m_menu_text_4

m_text_init
    .byte 0