LATCH_CONTROLLER_1:
  LDA #$01
  STA JOY_1
  LDA #$00
  STA JOY_1 ; Tell controller to latch buttons

  LDX #$08
  READ_CONTROLLER_1:
    LDA JOY_1
    LSR
    ROL buttons_1
    DEX
    BNE READ_CONTROLLER_1

  RTS