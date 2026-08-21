when not defined(js):
  import std/[osproc, os]
#  Compound Language Demo (Hinglish - .hg)
var naam = "Narayana"
echo "Namaste " & naam & "! Welcome to Compound Language."

var a = 10
var b = 20

if a < b:
  echo "a (" & $a & ") b se chhota hai."

proc jodo(x: int, y: int): int {.discardable.} =
  return x + y

echo "10 + 20 = " & $jodo(a, b)
