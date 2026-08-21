import std/osproc
#  Project 14: Process File-Handle Auditor
proc audit_fd(pid: string) {.discardable.} =
  echo "Auditing open file descriptors for PID: " & pid
  discard execCmd("ls -l /proc/" & pid & "/fd 2>/dev/null | head -n 5 || echo '[FD Audit] PID not found or permission restricted.'")

audit_fd("1")
