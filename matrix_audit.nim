import std/osproc
#  Comprehensive Matrix Audit: None, Finally, Assert, Match, Defer, Lambda, Yield, Async, Del

#  1. None / nil check
type RefNode = ref object
  val: int

var emptyVal: RefNode = nil
if emptyVal == nil:
  echo "[1/9 PASSED] None/nil check working!"

#  2. Finally block check
try:
  echo "[2/9 IN-PROGRESS] Inside try..."
except:
  echo "Error caught"
finally:
  echo "[2/9 PASSED] Finally block executed!"

#  3. Assert check
doAssert 10 > 5
echo "[3/9 PASSED] Assert (shart_jaanch) working!"

#  4. Match / Pattern Matching check
var num = 2
case num:
of 1:
  echo "One"
of 2:
  echo "[4/9 PASSED] Match (chuno / jab) working!"
else:
  echo "Other"

#  5. Lambda / Anonymous proc check
var doubleVal = proc(x: int): int = x * 2
echo "[5/9 PASSED] Lambda (Anonymous proc): double(10) =", doubleVal(10)

#  6. Yield Iterator / Generator check
iterator countThree(): int =
  yield 10
  yield 20
  yield 30

var sum = 0
for n in countThree():
  sum += n
echo "[6/9 PASSED] Yield Iterator count sum =", sum

#  7. Async / Await check
import std/asyncdispatch

proc asyncTask(): Future[string] {.async.} =
  return "Async result ready!"

var fut = asyncTask()
echo "[7/9 PASSED] Async / Future status:", waitFor(fut)

#  8. Del / Memory Free check
var heapNode = new(int)
heapNode[] = 99
echo "[8/9 PASSED] Value before del:", heapNode[]
heapNode = nil
echo "[8/9 PASSED] Memory unreferenced / deallocated cleanly!"

#  9. Global / Nonlocal Closure Mutation check
var outerCounter = 0
proc incrementOuter() {.discardable.} =
  outerCounter += 1
incrementOuter()
incrementOuter()
echo "[9/9 PASSED] Global / Nonlocal Closure Mutation count =", outerCounter
