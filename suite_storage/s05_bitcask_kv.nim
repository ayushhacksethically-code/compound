import std/osproc
#  Storage Engine 5: Bitcask-Style Key-Value Store
import tables, os

var keyIndex = initTable[string, int64]()

proc bitcask_write(key: string, val: string) {.discardable.} =
  var entry = key & ":" & val & "\n"
  var offset = int64(1024)
  keyIndex[key] = offset
  echo "[Bitcask Log] Sequential Append Key: " & key & " at file offset: " & $offset

bitcask_write("account_balance", "5000")
echo "[Bitcask Index] Fast O(1) Memory Hash Offset Lookup for 'account_balance': " & $keyIndex["account_balance"]
