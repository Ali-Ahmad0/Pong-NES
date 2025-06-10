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

.include "controller/controller_1.asm"
.include "controller/controller_2.asm"

.include "game/paddle_1.asm"
.include "game/paddle_2.asm"
.include "game/pong_ball.asm"

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
  
  ; Set ball velocity
  LDA #%00000000  ; positive x
  STA ball_vel_x
  
  LDA #%10000000  ; negative y
  STA ball_vel_x

  LDA #$00
  STA ball_vel_index

  ; Initialize delay flag and timer
  LDY #$FF
  LDA #$00
  STA delay_timer
  
  FOREVER:
    JMP FOREVER

; Non Maskable Interrupt
NMI:
  ; Load sprite range
  LDA #$00
  STA OAM_ADDR
  LDA #$02
  STA OAM_DMA


  ; Handle game updates
  JSR MOV_BALL

  JSR LATCH_CONTROLLER_1
  JSR LATCH_CONTROLLER_2

  JSR MOV_PADDLE_1
  JSR MOV_PADDLE_2

  RTI

; Define what to do when interrupt occurs
.segment "VECTORS"
  .word NMI   
  .word RESET 

.segment "CHARS"
  .incbin "../assets/charset.chr"