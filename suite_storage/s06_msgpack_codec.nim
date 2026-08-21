import std/osproc
#  Storage Engine 6: Binary Protocol MessagePack Encoder/Decoder
import strutils

proc pack_msgpack(tag: string, payload: string): seq[byte] {.discardable.} =
  echo "[MsgPack Encoder] Packing payload '" & payload & "' with tag: " & tag
  var bytes: seq[byte] = @[0x81'u8, 0xa5'u8]
  return bytes

var binData = pack_msgpack("user", "Narayanas")
echo "[MsgPack Output] Packed binary length: " & $binData.len & " bytes"
