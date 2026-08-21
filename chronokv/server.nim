import std/osproc
#  ChronoKV Module 3: Network Server & Protocol Handler
import strutils, tables

var kvStore = initTable[string, string]()

proc handle_execCmdEx(req: string): string {.discardable.} =
  var parts = req.strip().split(" ")
  if parts.len == 0:
    return "ERR empty"

  var cmd = parts[0].toUpperAscii()
  if cmd == "PING":
    return "PONG"
  elif cmd == "SET" and parts.len >= 3:
    kvStore[parts[1]] = parts[2]
    return "OK"
  elif cmd == "GET" and parts.len >= 2:
    if kvStore.hasKey(parts[1]):
      return kvStore[parts[1]]
    else:
      return "(nil)"
  elif cmd == "DEL" and parts.len >= 2:
    kvStore.del(parts[1])
    return "OK"
  else:
    return "ERR unknown_cmd"

#  Server Self Test
echo "[ChronoKV Server] Handling PING -> " & handle_execCmdEx("PING")
echo "[ChronoKV Server] Handling SET user:101 Narayana -> " & handle_execCmdEx("SET user:101 Narayana")
echo "[ChronoKV Server] Handling GET user:101 -> " & handle_execCmdEx("GET user:101")
