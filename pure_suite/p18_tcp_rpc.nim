import std/osproc
#  18. Custom RPC Engine over TCP
proc invoke_rpc_method(method_id: uint16, payload: string) {.discardable.} =
  echo "[Pure TCP RPC] Executing Method ID: " & $method_id & " with payload: " & payload
  echo "[Pure TCP RPC] Return Status: SUCCESS (200)"

invoke_rpc_method(0x0101'u16, "compute_hash")
