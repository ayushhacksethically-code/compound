import std/[osproc, os]
#  17. Async Redis Client Protocol (RESP) Parser
import strutils

proc parse_resp(line: string) {.discardable.} =
  if line.startsWith("+"):
    echo "[Pure RESP Parser] Simple String: " & line.substr(1)
  elif line.startsWith(":"):
    echo "[Pure RESP Parser] Integer: " & line.substr(1)

parse_resp("+PONG")
parse_resp(":1000")
