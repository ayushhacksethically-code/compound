import std/osproc
#  Storage Engine 9: Bloom Filter with Murmur3 Hash
import hashes

var bitArray: array[64, bool]

proc bloom_add(item: string) {.discardable.} =
  var h = abs(hash(item)) mod 64
  bitArray[h] = true
  echo "[Bloom Filter] Adding '" & item & "' -> Bit index: " & $h

proc bloom_contains(item: string): bool {.discardable.} =
  var h = abs(hash(item)) mod 64
  return bitArray[h]

bloom_add("user@example.com")
echo "[Bloom Check] 'user@example.com' exists: " & $bloom_contains("user@example.com")
