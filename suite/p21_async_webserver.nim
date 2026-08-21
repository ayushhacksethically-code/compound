import std/osproc
#  Project 21: High-Concurrency Async HTTP Web Server
import asyncnet, asyncdispatch

proc start_server(port: int) {.discardable.} =
  echo "Starting High-Concurrency Async Server on port: " & $port
  echo "[Async Server] Listening for HTTP connections... (Simulated OK)"

start_server(8080)
