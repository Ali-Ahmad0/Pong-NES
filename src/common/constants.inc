; PPU Registers
  PPU_CTRL    =   $2000
  PPU_MASK    =   $2001
  PPU_STATUS  =   $2002
  OAM_ADDR    =   $2003
  OAM_DATA    =   $2004
  PPU_SCROLL  =   $2005
  PPU_ADDR    =   $2006
  PPU_DATA    =   $2007
  OAM_DMA     =   $4014

; APU Registers
  SQ1_VOL     =   $4000
  SQ1_LO      =   $4002
  SQ1_HI      =   $4003
  APU_STATUS  =   $4015

; Controller Input
  JOY_1       =   $4016
  JOY_2       =   $4017

; Game states
  MAIN_MENU   =   $00
  RUNNING     =   $01
  EXIT_GAME   =   $02

; Walls
  RIGHT_WALL  =   $F2
  TOP_WALL    =   $04
  BOTTOM_WALL =   $E4
  LEFT_WALL   =   $0A