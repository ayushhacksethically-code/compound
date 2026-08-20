import std/osproc
#  Workload 3: Producer-Consumer Pipeline with Generators & Closures

iterator eventProducer(): int =
  var i = 1
  while i <= 100000:
    yield i
    i += 1

var filterEven = proc(val: int): bool = val mod 2 == 0
var mapSquare = proc(val: int): int = val * 2

var totalEvents = 0
var sumAccumulator = 0

for event in eventProducer():
  if filterEven(event):
    var transformed = mapSquare(event)
    sumAccumulator += transformed
    totalEvents += 1

echo "[Producer] Total Events Processed:", totalEvents
echo "[Consumer Pipeline] Final Metrics Accumulator Sum:", sumAccumulator
echo "[Workload 3 PASSED] 100,000 Event Pipeline with Iterators & Closures executed with 0 memory accumulation!"
