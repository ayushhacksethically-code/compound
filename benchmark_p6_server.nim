import std/osproc
#  Phase 6 Test 6.1: High-Concurrency Socket Server & Concurrency Benchmark

import std/net

proc printf(fmt: cstring, val: int): cint {.importc, header: "stdio.h", discardable.}

var server = newSocket()
server.bindAddr(Port(8888))
server.listen()

printf("Server listening on port %d...\n", 8888)

var clientCount = 0
while clientCount < 3:
  var client = newSocket()
  server.accept(client)
  client.send("HTTP/1.1 200 OK\r\nContent-Length: 13\r\n\r\nHello World!\n")
  client.close()
  clientCount += 1

server.close()
printf("Successfully handled %d requests cleanly.\n", clientCount)
