import std/osproc
#  2. B+ Tree Disk Indexer
import algorithm

proc btree_search(keys: seq[int], target: int): int {.discardable.} =
  echo "[Pure B+ Tree] Binary searching page keys " & $keys & " for key " & $target
  return keys.binarySearch(target)

var keys: seq[int] = @[10, 20, 30, 40, 50, 60]
echo "[Pure B+ Tree Page] Offset index: " & $btree_search(keys, 40)
