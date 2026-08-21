import std/osproc
#  Project 30: Simple Key-Value Store over TCP (Mini-Redis)
import tables

var db = initTable[string, string]()
db["session_token"] = "xyz_abc_123"
db["user_name"] = "Narayanas"

proc get_key(k: string) {.discardable.} =
  if db.hasKey(k):
    echo "[KV Engine] " & k & " => " & db[k]
  else:
    echo "[KV Engine] " & k & " => (nil)"

get_key("user_name")
get_key("non_existing")
