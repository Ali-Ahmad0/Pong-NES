; iNES ROM header
.segment "HEADER"
  .byte "NES", $1A  ; iNES identifier
  .byte $02           ; PRG ROM
  .byte $01           ; CHR ROM
  .byte $01, $00
