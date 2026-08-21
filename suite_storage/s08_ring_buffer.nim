import std/osproc
#  Storage Engine 8: Circular Ring-Buffer Logger
var ringBuffer: array[4, string]
var head = 0

proc ring_log(msg: string) {.discardable.} =
  ringBuffer[head mod 4] = msg
  echo "[RingBuffer Slot #" & $(head mod 4) & "] Logged: " & msg
  head += 1

ring_log("Metric 1")
ring_log("Metric 2")
ring_log("Metric 3")
ring_log("Metric 4")
ring_log("Metric 5 (Evicts Metric 1)")
