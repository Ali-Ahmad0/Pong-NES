MOV_PADDLE_2:
  READ_UP_2:
    ; Check for up button pressed
    LDA buttons_2
    AND #$08
    BEQ READ_DOWN_2

    ; Check if cannot move up
    LDA $021C
    CMP #TOP_WALL
    BCC READ_DOWN_2

    LDX #$00
    MOV_UP_2:
      LDA $021C, x  ; Load paddle y position
      SEC           ; Set carry
      SBC #$02      ; y = y - 2

      STA $021C, x  ; Save paddle y position

      ; Counter + 4
      INX
      INX
      INX
      INX

      CPX #$10
      BNE MOV_UP_2

  READ_DOWN_2:
    ; Check for down button pressed
    LDA buttons_2
    AND #$04
    BEQ READ_DONE_2

    ; Check if cannot move down
    LDA $0228
    CMP #BOTTOM_WALL
    BCS READ_DONE_2

    LDX #$00
    MOV_DOWN_2:
      LDA $021C, x  ; Load paddle y position
      CLC           ; Clear carry
      ADC #$02      ; y = y + 2

      STA $021C, x  ; Save paddle y position

      ; Counter + 4
      INX
      INX
      INX
      INX

      CPX #$10
      BNE MOV_DOWN_2

  READ_DONE_2:
    RTS