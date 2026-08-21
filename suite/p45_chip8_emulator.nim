import std/osproc
#  Project 45: Chip-8 Retro Hardware Emulator
proc emulate_opcode(opcode: uint16) {.discardable.} =
  echo "Emulating Chip-8 CPU Opcode: 0x" & $opcode

emulate_opcode(0x00E0'u16)
emulate_opcode(0x1200'u16)
