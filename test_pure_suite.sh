#!/bin/bash
set -e
echo "=== Running Full 50 Pure Language & Systems Projects Suite Test ==="
for f in pure_suite/*.hg; do
  ./compound run "$f" > /dev/null
  echo "✅ $f passed"
done
echo "=== All 50 Pure Systems Projects Executed Successfully! ==="
