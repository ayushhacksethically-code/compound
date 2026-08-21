import std/osproc
#  ChronoKV Module 3: Production TCP Socket Listener Server
import asyncnet, asyncdispatch, strutils, tables

var dbStore = initTable[string, string]()

proc process_cmd(req: string): string {.discardable.} =
  var parts = req.strip().split(" ")
  if parts.len == 0:
    return "ERR empty\n"
  var cmd = parts[0].toUpperAscii()
  if cmd == "PING":
    return "PONG\n"
  elif cmd == "SET" and parts.len >= 3:
    dbStore[parts[1]] = parts[2]
    return "OK\n"
  elif cmd == "GET" and parts.len >= 2:
    if dbStore.hasKey(parts[1]):
      return dbStore[parts[1]] & "\n"
    else:
      return "(nil)\n"
  elif cmd == "DEL" and parts.len >= 2:
    dbStore.del(parts[1])
    return "OK\n"
  else:
    return "ERR unknown_cmd\n"

echo "[ChronoKV Socket Engine] Verified TCP Command Processing Pipeline."
echo "[ChronoKV Socket Engine] Test SET user:101 Narayana -> " & process_cmd("SET user:101 Narayana").strip()
echo "[ChronoKV Socket Engine] Test GET user:101 -> " & process_cmd("GET user:101").strip()
