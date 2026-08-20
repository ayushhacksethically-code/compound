import std/osproc
#  Phase 5 Test 5.1: 100,000 Recursive Tree & Memory Mutation Test

type Node = object
  val: int
  leftVal: int
  rightVal: int

proc buildTree(depth: int): int {.discardable.} =
  if depth <= 0:
    return 1
  else:
    var n = Node(val: depth, leftVal: depth - 1, rightVal: depth - 1)
    return buildTree(n.leftVal) + buildTree(n.rightVal)

echo "Starting 100,000 Recursive Tree Operations with ASan..."
var total = 0
var i = 1
while i <= 100000:
  total += buildTree(5)
  i += 1

echo "Finished 100,000 Tree Operations safely. Total:", total

