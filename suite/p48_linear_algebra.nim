import std/osproc
#  Project 48: Linear Algebra & Matrix Operations Library
proc dot_product(v1: seq[float], v2: seq[float]): float {.discardable.} =
  var sum = 0.0
  for i in 0 ..< v1.len:
    sum += v1[i] * v2[i]
  return sum

echo "Vector Dot Product ( [1, 2, 3] . [4, 5, 6] ): " & $dot_product(@[1.0, 2.0, 3.0], @[4.0, 5.0, 6.0])
