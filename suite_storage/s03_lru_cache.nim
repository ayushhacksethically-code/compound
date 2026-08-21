import std/osproc
#  Storage Engine 3: In-Memory Cache with LRU Eviction
import tables, lists

var cacheMap = initTable[string, string]()
var lruOrder: seq[string] = @[]

proc lru_put(key: string, val: string, capacity: int) {.discardable.} =
  if lruOrder.len >= capacity:
    var evictedKey = lruOrder[0]
    echo "[LRU Evict] Capacity reached! Evicting oldest key: " & evictedKey
    cacheMap.del(evictedKey)
    lruOrder.delete(0)
  cacheMap[key] = val
  lruOrder.add(key)
  echo "[LRU Cache] Put key: " & key & " => " & val

lru_put("session:1", "active", 2)
lru_put("session:2", "active", 2)
lru_put("session:3", "active", 2)
