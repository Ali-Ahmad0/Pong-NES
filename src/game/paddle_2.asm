MOV_PADDLE_2:
  READ_UP_2:
    ; Check for up button pressed
    LDA buttons_2
    AND #$08
    BEQ READ_DOWN_2

    LDX #$00
    MOV_UP_2:
      LDA $021C, x  ; Load paddle y position
      SEC           ; Set carry
      SBC #$01      ; y = y - 1

      STA $021C, x  ; Save paddle y position

      ; Counter + 4
      TXA
      CLC
      ADC #$04
      TAX

      CPX #$10
      BNE MOV_UP_2

  READ_DOWN_2:
    ; Check for down button pressed
    LDA buttons_2
    AND #$04
    BEQ READ_DONE_2

    LDX #$00
    MOV_DOWN_2:
      LDA $021C, x  ; Load paddle y position
      CLC           ; Clear carry
      ADC #$01      ; y = y + 1

      STA $021C, x  ; Save paddle y position

      ; Counter + 4
      TXA
      CLC
      ADC #$04
      TAX

      CPX #$10
      BNE MOV_DOWN_2

  READ_DONE_2:
    RTS