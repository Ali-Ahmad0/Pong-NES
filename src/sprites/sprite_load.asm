LOAD_SPRITES:
  LDX #$00
  LOAD_SPRITES_LOOP:
    LDA SPRITES, x  ; Load sprite data
    STA $0200, x    ; Store sprite data
    
    INX
    CPX #$2C        ; No. of sprites * 4 bytes
    BNE LOAD_SPRITES_LOOP
  
  RTS
