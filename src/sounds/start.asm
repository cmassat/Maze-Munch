play_start_music
    lda psg_start_time
    cmp #0
    beq _play
    rts
_play
    lda #1
    sta psg_start_time
    stz psg_start_note_counter
    rts 

psg_start_music
    lda psg_start_note_counter
    cmp #$22
    bcc _play_start
    lda #$0F
    jsr psg_1_volume_mono
    stz psg_start_time
    rts  
_play_start 
    lda psg_start_note_counter
    cmp #0
    bne _continue

    lda #<psg_start
    sta POINTER_PSG
    lda #>psg_start
    sta POINTER_PSG + 1
_continue
    lda psg_start_note_time
    cmp #0
    bne _note_tracker 
    inc psg_start_note_counter

    ldy #1
    lda (POINTER_PSG),y 
    tax 
    ldy #0
    lda (POINTER_PSG),y 
    jsr psg_1_freq_mono

    ldy #2
    lda (POINTER_PSG),y 
    jsr psg_1_volume_mono

    lda POINTER_PSG
    clc 
    adc #3
    sta POINTER_PSG
    lda POINTER_PSG + 1
    adc #0
    sta POINTER_PSG + 1
  
_note_tracker 
    inc psg_start_note_time
    lda psg_start_note_time
    cmp #10
    bne _end 
    stz psg_start_note_time
_end
    rts 

psg_start_time
    .byte 0
psg_start_note_counter
    .byte 0
psg_start_note_time
    .byte 0