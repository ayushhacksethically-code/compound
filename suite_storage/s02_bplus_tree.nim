import std/osproc
#  Storage Engine 2: B+ Tree Disk Indexer (4KB Block Node Manager)
import algorithm

proc btree_insert_key(keys: seq[int], target_key: int): int {.discardable.} =
  echo "[B+ Tree Indexer] Performing binary search for target key " & $target_key
  return keys.binarySearch(target_key)

var node_keys: seq[int] = @[10, 20, 30, 40, 50]
echo "[B+ Tree Node Page] Size: 4096 bytes | Keys: " & $node_keys
echo "[B+ Tree Indexer] Key index offset: " & $btree_insert_key(node_keys, 30)
