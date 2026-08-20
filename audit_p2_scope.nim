import std/osproc
#  Point 2 Test: Block Scoping & Outer Scope Preservation Benchmark

var x = 100
echo "Outer x before block:", x

if true:
  var x = 500
  echo "Inner x inside block:", x

echo "Outer x after block (must remain 100):", x
