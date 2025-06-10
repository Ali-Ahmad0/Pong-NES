.segment "ZEROPAGE"
    
    ; (Not being used yet)
    game_state: .res 1

    ; Temporary variable
    temp: .res 1

    ; Ball start delay
    delay_timer: .res 1
    
    ; Gamepad buttons
    buttons_1: .res 1
    buttons_2: .res 1

    ; Ball velocity
    ; Sign bit represents direction
    ball_vel_x: .res 1

    ball_vel_y: .res 1

    ; Index for initial velocity
    ball_vel_index: .res 1