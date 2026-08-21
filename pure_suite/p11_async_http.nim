import std/osproc
#  11. Async HTTP/1.1 Web Server
import strutils

proc parse_http_request(req_line: string) {.discardable.} =
  var parts = req_line.split(" ")
  echo "[Pure HTTP/1.1] Method: " & parts[0] & " | Path: " & parts[1] & " | Version: " & parts[2]

parse_http_request("GET /api/v1/status HTTP/1.1")
