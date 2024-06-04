play_eat_pacman
    lda psg_eat_pacman_time 
    cmp #0
    beq _play 
    rts
_play 
    lda #60
    sta psg_eat_pacman_time
    rts 

psg_eat_pacman_sound
    lda psg_eat_pacman_time
    cmp #0
    bne _play
    rts
_play
    lda #0
    jsr psg_3_volume_mono
    lda psg_eat_pacman_time
    cmp #60
    bne _not_60 

    lda #<PSG_NOTE_D3
    ldx #>PSG_NOTE_D3
    jsr psg_3_freq_mono
_not_60 
    lda psg_eat_pacman_time
    cmp #40
    bne _not_40

    lda #<PSG_NOTE_C3
    ldx #>PSG_NOTE_C3
    jsr psg_3_freq_mono
_not_40
    lda psg_eat_pacman_time
    cmp #20
    bne _not_20
    lda #<PSG_NOTE_B3
    ldx #>PSG_NOTE_B3
    jsr psg_3_freq_mono
_not_20
    lda psg_eat_pacman_time
    cmp #1
    bne _not_1
    lda #$0f 
    jsr psg_3_volume_mono 
    stz psg_eat_pacman_time
    rts
_not_1
    dec psg_eat_pacman_time
    rts 

psg_eat_pacman_time
    .byte 0
psg_eat_pacman_volume
    .byte 0
