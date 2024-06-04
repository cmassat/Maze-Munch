play_eat_ghost 
    lda #30
    sta psg_eat_ghost_time
    rts 

psg_eat_ghost_sound
    lda psg_eat_ghost_time
    cmp #0
    bne _play
    rts
_play
    lda psg_eat_ghost_time
    cmp #30
    bne _not_60 
    lda #0
    sta psg_eat_ghost_volume
    lda psg_eat_ghost_volume
    lda #<PSG_NOTE_G4
    ldx #>PSG_NOTE_G4
    jsr psg_3_freq_mono
_not_60 
    lda psg_eat_ghost_time
    cmp #20
    bne _not_40
    lda #0
    sta psg_eat_ghost_volume
    lda psg_eat_ghost_volume
    jsr psg_3_volume_mono
    lda #<PSG_NOTE_C4
    ldx #>PSG_NOTE_C4
    jsr psg_3_freq_mono
_not_40
    lda psg_eat_ghost_time
    cmp #10
    bne _not_20
    lda #0
    sta psg_eat_ghost_volume
    lda psg_eat_ghost_volume
    lda #<PSG_NOTE_D5
    ldx #>PSG_NOTE_D5
    jsr psg_3_freq_mono
_not_20
    lda psg_eat_ghost_time
    cmp #1
    bne _not_1
    lda #$0f 
    jsr psg_3_volume_mono 
    jsr clear_screen
    stz psg_eat_ghost_time
    rts
_not_1
    dec psg_eat_ghost_time
    rts

psg_eat_ghost_time
    .byte 0
psg_eat_ghost_volume
    .byte 0
