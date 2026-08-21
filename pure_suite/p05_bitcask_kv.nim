import std/[osproc, os]
#  5. Bitcask-Style Key-Value Store
import tables

var index = initTable[string, int64]()

proc bitcask_append(k: string, v: string, offset: int64) {.discardable.} =
  index[k] = offset
  echo "[Pure Bitcask] Appended " & k & " at byte offset: " & $offset

bitcask_append("key_alpha", "val_1", 2048'i64)
echo "[Pure Bitcask Lookup] Key 'key_alpha' -> Offset: " & $index["key_alpha"]
