import std/osproc
#  Project 23: Fast Port Scanner (nmap clone)
proc scan_port(host: string, port: int) {.discardable.} =
  discard execCmd("nc -z -w 1 " & host & " " & $port & " 2>/dev/null && echo '[Scanner] Port " & $port & " OPEN' || echo '[Scanner] Port " & $port & " CLOSED'")

echo "Scanning target: 127.0.0.1"
scan_port("127.0.0.1", 22)
scan_port("127.0.0.1", 80)
