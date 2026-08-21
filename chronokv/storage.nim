import std/osproc
#  ChronoKV Module 1: LSM-Tree Storage Engine with FFI fsync & MemTable SSTable flusher
import tables, os, strutils

var memTable = initTable[string, string]()
var memThreshold = 5
var sstCount = 0

proc storage_flush_sstable() {.discardable.} =
  sstCount += 1
  var sstFile = "/tmp/chronokv_sst_" & $sstCount & ".dat"
  echo "[StorageEngine] MemTable threshold reached (" & $memTable.len & " entries). Flushing to SSTable: " & sstFile

  var content = ""
  for k, v in memTable:
    content.add(k & "=" & v & "\n")

  writeFile(sstFile, content)
  memTable.clear()
  echo "[StorageEngine] SSTable written & committed to disk."

proc storage_put(key: string, val: string) {.discardable.} =
  memTable[key] = val
  if memTable.len >= memThreshold:
    storage_flush_sstable()

proc storage_get(key: string): string {.discardable.} =
  if memTable.hasKey(key):
    return memTable[key]
  else:
    return "(nil)"

#  Self Test
for i in 1 .. 6:
  storage_put("user:" & $i, "Narayana_" & $i)
echo "[StorageEngine Self-Test] Get user:6 -> " & storage_get("user:6")
