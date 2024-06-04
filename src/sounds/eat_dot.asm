play_eat_dot
    lda psg_dot_time
    cmp #0
    beq _play
    rts
_play
    lda #10
    sta psg_dot_time
    rts 

psg_eat_dot_sound 
    lda psg_dot_time
    cmp #0
    bne _play
    rts
_play
    lda psg_dot_time
    cmp #1
    beq _turn_off_volume
    bra _check_volume
_turn_off_volume
    lda #15
    jsr psg_2_volume_mono
    bra _play_sound
_check_volume
    lda psg_dot_time
    cmp #10
    beq _set_volume
    bra _play_sound 
_set_volume
    lda #0 
    jsr psg_2_volume_mono
_play_sound 
    lda #<PSG_NOTE_A3
    ldx #>PSG_NOTE_A3
    jsr psg_2_freq_mono
    dec psg_dot_time
    rts

psg_dot_time
    .byte 0
