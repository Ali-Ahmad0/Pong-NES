MOV_PADDLE_1:
  READ_UP:
    ; Check for up button pressed
    LDA buttons_1
    AND #$08
    BEQ READ_DOWN

    LDX #$00
    MOVE_UP:
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
      BNE MOVE_UP

  READ_DOWN:
    ; Check for down button pressed
    LDA buttons_1
    AND #$04
    BEQ READ_DONE

    LDX #$00
    MOVE_DOWN:
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
      BNE MOVE_DOWN

  READ_DONE:
    RTS