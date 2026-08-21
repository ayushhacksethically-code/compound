import std/osproc
#  Project 22: Reverse Proxy & Layer 4 TCP Load Balancer
proc forward_traffic(client_id: int, backend_port: int) {.discardable.} =
  echo "Proxying TCP connection from Client #" & $client_id & " -> Upstream Port :" & $backend_port

forward_traffic(101, 9001)
forward_traffic(102, 9002)
