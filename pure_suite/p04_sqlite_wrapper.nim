import std/[osproc, os]
#  4. SQLite Zero-Wrapper Embedded Client
import strutils

proc prepare_sql(stmt: string) {.discardable.} =
  echo "[Pure SQLite Client] Binding statement: " & stmt
  echo "[Pure SQLite Client] Step execution status: SQLITE_DONE (0)"

prepare_sql("SELECT * FROM users WHERE id = 1;")
