; Color palette loading subroutines
; Background
LOAD_BCK_PAL:
  LDA BCK_PAL, x  ; Load palette data
  STA PPU_DATA    ; Store data in PPU
  INX 
  CPX #$10        ; 16 byte palette
  BNE LOAD_BCK_PAL

  RTS


; Sprite
LOAD_SPR_PAL:
  LDA SPR_PAL, x  ; Load palette data
  STA PPU_DATA    ; Store data in PPU
  INX 
  CPX #$10        ; 16 byte palette
  BNE LOAD_SPR_PAL

  RTS