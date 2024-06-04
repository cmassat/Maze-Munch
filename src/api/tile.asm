tile_map_0_addr
    sta TILE_MAP_0_ADDR_L
    txa
    sta TILE_MAP_0_ADDR_M
    tya
    sta TILE_MAP_0_ADDR_H

    stz TILE_MAP_0_SCROLL_X
    stz TILE_MAP_0_SCROLL_X + 1
    stz TILE_MAP_0_SCROLL_Y
    stz TILE_MAP_0_SCROLL_Y + 1
    rts

tile_map_0_enable_8x8
    lda #$11
    sta TILE_MAP_0_CTRL_REG
    rts

tile_set_0_addr
    sta TILE_SET_0_ADDR_L
    txa
    sta TILE_SET_0_ADDR_M
    tya
    sta TILE_SET_0_ADDR_H
    rts

tile_map_0_size
    sta TILE_MAP_0_SIZE_X
    stx TILE_MAP_0_SIZE_Y
    rts

tile_map_0_scroll
    lda m_tile_scroll
    clc
    adc #1
    sta m_tile_scroll
    lda m_tile_scroll
    sta TILE_MAP_0_SCROLL_X
    rts

m_tile_scroll
    .byte 0