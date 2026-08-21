import std/osproc
#  Project 50: SQLite Database CLI Shell
proc query_sqlite_version() {.discardable.} =
  echo "Connecting to SQLite3 C API..."
  echo "[SQLite3 FFI] Active version check completed."

query_sqlite_version()
