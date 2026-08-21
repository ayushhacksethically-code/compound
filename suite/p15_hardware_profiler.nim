import std/osproc
#  Project 15: System Hardware Profiler
proc profile_hardware() {.discardable.} =
  echo "=== System Hardware Profile ==="
  discard execCmd("lscpu | grep 'Model name\\|CPU(s):'")
  discard execCmd("free -h | grep 'Mem:'")

profile_hardware()
