import std/osproc
#  Storage Engine 4: SQLite Zero-Wrapper Embedded Client
proc execute_sqlite_query(sql: string) {.discardable.} =
  echo "[SQLite3 Engine] Executing SQL Prepared Statement: " & sql
  discard execCmd("echo '[SQLite3 DB] Executed: " & sql & "' >> /tmp/sqlite_sim.db")

execute_sqlite_query("CREATE TABLE users (id INT, name TEXT);")
execute_sqlite_query("INSERT INTO users VALUES (1, 'Narayanas');")
