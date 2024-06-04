score_fruit
    jsr play_eat_ghost
    lda p1_screen_num
    cmp #1
    bcc _cherry 

    lda p1_screen_num
    cmp #2
    bcc _strawberry

    lda p1_screen_num
    cmp #4
    bcc _peach

    lda p1_screen_num
    cmp #6
    bcc _apple

    lda p1_screen_num
    cmp #8
    bcc _melon 

    lda p1_screen_num
    cmp #10
    bcc _galaxian

    lda p1_screen_num
    cmp #12
    bcc _bell
    bcs _key
    rts 
_cherry
    lda #%00000000
    ldx #%00000001
    ldy #%00000000
    jsr add_to_score

    jsr display_fs_100
    rts 
_strawberry
    lda #%00000000
    ldx #%00000011
    ldy #%00000000
    jsr add_to_score

    jsr display_fs_300
    rts 
_peach
    lda #%00000000
    ldx #%00000101
    ldy #%00000000
    jsr add_to_score

    jsr display_fs_500
    rts
_apple
    lda #%00000000
    ldx #%00000111
    ldy #%00000000
    jsr add_to_score
    jsr display_fs_700

    rts 
_melon
    lda #%00000000
    ldx #%00010000
    ldy #%00000000
    jsr add_to_score

   jsr display_fs_1000
    rts 
_galaxian
    lda #%00000000
    ldx #%00100000
    ldy #%00000000
    jsr add_to_score

    jsr display_fs_2000
    rts 
_bell
    lda #%00000000
    ldx #%00110000
    ldy #%00000000
    jsr add_to_score

    jsr display_fs_3000
    rts 
_key
    lda #%00000000
    ldx #%01010000
    ldy #%00000000
    jsr add_to_score

    jsr display_fs_5000
    rts

add_to_score
    sed
    clc
    adc p1_score
    sta p1_score

    txa 
    adc p1_score+1
    sta p1_score+1

    tya 
    adc p1_score+2
    sta p1_score+2
    
    cld    
    rts

display_fs_100 
    lda #<m_score_100
    ldx #>m_score_100
    ldy m_score_100_len
    jsr display_fruitscore
    rts

display_fs_300
    lda #<m_score_300
    ldx #>m_score_300
    ldy m_score_300_len
    jsr display_fruitscore
    rts

display_fs_500
    lda #<m_score_500
    ldx #>m_score_500
    ldy m_score_500_len
    jsr display_fruitscore
    rts

display_fs_700
    lda #<m_score_700
    ldx #>m_score_700
    ldy m_score_700_len
    jsr display_fruitscore
    rts

display_fs_1000
    lda #<m_score_1000
    ldx #>m_score_1000
    ldy m_score_1000_len
    jsr display_fruitscore
    rts

display_fs_2000
    lda #<m_score_2000
    ldx #>m_score_2000
    ldy m_score_2000_len
    jsr display_fruitscore
    rts

display_fs_3000
    lda #<m_score_3000
    ldx #>m_score_3000
    ldy m_score_3000_len
    jsr display_fruitscore
    rts

display_fs_5000
    lda #<m_score_5000
    ldx #>m_score_5000
    ldy m_score_5000_len
    jsr display_fruitscore
    rts

display_fruitscore
    jsr print_set_text_address
    
    lda #CONST_FRUIT_TILE_X
    clc
    adc #3
    tax 
    ldy #CONST_FRUIT_TILE_Y
    jsr print_set_tile_position
     
    jsr print_text

    rts 