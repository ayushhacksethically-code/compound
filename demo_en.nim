when not defined(js):
  import std/[osproc, os]
#  Compound Language Demo (Plain English - .eg)
var name = "Narayana"
echo "Hello " & name & "! Welcome to Compound Language."

var a = 10
var b = 20

if a < b:
  echo "a is smaller than b"

proc add_numbers(x: int, y: int): int {.discardable.} =
  return x + y

echo "10 + 20 = " & $add_numbers(a, b)
