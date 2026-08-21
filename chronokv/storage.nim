import std/osproc
#  ChronoKV Module 1: Production LSM-Tree Engine (MemTable + Multi-SSTable Disk Scanner)
import tables, os, strutils

var memTable = initTable[string, string]()
var memThreshold = 500
var sstCount = 0

proc storage_flush_sstable() {.discardable.} =
  sstCount += 1
  var sstFile = "/tmp/chronokv_sst_" & $sstCount & ".dat"

  var content = ""
  for k, v in memTable:
    content.add(k & "=" & v & "\n")

  writeFile(sstFile, content)
  memTable.clear()

proc storage_put(key: string, val: string) {.discardable.} =
  memTable[key] = val
  if memTable.len >= memThreshold:
    storage_flush_sstable()

proc storage_get(key: string): string {.discardable.} =
  #  1. Check RAM MemTable first
  if memTable.hasKey(key):
    return memTable[key]

  #  2. Scan flushed SSTable disk files in reverse chronological order (newest to oldest)
  for i in countdown(sstCount, 1):
    var sstFile = "/tmp/chronokv_sst_" & $i & ".dat"
    if fileExists(sstFile):
      var lines = readFile(sstFile).splitLines()
      for line in lines:
        if "=" in line:
          var parts = line.split("=")
          if parts[0] == key:
            return parts[1]

  return "(nil)"

#  Test SSTable Disk Recovery
storage_put("persist_key", "Real_Disk_Data_Narayana")
storage_flush_sstable()
echo "[SSTable Read Test] Querying 'persist_key' after MemTable Clear -> " & storage_get("persist_key")
