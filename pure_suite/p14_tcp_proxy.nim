import std/[osproc, os]
#  14. Raw TCP Reverse Proxy & Load Balancer
import strutils

var backends = @["10.0.0.1:8080", "10.0.0.2:8080"]
var rrIndex = 0

proc get_next_backend(): string {.discardable.} =
  var b = backends[rrIndex mod backends.len]
  rrIndex += 1
  return b

echo "[Pure TCP LoadBalancer] Proxied Connection 1 -> Backend: " & get_next_backend()
echo "[Pure TCP LoadBalancer] Proxied Connection 2 -> Backend: " & get_next_backend()
