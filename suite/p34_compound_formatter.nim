import std/osproc
#  Project 34: Self-Hosted Compound Formatter (hg fmt)
import strutils

proc format_line(line: string): string {.discardable.} =
  return line.strip().replace("  ", " ")

echo format_line("   rakho    a    =    10   ")
