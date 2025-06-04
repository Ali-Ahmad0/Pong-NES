LATCH_CONTROLLER_2:
  LDA #$01
  STA JOY_2
  LDA #$00
  STA JOY_2 ; Tell controller to latch buttons

  LDX #$08
  READ_CONTROLLER_2:
    LDA JOY_2
    LSR
    ROL buttons_2
    DEX
    BNE READ_CONTROLLER_2

  RTS