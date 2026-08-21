import std/osproc
#  Project 29: Bandwidth & Network Interface Monitor
proc monitor_interface(iface: string) {.discardable.} =
  echo "Reading bandwidth stats for interface: " & iface
  discard execCmd("grep " & iface & " /proc/net/dev | awk '{print \"[Net] RX Bytes:\", $2, \"| TX Bytes:\", $10}' || echo '[Net Monitor] Interface inactive'")

monitor_interface("eth0")
monitor_interface("wlan0")
monitor_interface("lo")
