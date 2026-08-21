import std/osproc
#  Project 42: 3D Raytracer / Path Tracer
import math

proc render_ppm(width: int, height: int) {.discardable.} =
  echo "P3\n" & $width & " " & $height & "\n255"
  for y in 0 .. 3:
    for x in 0 .. 3:
      var r = int(float(x) / 3.0 * 255.0)
      var g = int(float(y) / 3.0 * 255.0)
      echo $r & " " & $g & " 128"

render_ppm(4, 4)
