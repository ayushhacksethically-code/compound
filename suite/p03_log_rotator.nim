import std/osproc
#  Project 3: Log Stream Rotator & Archiver
import os

proc rotate_log(log_path: string) {.discardable.} =
  if fileExists(log_path):
    echo "Rotating log file: " & log_path
    discard execCmd("cp " & log_path & " " & log_path & ".1 && > " & log_path)
    discard execCmd("gzip -f " & log_path & ".1")
    echo "Log rotated and compressed successfully."
  else:
    echo "Log file not found: " & log_path

discard execCmd("touch /tmp/test_app.log && echo 'sample log entry' > /tmp/test_app.log")
rotate_log("/tmp/test_app.log")
