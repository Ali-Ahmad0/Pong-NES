.segment "ZEROPAGE"
    game_state: .res 1

    ; Ball position
    ball_pos_x: .res 1
    ball_pos_y: .res 1

    ; Ball velocity
    ; Sign bit represents direction
    ball_vel_x: .res 1
    ball_vel_y: .res 1

    