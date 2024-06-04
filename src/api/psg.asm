SYS_CTRL = $d6a1

PSG_MONO_REG = $d608
PSG_LEFT_REG = $d610
PSG_RIGHT_REG = $d600

PSG_LOW_FREQ_MASK = %10000000
PSG_HIGH_FREQ_MASK = %00000000
PSG_TONE_1_FREQ_MASK = %00000000
PSG_TONE_1_ATTN_MASK = %10010000
PSG_TONE_2_FREQ_MASK = %00100000
PSG_TONE_2_ATTN_MASK = %10110000
PSG_TONE_3_FREQ_MASK = %01000000
PSG_TONE_3_ATTN_MASK = %11010000
PSG_TONE_4_FREQ_MASK = %01100000
PSG_TONE_4_ATTN_MASK = %11110000

PSG_NOISE_MASK = %11100000

psg_stereo
    lda SYS_CTRL
    ora #%00000100
    sta SYS_CTRL
    rts

psg_mono
    lda SYS_CTRL
    and #%11111011
    sta SYS_CTRL
    rts

psg_1_freq_mono
    sta PSG_FREQ_L
    stx PSG_FREQ_H

    lda PSG_FREQ_L
    and #$0f
    ora #PSG_LOW_FREQ_MASK | PSG_TONE_1_FREQ_MASK
    sta PSG_MONO_REG
    clc
    rol PSG_FREQ_L
    rol PSG_FREQ_H
    rol PSG_FREQ_L
    rol PSG_FREQ_H
    rol PSG_FREQ_L
    rol PSG_FREQ_H
    rol PSG_FREQ_L
    rol PSG_FREQ_H

    lda PSG_FREQ_H
    sta PSG_MONO_REG
    rts

psg_noise_mono
    lda #$E4
    ora #PSG_NOISE_MASK
    sta PSG_MONO_REG
    rts

psg_noise_vol
    ora #PSG_TONE_4_ATTN_MASK
    sta PSG_MONO_REG
    rts
;a register 0-15
; 0 is the loudest
psg_1_volume_mono
    sta PSG_VOLUME
    lda #PSG_TONE_1_ATTN_MASK
    ora PSG_VOLUME
    sta PSG_MONO_REG
    rts

psg_2_volume_mono
    sta PSG_VOLUME
    lda #PSG_TONE_2_ATTN_MASK
    ora PSG_VOLUME
    sta PSG_MONO_REG
    rts

psg_2_freq_mono
    sta PSG_FREQ_L
    stx PSG_FREQ_H

    lda PSG_FREQ_L
    and #$0f
    ora #PSG_LOW_FREQ_MASK | PSG_TONE_2_FREQ_MASK
    sta PSG_LEFT_REG
    clc
    rol PSG_FREQ_L
    rol PSG_FREQ_H
    rol PSG_FREQ_L
    rol PSG_FREQ_H
    rol PSG_FREQ_L
    rol PSG_FREQ_H
    rol PSG_FREQ_L
    rol PSG_FREQ_H

    lda PSG_FREQ_H
    sta PSG_MONO_REG
    rts

psg_3_volume_mono
    sta PSG_VOLUME
    lda #PSG_TONE_3_ATTN_MASK
    ora PSG_VOLUME
    sta PSG_MONO_REG
    rts

psg_3_freq_mono
    sta PSG_FREQ_L
    stx PSG_FREQ_H

    lda PSG_FREQ_L
    and #$0f
    ora #PSG_LOW_FREQ_MASK | PSG_TONE_3_FREQ_MASK
    sta PSG_LEFT_REG
    clc
    rol PSG_FREQ_L
    rol PSG_FREQ_H
    rol PSG_FREQ_L
    rol PSG_FREQ_H
    rol PSG_FREQ_L
    rol PSG_FREQ_H
    rol PSG_FREQ_L
    rol PSG_FREQ_H

    lda PSG_FREQ_H
    sta PSG_MONO_REG
    rts

psg_noise_tone_mono
    rts

psg_noise_freq_mono
    rts

psg_turn_off
    lda #$0F
    jsr psg_1_volume_mono
    jsr psg_2_volume_mono
    jsr psg_3_volume_mono
    rts
memory_psg
PSG_FREQ_L
    .byte 0
PSG_FREQ_H
    .byte 0
PSG_VOLUME
    .byte 0