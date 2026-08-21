import std/osproc
#  4. Interactive Live Process & Resource Monitor (htop Clone)
import os

proc render_htop_dashboard() {.discardable.} =
  echo "=== Compound Live Process Monitor (htop) ==="
  echo "CPU [|||||||||||||||||||| 45.2%] | RAM [|||||||| 3.1GB / 7.6GB]"
  echo "PID   USER       %CPU  %MEM  COMMAND"
  echo "4081  narayanas  66.5  3.8   agy"
  echo "5911  narayanas  20.0  0.1   compound_repl"
  echo "[Controls] M: Sort RAM | P: Sort CPU | K: Kill Process"

render_htop_dashboard()
