.include "common/header.inc"
.include "common/constants.inc"
.include "common/zeropage.inc"

.segment "STARTUP"

.segment "CODE"
.include "vblankwait.asm"

.include "palettes/palette_load.asm"
.include "palettes/palette_data.inc"

.include "nametable/nam_load.asm"
.include "nametable/nam_data.inc"

.include "sprites/sprite_load.asm"
.include "sprites/sprite_data.inc"

; Reset Interrupt
RESET:
  SEI ; disable IRQs
  CLD ; disable decimal mode

  ; Disable sound IRQ
  LDX #$40
  STX $4017

  ; Disable PCM
  LDX #$00
  STX $4010

  ; Init stack register
  LDX #$FF
  TXS
  INX ; X = 0

  ; Clear PPU registers
  LDX #$00
  STX PPU_CTRL    ; Disable NMI
  LDX #$00
  STX PPU_MASK    ; Disable rendering
  STX $4010       ; Disable DMC IRQs

  ; First wait for vblank
  JSR VBLANKWAIT

  ; Initialize all RAM as $00
  LDA #$00
  CLEAR_MEMORY:
    STA $0000, x    ; $0000-$00FF
    STA $0100, x    ; $0100-$01FF
    STA $0200, x    ; $0200-$02FF
    STA $0300, x    ; $0300-$03FF
    STA $0400, x    ; $0400-$04FF
    STA $0500, x    ; $0500-$05FF
    STA $0600, x    ; $0600-$06FF
    STA $0700, x    ; $0700-$07FF
    INX
    CPX #$00
    BNE CLEAR_MEMORY

  ; Second wait for vblank
  JSR VBLANKWAIT

  ; Reset registers
  LDA #$00
  LDX #$00
  
  ; Load nametable data
  JSR LOAD_NAM

  ; Load background palette
  JSR LOAD_BCK_PAL

  ; Load sprite palette
  JSR LOAD_SPR_PAL

  ; Load sprites
  JSR LOAD_SPRITES

  ; Reset PPU Scroll
  LDA #$00
  STA PPU_SCROLL  ; Set X scroll to 0
  STA PPU_SCROLL  ; Set Y scroll to 0

  ; Enable interrupts 
  CLI
  
  ; Enable rendering
  LDA #%10010000
  STA PPU_CTRL

  ; Enable background, sprites
  LDA #%00011010
  STA PPU_MASK

  ; Enable APU
  LDA #%10010000
  STA APU_STATUS

  FOREVER:
    JMP FOREVER

; NMI Interrupt
NMI:
  ; Load sprite range
  LDA #$00
  STA OAM_ADDR
  LDA #$02
  STA OAM_DMA

  RTI

; Define what to do when interrupt occurs
.segment "VECTORS"
  .word NMI   ; Non Maskable Interrupt
  .word RESET 

.segment "CHARS"
  .incbin "../assets/charset.chr"