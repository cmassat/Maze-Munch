CONST_STATE_ON = 0
CONST_STATE_GAME_MENU = 1
CONST_STATE_GAME_MENU_LOADED = 2
CONST_STATE_GAME_START = 3
CONST_STATE_GAME_PLAY = 4
CONST_STATE_GAME_OVER = 5

state_next
    lda m_game_state
    cmp #CONST_STATE_ON
    beq _init_menu_screen

    lda m_game_state
    cmp #CONST_STATE_GAME_MENU
    beq _menu_loaded

    lda m_game_state 
    cmp #CONST_STATE_GAME_MENU_LOADED
    beq _start_game

    lda m_game_state 
    cmp #CONST_STATE_GAME_START
    beq _play_game

    lda m_game_state
    cmp #CONST_STATE_GAME_PLAY
    beq _game_over

    
    lda m_game_state
    cmp #CONST_STATE_GAME_OVER
    beq _init_menu_screen
    rts 

_init_menu_screen
    lda #CONST_STATE_GAME_MENU
    sta m_game_state
    rts 

_menu_loaded
    lda #CONST_STATE_GAME_MENU_LOADED
    sta m_game_state
    rts 

_start_game
    lda #CONST_STATE_GAME_START
    sta m_game_state
    rts 

_play_game
    lda #CONST_STATE_GAME_PLAY
    sta m_game_state
    rts  

_game_over
    lda #CONST_STATE_GAME_OVER
    sta m_game_state
    rts  