import std/osproc
#  Project 17: Serial Port Terminal Reader
proc read_serial(device: string) {.discardable.} =
  echo "Reading telemetry stream from serial port: " & device
  discard execCmd("echo '[Serial Telemetry] Baud: 9600 | Data: OK' || echo '[Serial] Device simulation'")

read_serial("/dev/ttyUSB0")
