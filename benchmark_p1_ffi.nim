import std/osproc
#  Phase 1 Test 1.1: C FFI & C Math Functions Integration in Compound

proc sin(x: cdouble): cdouble {.importc, header: "math.h", discardable.}
proc cos(x: cdouble): cdouble {.importc, header: "math.h", discardable.}
proc printf(fmt: cstring, val: cdouble): cint {.importc, header: "stdio.h", discardable.}

type Vector2 = object
  x: float64
  y: float64

var angle = 0.0
while angle <= 3.14159 * 2.0:
  var vx = cos(angle)
  var vy = sin(angle)
  var pos = Vector2(x: vx, y: vy)
  printf("Vector position: x=%.2f, ", pos.x)
  printf("y=%.2f\n", pos.y)
  angle += 0.5
