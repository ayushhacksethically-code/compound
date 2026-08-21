import std/[osproc, os]
#  1. Append-Only LSM-Tree Storage Engine
import tables

var memTable = initTable[string, string]()

proc lsm_put(key: string, val: string, threshold: int) {.discardable.} =
  memTable[key] = val
  echo "[Pure LSM] Put key: " & key & " => " & val & " (MemTable size: " & $memTable.len & ")"
  if memTable.len >= threshold:
    echo "[Pure LSM] Threshold reached! Flushing MemTable to SSTable chunk..."
    memTable.clear()

lsm_put("k1", "v1", 2)
lsm_put("k2", "v2", 2)
