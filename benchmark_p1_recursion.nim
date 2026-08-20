import std/osproc
#  Phase 1 Test 1.2: Deep Recursion & Dynamic Array Growth Benchmark

proc fibonacci(n: int): int {.discardable.} =
  if n <= 1:
    return n
  else:
    return fibonacci(n - 1) + fibonacci(n - 2)

echo "Fibonacci(25) recursive test:", fibonacci(25)

var numbers = newSeq[int]()
var i = 1
while i <= 1000000:
  numbers.add(i)
  i += 1

echo "Dynamic Array million elements length:", numbers.len
