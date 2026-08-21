import std/osproc
#  Project 44: N-Body Gravitational Physics Simulator
import math

proc simulate_step(p1_x: float, p1_y: float, p2_x: float, p2_y: float) {.discardable.} =
  var dx = p2_x - p1_x
  var dy = p2_y - p1_y
  var dist = sqrt(dx*dx + dy*dy)
  echo "Inter-particle Gravitational Distance: " & $dist

simulate_step(0.0, 0.0, 3.0, 4.0)
