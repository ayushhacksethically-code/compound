#!/bin/bash
set -e
echo "=== Running Full 10 Interactive Projects Suite Test ==="
for f in interactive_suite/*.hg; do
  ./compound run "$f" > /dev/null
  echo "✅ $f passed"
done
echo "=== All 10 Interactive Projects Executed Successfully! ==="
