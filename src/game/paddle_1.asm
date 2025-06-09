MOV_PADDLE_1:
  READ_UP_1:
    ; Check for up button pressed
    LDA buttons_1
    AND #$08
    BEQ READ_DOWN_1

    LDX #$00
    MOV_UP_1:
      LDA $020C, x  ; Load paddle y position
      SEC           ; Set carry
      SBC #$01      ; y = y - 1

      STA $020C, x  ; Save paddle y position

      ; Counter + 4
      TXA
      CLC
      ADC #$04
      TAX

      CPX #$10
      BNE MOV_UP_1 

  READ_DOWN_1:
    ; Check for down button pressed
    LDA buttons_1
    AND #$04
    BEQ READ_DONE_1

    LDX #$00
    MOV_DOWN_1:
      LDA $020C, x  ; Load paddle y position
      CLC           ; Clear carry
      ADC #$01      ; y = y + 1

      STA $020C, x  ; Save paddle y position

      ; Counter + 4
      TXA
      CLC
      ADC #$04
      TAX

      CPX #$10
      BNE MOV_DOWN_1

  READ_DONE_1:
    RTS