import std/osproc
#  Project 8: Multi-Server SSH Command Dispatcher
import os

proc dispatch_execCmdEx(node_ip: string, cmd: string) {.discardable.} =
  echo "Dispatching diagnostic task to node " & node_ip
  discard execCmd("echo '[Node " & node_ip & "] Running: " & cmd & "'")

dispatch_execCmdEx("192.168.1.10", "uptime")
dispatch_execCmdEx("192.168.1.11", "df -h")
