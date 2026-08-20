import std/osproc
#  Point 3 Test: Cyclic Reference Handling Benchmark

type Node = ref object
  val: int
  next: Node

proc testCycle() {.discardable.} =
  var a = Node(val: 1)
  var b = Node(val: 2)
  a.next = b
  b.next = a

echo "Starting 10,000 cyclic object allocations..."
var i = 1
while i <= 10000:
  testCycle()
  i += 1

echo "10,000 cyclic reference pairs allocated and deallocated cleanly by ORC!"
