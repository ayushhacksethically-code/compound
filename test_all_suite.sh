#!/bin/bash
set -e
echo "=== Running Full 50 Projects Suite Test ==="
for f in suite/*.hg; do
  ./compound run "$f" > /dev/null
  echo "✅ $f passed"
done
echo "=== All 50 Projects Executed Successfully! ==="
