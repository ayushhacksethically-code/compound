import std/osproc
#  Project 39: Bytecode Virtual Machine
import strutils

var stack: seq[int] = @[]

proc vm_push(val: int) {.discardable.} =
  stack.add(val)

proc vm_add() {.discardable.} =
  var b = stack.pop()
  var a = stack.pop()
  stack.add(a + b)

vm_push(10)
vm_push(32)
vm_add()
echo "VM Stack Top Result: " & $stack[0]
