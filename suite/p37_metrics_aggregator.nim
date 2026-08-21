import std/osproc
#  Project 37: Time-Series Metric Aggregator
import stats, math

var samples: seq[float] = @[10.5, 20.0, 15.2, 45.1, 12.8, 30.4]
var total = 0.0
for s in samples:
  total += s
var avg = total / float(samples.len)

echo "Metric Samples Count: " & $samples.len
echo "Calculated Average Load: " & $avg
