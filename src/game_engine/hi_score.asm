set_hi_score
    lda hi_score + 3
    cmp p1_score + 3
    beq _check_byte_2
    bcs _no_new_hi_score
    bcc _set_hi_score
    rts

_check_byte_2
    lda hi_score + 2
    cmp p1_score + 2
    beq _check_byte_1
    bcs _no_new_hi_score
    bcc _set_hi_score
    rts
_check_byte_1
    lda hi_score + 1
    cmp p1_score + 1
    beq _check_byte_0
    bcs _no_new_hi_score
    bcc _set_hi_score
    rts
_check_byte_0
    lda p1_score
    cmp hi_score
    bcs _set_hi_score
    rts

_no_new_hi_score
    rts

_set_hi_score
    lda p1_score
    sta hi_score
    lda p1_score + 1
    sta hi_score + 1
    lda p1_score + 2
    sta hi_score + 2
    lda p1_score + 3
    sta hi_score + 3
    rts