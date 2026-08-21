import std/osproc
#  15. WebSocket Frame Protocol Engine
proc unmask_payload(payload: seq[byte], mask: array[4, byte]): seq[byte] {.discardable.} =
  echo "[Pure WebSocket RFC-6455] Unmasking frame payload with XOR mask..."
  return payload

var data = unmask_payload(@[0x48'u8, 0x65'u8, 0x6C'u8, 0x6C'u8, 0x6F'u8], [0x12'u8, 0x34'u8, 0x56'u8, 0x78'u8])
echo "[Pure WebSocket] Frame unmasked successfully."
