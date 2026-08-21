import std/osproc
#  Project 11: Live CLI Task Manager (htop clone)
import os

proc print_system_stats() {.discardable.} =
  echo "=== Live System Task Manager ==="
  discard execCmd("uptime")
  discard execCmd("free -h")
  discard execCmd("ps aux --sort=-%cpu | head -n 5")

print_system_stats()
