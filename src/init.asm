init_maze
    jsr vcky_tile_sprite
    jsr clut_set_clut0
    lda #<set_0
    ldx #>set_0
    ldy #`set_0
    jsr tile_set_0_addr
    lda #<map_0
    ldx #>map_0
    ldy #`map_0
    jsr tile_map_0_addr

    jsr vcky_background_black
    lda #40
    ldx #30
    jsr tile_map_0_size
    jsr tile_map_0_enable_8x8
    
    lda #CONST_GAME_MODE_CHASE
    sta m_game_mode
    lda #$11
    sta TILE_MAP_0_CTRL_REG
rts 

init_splash
    jsr vcky_tile_sprite_bmp
    jsr clear_screen
    jsr sprite_disable_all
    
    jsr clut_set_clut2
    lda #<$30000
    sta $d101

    lda #>$30000
    sta $d102
    
    lda #`$30000
    sta $d103

    lda #%00000101
    sta $D100 

    jsr vcky_background_white
    rts 

init_pacman
    jsr clut_set_clut1
    stz MMU_IO_CTRL

    lda #0
    jsr sprite_set_number

    lda #CONST_PM_INIT_TILE_X
    ldx #0
    jsr sprite_set_x

    lda #CONST_PM_INIT_TILE_Y
    ldx #0
    jsr sprite_set_y

    lda #<PACMAN_RIGHT
    ldx #>PACMAN_RIGHT
    ldy #`PACMAN_RIGHT
    jsr sprite_set_address

    lda #CONST_DIRECTION_RIGHT
    sta m_pacman_direction

    lda #0
    jsr sprite_set_number

    jsr sprite_enable
    jsr init_pm
    jsr plot_pm
    rts 

init_power_dots
    lda #CONST_SPRITE_NUMBER_POWER_DOT_1
    jsr sprite_set_number

    lda #<CONST_POWER_DOT_SPRITE 
    ldx #>CONST_POWER_DOT_SPRITE
    ldy #`CONST_POWER_DOT_SPRITE
    jsr sprite_set_address

    lda #CONST_SPRITE_PD_1_X
    ldx #0
    jsr plot_ghost_x

    lda #CONST_SPRITE_PD_1_Y
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
_powerdot2 
    lda #CONST_SPRITE_NUMBER_POWER_DOT_2
    jsr sprite_set_number

    lda #<CONST_POWER_DOT_SPRITE 
    ldx #>CONST_POWER_DOT_SPRITE
    ldy #`CONST_POWER_DOT_SPRITE
    jsr sprite_set_address

    lda #CONST_SPRITE_PD_2_X
    ldx #0
    jsr plot_ghost_x

    lda #CONST_SPRITE_PD_2_Y
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable

_powerdot3
    lda #CONST_SPRITE_NUMBER_POWER_DOT_3
    jsr sprite_set_number

    lda #<CONST_POWER_DOT_SPRITE 
    ldx #>CONST_POWER_DOT_SPRITE
    ldy #`CONST_POWER_DOT_SPRITE
    jsr sprite_set_address

    lda #CONST_SPRITE_PD_3_X
    ldx #0
    jsr plot_ghost_x

    lda #CONST_SPRITE_PD_3_Y
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
_powerdot4
    lda #CONST_SPRITE_NUMBER_POWER_DOT_4
    jsr sprite_set_number

    lda #<CONST_POWER_DOT_SPRITE 
    ldx #>CONST_POWER_DOT_SPRITE
    ldy #`CONST_POWER_DOT_SPRITE
    jsr sprite_set_address

    lda #CONST_SPRITE_PD_4_X
    ldx #0
    jsr plot_ghost_x

    lda #CONST_SPRITE_PD_4_Y
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
rts

init_text_bonus
    ldx #38
    ldy #5
    jsr print_set_tile_position

    lda #<m_text_b 
    ldx #>m_text_b
    ldy #1
    jsr print_set_text_address
    jsr print_text
;_________________________
    ldx #38
    ldy #6
    jsr print_set_tile_position

    lda #<m_text_b + 1 
    ldx #>m_text_b + 1
    ldy #1
    jsr print_set_text_address
    jsr print_text
;_________________________
    ldx #38
    ldy #7
    jsr print_set_tile_position

    lda #<m_text_b + 2 
    ldx #>m_text_b + 2 
    ldy #1
    jsr print_set_text_address
    jsr print_text
;_________________________
    ldx #38
    ldy #8
    jsr print_set_tile_position

    lda #<m_text_b + 3 
    ldx #>m_text_b + 3
    ldy #1
    jsr print_set_text_address
    jsr print_text
;_________________________
    ldx #38
    ldy #9
    jsr print_set_tile_position

    lda #<m_text_b + 4 
    ldx #>m_text_b + 4
    ldy #1
    jsr print_set_text_address
    jsr print_text
    rts 

init_text_lives
    ldx #0
    ldy #5
    jsr print_set_tile_position

    lda #<m_text_life 
    ldx #>m_text_life
    ldy #1
    jsr print_set_text_address
    jsr print_text
;_________________________
    ldx #0
    ldy #6
    jsr print_set_tile_position

    lda #<m_text_life + 1 
    ldx #>m_text_life + 1
    ldy #1
    jsr print_set_text_address
    jsr print_text
