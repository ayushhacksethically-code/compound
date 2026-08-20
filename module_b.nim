import std/osproc
#  Module B file for Compound

proc helperFunc*(x: int): int {.discardable.} =
  return x * 10
