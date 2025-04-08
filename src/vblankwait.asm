; Wait for vblank subroutine
VBLANKWAIT:
  BIT PPU_STATUS
  BPL VBLANKWAIT
  RTS
