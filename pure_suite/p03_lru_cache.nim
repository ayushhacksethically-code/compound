import std/osproc
#  3. In-Memory Cache with LRU Eviction
import tables

var cache = initTable[string, string]()
var order: seq[string] = @[]

proc put_lru(k: string, v: string, cap: int) {.discardable.} =
  if order.len >= cap:
    var evicted = order[0]
    echo "[Pure LRU] Evicting oldest key: " & evicted
    cache.del(evicted)
    order.delete(0)
  cache[k] = v
  order.add(k)
  echo "[Pure LRU] Inserted " & k & " => " & v

put_lru("a", "1", 2)
put_lru("b", "2", 2)
put_lru("c", "3", 2)