;_________________________
    ldx #0
    ldy #7
    jsr print_set_tile_position

    lda #<m_text_life + 2 
    ldx #>m_text_life + 2 
    ldy #1
    jsr print_set_text_address
    jsr print_text
;_________________________
    ldx #0
    ldy #8
    jsr print_set_tile_position

    lda #<m_text_life + 3 
    ldx #>m_text_life + 3
    ldy #1
    jsr print_set_text_address
    jsr print_text
;_________________________
    ldx #0
    ldy #9
    jsr print_set_tile_position

    lda #<m_text_life + 4 
    ldx #>m_text_life + 4
    ldy #1
    jsr print_set_text_address
    jsr print_text
    rts 

init_text_score
    ldx #5
    ldy #0
    jsr print_set_tile_position

    lda #<m_text_score 
    ldx #>m_text_score
    ldy #5
    jsr print_set_text_address
    jsr print_text
    rts 


init_text_hi_score
    ldx #19
    ldy #0
    jsr print_set_tile_position

    lda #<m_text_hi_score 
    ldx #>m_text_hi_score
    ldy m_text_hi_score_len
    jsr print_set_text_address
    jsr print_text
    rts 

init_lives_sprites
    jsr disable_all_lives
    lda p1_lives
    cmp #6
    bne _check_5_lives
    jsr show_life_5
    jsr show_life_4
    jsr show_life_3
    jsr show_life_2
    jsr show_life_1
    rts  
_check_5_lives
    lda p1_lives
    cmp #5
    bne _check_4_lives
    jsr show_life_4
    jsr show_life_3
    jsr show_life_2
    jsr show_life_1
    rts
_check_4_lives
    lda p1_lives
    cmp #4
    bne _check_3_lives
    jsr show_life_3
    jsr show_life_2
    jsr show_life_1
    rts
_check_3_lives
    lda p1_lives
    cmp #3
    bne _check_2_lives
    jsr show_life_2
    jsr show_life_1
    rts 
_check_2_lives
    lda p1_lives
    cmp #2
    bne _check_1_life
    jsr show_life_1
    rts 
_check_1_life
    lda p1_lives
    cmp #1
    bne _check_0_lives
    rts 
_check_0_lives
    rts 

show_life_1
    lda #CONST_SPRITE_NUMBER_LIFE_1
    jsr sprite_set_number

    lda #<CONST_PC_SPRITE_RIGHT
    ldx #>CONST_PC_SPRITE_RIGHT
    ldy #`CONST_PC_SPRITE_RIGHT
    jsr sprite_set_address

    lda #1
    ldx #0
    jsr plot_ghost_x

    lda #11
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts

show_life_2
    lda #CONST_SPRITE_NUMBER_LIFE_2
    jsr sprite_set_number

    lda #<CONST_PC_SPRITE_RIGHT
    ldx #>CONST_PC_SPRITE_RIGHT
    ldy #`CONST_PC_SPRITE_RIGHT
    jsr sprite_set_address

    lda #1
    ldx #0
    jsr plot_ghost_x

    lda #14
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts 

show_life_3
     lda #CONST_SPRITE_NUMBER_LIFE_3
    jsr sprite_set_number

    lda #<CONST_PC_SPRITE_RIGHT
    ldx #>CONST_PC_SPRITE_RIGHT
    ldy #`CONST_PC_SPRITE_RIGHT
    jsr sprite_set_address

    lda #1
    ldx #0
    jsr plot_ghost_x

    lda #17
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts

show_life_4
    lda #CONST_SPRITE_NUMBER_LIFE_4
    jsr sprite_set_number

    lda #<CONST_PC_SPRITE_RIGHT
    ldx #>CONST_PC_SPRITE_RIGHT
    ldy #`CONST_PC_SPRITE_RIGHT
    jsr sprite_set_address

    lda #1
    ldx #0
    jsr plot_ghost_x

    lda #20
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts

show_life_5
    lda #CONST_SPRITE_NUMBER_LIFE_5
    jsr sprite_set_number

    lda #<CONST_PC_SPRITE_RIGHT
    ldx #>CONST_PC_SPRITE_RIGHT
    ldy #`CONST_PC_SPRITE_RIGHT
    jsr sprite_set_address

    lda #1
    ldx #0
    jsr plot_ghost_x

    lda #23
    ldx #0
    jsr plot_ghost_y

    jsr sprite_enable
    rts

show_life_0
    rts


disable_all_lives
    jsr disable_life1
    jsr disable_life2
    jsr disable_life3
    jsr disable_life4
    jsr disable_life5
    rts 
disable_life1 
    lda #CONST_SPRITE_NUMBER_LIFE_1
    jsr sprite_set_number
    jsr sprite_disable
    rts 

disable_life2 
    lda #CONST_SPRITE_NUMBER_LIFE_2
    jsr sprite_set_number
    jsr sprite_disable
    rts 

disable_life3
    lda #CONST_SPRITE_NUMBER_LIFE_3
    jsr sprite_set_number
    jsr sprite_disable
    rts 
disable_life4 
    lda #CONST_SPRITE_NUMBER_LIFE_4
    jsr sprite_set_number
    jsr sprite_disable
    rts 
disable_life5 
    lda #CONST_SPRITE_NUMBER_LIFE_5
    jsr sprite_set_number
    jsr sprite_disable
    rts 

