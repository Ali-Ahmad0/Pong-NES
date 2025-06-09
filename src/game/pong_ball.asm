MOV_BALL:
  HANDLE_WALL_X:
    LDA $020B
    
    ; Reset ball position if out of bounds
    CMP #LEFT_WALL
    BCC RESET_BALL_POS

    CMP #RIGHT_WALL
    BCS RESET_BALL_POS

    JMP HANDLE_WALL_Y

    RESET_BALL_POS:
      ; Reset X position
      LDA #$7C
      STA $020B

      ; Reset Y position
      LDA #$74
      STA $0208  

  HANDLE_WALL_Y:
    LDA $0208

    ; Invert y velocity for walls
    CMP #TOP_WALL
    BCC INVERT_VEL_Y

    CMP #BOTTOM_WALL
    BCS INVERT_VEL_Y

    JMP HANDLE_PADDLES
    INVERT_VEL_Y:
      LDA ball_vel_y
      EOR #%10000000
      STA ball_vel_y

  HANDLE_PADDLES:
    HANDLE_PADDLE_1:
      ; Check collision with paddle 1
      LDA $020B ; Load ball x position
      CMP #$16  ; Compare with paddle 1 right x position
      BCS HANDLE_PADDLE_2

      CMP #$12  ; Compare with paddle 1 left x position
      BCC HANDLE_PADDLE_2

      LDX $020C ; Paddle 1 first sprite y position
      LDY $0218 ; Paddle 1 final sprite y position

      JMP CHECK_PADDLE_Y

    HANDLE_PADDLE_2:
      LDA $020B ; Load ball x position
      CMP #$E4  ; Compare with paddle 2 left x position
      BCC CHECK_VEL_X

      CMP #$E8  ; Compare with paddle 2 right x position
      BCS CHECK_VEL_X

      LDX $021C ; Paddle 2 first sprite y position
      LDY $0228 ; Paddle 2 final sprite y position

      JMP CHECK_PADDLE_Y

    ; Compare ball y position with paddles
    ; X register stores first paddle sprite y position
    ; Y register stores final paddle sprite y position
    CHECK_PADDLE_Y:
      CHECK_PADDLE_TOP:
        TXA       ; Load paddle first sprite position
        STA temp  ; Store in temporary variable

        LDA $0208 ; Load the ball y position
        CMP temp  ; Compare with paddle top position
        BCS CHECK_PADDLE_BOTTOM

        JMP CHECK_VEL_X

      CHECK_PADDLE_BOTTOM:
        TYA       ; Load paddle last sprite position
        CLC
        ADC #$08  ; Calculate paddle bottom position
        STA temp  ; Store in temporary variable

        LDA $0208 ; Load the ball y position
        CMP temp  ; Compare with paddle 1 bottom position
        BCC INVERT_VEL_X

        JMP CHECK_VEL_X
        
        INVERT_VEL_X:
          LDA ball_vel_x
          EOR #%10000000
          STA ball_vel_x

  CHECK_VEL_X:
    ; Move ball x
    LDA ball_vel_x
    AND #%10000000
    BEQ MOV_NEG_X
    JMP MOV_POS_X

  MOV_POS_X:
    ; Load x position
    LDA $020B
    CLC
    ADC #$01  ; Move right

    JMP END_MOV_X

  MOV_NEG_X:
    ; Load x position
    LDA $020B
    SEC
    SBC #$01  ; Move left

    JMP END_MOV_X

  END_MOV_X:
    ; Save x position
    STA $020B
  
  CHECK_VEL_Y:
    ; Move ball y
    LDA ball_vel_y
    AND #%10000000
    BEQ MOV_NEG_Y
    JMP MOV_POS_Y

  MOV_POS_Y:
    ; Load y position
    LDA $0208
    CLC
    ADC #$01  ; Move down
    
    JMP END_MOV_Y
  MOV_NEG_Y:
    ; Load y position
    LDA $0208
    SEC
    SBC #$01  ; Move up

    JMP END_MOV_Y

  END_MOV_Y:
    ; Save y position
    STA $0208
  
  RTS