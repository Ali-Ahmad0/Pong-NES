INCREMENT_TIMER:
  ; Add 1 to timer
  LDX delay_timer
  INX
  CPX #$2A ; Small delay
  BEQ RESET_TIMER

  JMP STORE_TIMER

  RESET_TIMER:
    LDX #$00

  STORE_TIMER:
    STX delay_timer 

  RTS
