import std/osproc
#  20. TFTP Server
proc handle_tftp_rrq(filename: string, mode: string) {.discardable.} =
  echo "[Pure TFTP Server] Read Request for: " & filename
handle_tftp_rrq("firmware.bin", "octet")
