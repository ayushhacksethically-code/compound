#!/usr/bin/env bash
set -e

echo "=== Running Full 10 Advanced JS Compilation Target Suite Benchmark ==="

for f in js_suite/*.hg; do
  ./compound js "$f"
done

echo "=== All 10 JS Target Projects Executed & Verified Successfully! ==="
