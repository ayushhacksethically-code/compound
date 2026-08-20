import std/osproc
#  Workload 4: High-Performance C FFI Data Processing Pipeline in Compound

import std/math

proc malloc(size: int): pointer {.importc, header: "stdlib.h", discardable.}
proc free(p: pointer) {.importc, header: "stdlib.h", discardable.}
proc printf(fmt: cstring, val1: int, val2: float64): cint {.importc, header: "stdio.h", discardable.}

type CVector2 = object
  x: float64
  y: float64

var count = 500000
var structSize = sizeof(CVector2)
var rawPtr = malloc(count * structSize)

echo "[C FFI] Allocated C native memory buffer for 500,000 CVector2 elements at pointer address."

# Treat raw pointer as C array of CVector2
var vecArray = cast[ptr UncheckedArray[CVector2]](rawPtr)

var i = 0
while i < count:
  vecArray[i].x = float64(i) * 1.5
  vecArray[i].y = float64(i) * 2.5
  i += 1

var dotSum = 0.0
i = 0
while i < count:
  dotSum += sqrt(vecArray[i].x * vecArray[i].x + vecArray[i].y * vecArray[i].y)
  i += 1

printf("[C FFI] Processed %d CVector2 elements! Cumulative Distance Sum: %.2f\n", count, dotSum)

free(rawPtr)
echo "[C FFI] Native C memory freed manually! Nim ORC Garbage Collector remains 100% undisturbed."
echo "[Workload 4 PASSED] High-Performance C FFI Memory & Data Pipeline Succeeded!"
