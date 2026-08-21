import std/osproc
#  Project 38: Regular Expression / Pattern Matching Engine
import strutils

proc simple_match(text: string, pattern: string) {.discardable.} =
  if pattern in text:
    echo "Pattern '" & pattern & "' MATCHED in text."
  else:
    echo "Pattern NOT matched."

simple_match("Contact admin@example.com for details", "admin@example.com")
