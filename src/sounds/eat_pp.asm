play_eat_pp
    lda psg_pp_time
    cmp #0
    beq _play
    rts
_play
    lda #10
    sta psg_pp_time
    rts 

psg_eat_dot_pp_sound 
    lda psg_pp_time
    cmp #0
    bne _play
    rts
_play
    lda psg_pp_time
    cmp #1
    beq _turn_off_volume
    bra _check_volume
_turn_off_volume
    lda #15
    jsr psg_3_volume_mono
    bra _play_sound
_check_volume
    lda psg_pp_time
    cmp #10
    beq _set_volume
    bra _play_sound 
_set_volume
    lda #0 
    jsr psg_3_volume_mono
_play_sound 
    lda #<PSG_NOTE_G3
    ldx #>PSG_NOTE_G3
    jsr psg_3_freq_mono
    dec psg_pp_time
    rts 
psg_pp_time
    .byte 0
