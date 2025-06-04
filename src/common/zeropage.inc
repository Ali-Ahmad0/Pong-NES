.segment "ZEROPAGE"
    ; (Not being used yet)
    game_state: .res 1

    ; Gamepad buttons
    buttons_1: .res 1
    buttons_2: .res 1

    ; Ball position
    ball_pos_x: .res 1
    ball_pos_y: .res 1

    ; Ball velocity
    ; Sign bit represents direction
    ball_vel_x: .res 1
    ball_vel_y: .res 1

    ; Paddle X and Y positions
    paddle_1_pos_x: .res 1
    paddle_2_pos_x: .res 1

    paddle_1_pos_y_top: .res 1
    paddle_1_pos_y_bottom: .res 1
    
    paddle_2_pos_y_top: .res 1
    paddle_2_pos_y_bottom: .res 1
