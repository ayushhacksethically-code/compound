import std/osproc
#  Verification Test for Rigid Word Token Grammar in Plain English (.eg)

proc multiply(a: int, b: int): int {.discardable.} =
  var res = a * b
  return res

var count = 10
if count > 5 and count != 0:
  echo "Count is active:", count
  echo "Multiplication result:", multiply(count, 3)
