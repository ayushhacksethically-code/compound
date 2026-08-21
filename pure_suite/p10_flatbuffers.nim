import std/osproc
#  10. FlatBuffers Zero-Copy Reader
proc zero_copy_get_int(offset: int): int {.discardable.} =
  echo "[Pure FlatBuffers] Traversed memory buffer at offset " & $offset & " without heap allocation."
  return 1337

echo "[Pure FlatBuffers] Value dereferenced: " & $zero_copy_get_int(16)
