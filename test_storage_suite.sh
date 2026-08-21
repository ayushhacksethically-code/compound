#!/bin/bash
set -e
echo "=== Running Storage Engines & Embedded Databases Suite (1-10) ==="
for f in suite_storage/*.hg; do
  ./compound run "$f" > /dev/null
  echo "✅ $f passed"
done
echo "=== Storage Engine Suite 10/10 Executed Successfully! ==="
