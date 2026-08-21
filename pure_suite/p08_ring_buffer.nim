import std/osproc
#  8. Circular Ring-Buffer Logger
var buffer: array[4, int]
var head = 0

proc log_event(event_id: int) {.discardable.} =
  buffer[head mod 4] = event_id
  echo "[Pure RingBuffer] Logged Event ID #" & $event_id & " at slot " & $(head mod 4)
  head += 1

log_event(101)
log_event(102)
log_event(103)
log_event(104)
log_event(105)
