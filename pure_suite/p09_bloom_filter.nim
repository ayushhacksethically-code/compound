import std/[osproc, os]
#  9. Bloom Filter with Murmur3 Hash
import hashes

var filter: array[64, bool]

proc bloom_insert(val: string) {.discardable.} =
  var idx = abs(hash(val)) mod 64
  filter[idx] = true
  echo "[Pure Bloom Filter] Item '" & val & "' mapped to bit: " & $idx

bloom_insert("user_session_99")
echo "[Pure Bloom Filter] Membership Bit Checked."
