import std/osproc
#  7. Custom Columnar File Store
import strutils

proc aggregate_column(col_data: seq[float]): float {.discardable.} =
  var sum = 0.0
  for v in col_data:
    sum += v
  return sum

var priceColumn = @[19.99, 49.50, 10.00]
echo "[Pure Columnar Store] Vectorized Sum of Price Column: " & $aggregate_column(priceColumn)
