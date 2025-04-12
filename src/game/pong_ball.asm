MOV_BALL:
  HANDLE_WALL_X:
    LDA ball_pos_x
    
    CMP #LEFT_WALL
    BCC INVERT_VEL_X

    CMP #RIGHT_WALL
    BCS INVERT_VEL_X

    JMP HANDLE_WALL_Y

    INVERT_VEL_X:
      LDA ball_vel_x
      EOR #%10000000
      STA ball_vel_x

  HANDLE_WALL_Y:
    LDA ball_pos_y

    CMP #TOP_WALL
    BCC INVERT_VEL_Y

    CMP #BOTTOM_WALL
    BCS INVERT_VEL_Y

    JMP CHECK_VEL_X
    INVERT_VEL_Y:
      LDA ball_vel_y
      EOR #%10000000
      STA ball_vel_y

  CHECK_VEL_X:
    ; Move ball x
    LDA ball_vel_x
    AND #%10000000
    BEQ MOV_NEG_X
    JMP MOV_POS_X

  MOV_POS_X:
    ; Load X position
    LDA $020B
    CLC
    ADC #$01  ; Move right

    JMP END_MOV_X

  MOV_NEG_X:
    ; Load X position
    LDA $020B
    SEC
    SBC #$01  ; Move left

    JMP END_MOV_X

  END_MOV_X:
    ; Save X position
    STA $020B
    STA ball_pos_x
  
  CHECK_VEL_Y:
    ; Move ball y
    LDA ball_vel_y
    AND #%10000000
    BEQ MOV_NEG_Y
    JMP MOV_POS_Y

  MOV_POS_Y:
    ; Load X position
    LDA $0208
    CLC
    ADC #$01  ; Move right

    
    JMP END_MOV_Y
  MOV_NEG_Y:
    ; Load X position
    LDA $0208
    SEC
    SBC #$01  ; Move left

    ; Save X position
    STA $0208
    JMP END_MOV_Y

  END_MOV_Y:
    ; Save Y position
    STA $0208
    STA ball_pos_y
  
  RTS