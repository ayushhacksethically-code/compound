import std/osproc
#  Point 5 Test: CLI Argument Reading Benchmark

import std/cmdline

var args = commandLineParams()
echo "CLI Arguments Count:", args.len
for arg in args:
  echo "Argument:", arg
