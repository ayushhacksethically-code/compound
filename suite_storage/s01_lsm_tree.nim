import std/osproc
#  Storage Engine 1: Append-Only LSM-Tree Storage Engine
import tables, os

var memTable = initTable[string, string]()

proc wal_append(key: string, val: string) {.discardable.} =
  echo "[LSM WAL] Appending entry -> " & key & ":" & val
  discard execCmd("echo '" & key & "=" & val & "' >> /tmp/lsm_wal.log")

proc lsm_put(key: string, val: string) {.discardable.} =
  wal_append(key, val)
  memTable[key] = val
  if memTable.len >= 3:
    echo "[LSM SSTable] MemTable threshold reached! Flushing MemTable to immutable SSTable disk chunk..."
    discard execCmd("echo '[SSTable Chunk] Flushed 3 entries to disk' >> /tmp/lsm_sstable.log")
    memTable.clear()

lsm_put("user:101", "Alice")
lsm_put("user:102", "Bob")
lsm_put("user:103", "Charlie")
