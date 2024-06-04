play_start_siren
    lda #8
    jsr psg_1_volume_mono
    lda note_time
    cmp #0
    beq _play_hi
    lda note_time
    cmp #20
    beq _play_lo 
    inc note_time

    lda note_time
    cmp #40
    bne _continue 
    stz note_time
_continue 
    lda note_time
    cmp #41
    bcc _end
    stz note_time 
_end 
    rts 
_play_hi
    inc note_time
    lda #<PSG_NOTE_G4
    ldx #>PSG_NOTE_G4
    jsr psg_1_freq_mono
    rts 

_play_lo 
    inc note_time
    lda #<PSG_NOTE_E4
    ldx #>PSG_NOTE_E4
    jsr psg_1_freq_mono
    rts 

memory_game 
note_time
    .byte 0
note_flag
    .byte 0
note_counter
    .byte 0