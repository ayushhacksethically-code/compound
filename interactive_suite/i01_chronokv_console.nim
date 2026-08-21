import std/osproc
#  1. Interactive ChronoKV REPL & Query Console
import tables, strutils

var kvData = initTable[string, string]()

proc eval_cmd(input_line: string): string {.discardable.} =
  var parts = input_line.strip().split(" ")
  if parts.len == 0 or input_line.strip().len == 0:
    return ""
  var cmd = parts[0].toUpperAscii()
  if cmd == "SET" and parts.len >= 3:
    kvData[parts[1]] = parts[2]
    return "[OK] Inserted 1 key."
  elif cmd == "GET" and parts.len >= 2:
    if kvData.hasKey(parts[1]):
      return kvData[parts[1]]
    else:
      return "(nil)"
  elif cmd == "DEL" and parts.len >= 2:
    kvData.del(parts[1])
    return "[OK] Deleted 1 key."
  elif cmd == "STATS":
    return "[STATS] Total keys in RAM: " & $kvData.len
  else:
    return "ERR unknown_command"

echo "=== ChronoKV Interactive Query Console (REPL) ==="
echo "chronokv> SET user:100 Narayana -> " & eval_cmd("SET user:100 Narayana")
echo "chronokv> GET user:100 -> " & eval_cmd("GET user:100")
echo "chronokv> STATS -> " & eval_cmd("STATS")
