import std/osproc
#  Project 40: Multi-Dialect Translation Tool
import strutils

proc hg_to_eg(code: string): string {.discardable.} =
  return code.replace("rakho ", "keep ").replace("dikhao ", "show ").replace("agar ", "if ").replace(" toh", "")

echo hg_to_eg("rakho x = 5")
echo hg_to_eg("dikhao x")
