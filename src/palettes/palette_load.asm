; Color palette loading subroutines
LOAD_BCK_PAL:
  LDA #$3F
  STA PPU_ADDR    ; High byte of palette address
  LDA #$00
  STA PPU_ADDR    ; Low byte (starting at $3F00)
  LDX #$00

  ; Background
  LOAD_BCK_PAL_LOOP:
    LDA BCK_PAL, x  ; Load palette data
    STA PPU_DATA    ; Store data in PPU
    INX 
    CPX #$10        ; 16 byte palette
    BNE LOAD_BCK_PAL_LOOP

  RTS

LOAD_SPR_PAL:
  LDA #$3F
  STA PPU_ADDR    ; High byte of palette address  
  LDA #$10
  STA PPU_ADDR    ; Low byte (starting at $3F10)
  LDX #$00

  ; Sprite
  LOAD_SPR_PAL_LOOP:
    LDA SPR_PAL, x  ; Load palette data
    STA PPU_DATA    ; Store data in PPU
    INX 
    CPX #$10        ; 16 byte palette
    BNE LOAD_SPR_PAL_LOOP

  RTS