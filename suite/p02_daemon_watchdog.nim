import std/osproc
#  Project 2: Linux Daemon Watchdog
proc check_service(service_name: string) {.discardable.} =
  echo "Checking status of daemon: " & service_name
  discard execCmd("systemctl is-active " & service_name & " > /dev/null 2>&1 || echo '[Watchdog] Service inactive, restarting...'")

check_service("ssh")
check_service("cron")
echo "Daemon Watchdog Run Completed."
