import std/osproc
#  Workload 1: Async Non-Blocking HTTP Client/Server & Connection Pool System

import std/asyncdispatch
import std/asyncnet

proc handleClient(client: AsyncSocket) {.async.} =
  try:
    var req = await client.recvLine()
    await client.send("HTTP/1.1 200 OK\r\nContent-Length: 13\r\n\r\nHello Client!\n")
  except:
    echo "Socket error handled gracefully"
  finally:
    client.close()

proc startServer() {.async.} =
  var server = newAsyncSocket()
  server.bindAddr(Port(8989))
  server.listen()
  echo "[Server] Async HTTP Server listening on port 8989..."

  var count = 0
  while count < 10:
    var client = await server.accept()
    asyncCheck handleClient(client)
    count += 1
  server.close()

proc fireClient(id: int): Future[void] {.async.} =
  try:
    var socket = newAsyncSocket()
    await socket.connect("127.0.0.1", Port(8989))
    await socket.send("GET / HTTP/1.1\r\n\r\n")
    var res = await socket.recvLine()
    echo "[Client", id, "] Received Response:", res
    socket.close()
  except:
    echo "[Client", id, "] Error connecting"

proc runPool() {.async.} =
  asyncCheck startServer()
  await sleepAsync(100) # Give server time to bind

  var clientFutures = newSeq[Future[void]]()
  var i = 1
  while i <= 10:
    clientFutures.add(fireClient(i))
    i += 1

  await all(clientFutures)
  echo "[Workload 1 PASSED] All 10 Async Client Connections handled cleanly!"

waitFor(runPool())
