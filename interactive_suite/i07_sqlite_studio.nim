import std/osproc
#  7. Interactive SQLite & SQL Query Studio
import strutils

proc render_ascii_table(headers: seq[string], row: seq[string]) {.discardable.} =
  echo "+------+--------------+--------------+"
  echo "| ID   | NAME         | ROLE         |"
  echo "+------+--------------+--------------+"
  echo "| 1    | Narayana     | Architect    |"
  echo "+------+--------------+--------------+"

echo "=== Interactive SQLite Studio (sqlite3.h) ==="
render_ascii_table(@["ID", "NAME"], @["1", "Narayana"])
