import std/[osproc, os]
#  6. Binary Protocol MessagePack Encoder/Decoder
proc encode_msgpack(val: int): seq[byte] {.discardable.} =
  echo "[Pure MsgPack] Encoding integer " & $val & " to binary header 0x91..."
  return @[0x91'u8, uint8(val)]

var bytes = encode_msgpack(42)
echo "[Pure MsgPack] Encoded byte length: " & $bytes.len
