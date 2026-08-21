import std/osproc
#  Project 18: Custom Cron/Task Scheduler Daemon
import os, times

proc run_scheduler() {.discardable.} =
  echo "=== Lightweight Cron Daemon ==="
  echo "Current Time: " & $now()
  echo "Executing scheduled minute job..."
  discard execCmd("echo '[Cron Job Triggered at ' `date +%H:%M:%S` '] Task executed.'")

run_scheduler()
