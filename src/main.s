.include "common/header.inc"
.include "common/constants.inc"
.include "common/zeropage.inc"

.segment "STARTUP"

.segment "CODE"
.include "common/palettes.inc"

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

  ; Load background palettes
  LDX #$00
  JSR LOAD_BCK_PAL

  ; Load sprite palettes
  LDX #$00
  JSR LOAD_SPR_PAL

  ; Reset PPU Scroll
  LDA #$00
  STA PPU_SCROLL

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

; Wait for vblank subroutine
VBLANKWAIT:
  BIT PPU_STATUS
  BPL VBLANKWAIT
  RTS

; Define what to do when interrupt occurs
.segment "VECTORS"
  .word NMI   ; Non Maskable Interrupt
  .word RESET 

.segment "CHARS"