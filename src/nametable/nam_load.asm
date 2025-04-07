LOAD_NAM:  ; Writing nametable address to PPU
  LDA PPU_STATUS 
  LDA #$20
  STA PPU_ADDR
  LDA #$00
  STA PPU_ADDR

  ; Saving the nametable inside RAM
  LDA #<NAMETABLE ; lo-byte of nametable 
  STA $0000
  LDA #>NAMETABLE ; hi-byte of nametable
  STA $0001

  ; Reset registers
  LDA #$00
  LDX #$00
  LDY #$00

  ; Load background data
  LOAD_NAM_LOOP:
    LDA ($00), y    ; Load nametable data
    STA PPU_DATA    ; Store data in PPU
    INY
    CPY #$00        ; Check for Y overflow
    BNE LOAD_NAM_LOOP   
    INC $0001       ; Increment the hi-byte
    INX             
    CPX #$04        ; 1024 byte nametable
    BNE LOAD_NAM_LOOP
  
  RTS