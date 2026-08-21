when not defined(js):
  import std/[osproc, os]
#  Python tutorial Fibonacci example in Compound English

var a = 0
var b = 1

while a < 1000:
  echo a
  var next_val = a + b
  a = b
  b = next_val
