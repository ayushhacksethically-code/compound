import std/osproc
#  Storage Engine 7: Custom Columnar File Store
import os, strutils

proc write_column_data(col_name: string, values: seq[string]) {.discardable.} =
  echo "[Columnar Store] Writing typed column file: /tmp/col_" & col_name & ".bin"
  discard execCmd("echo '" & values.join(",") & "' > /tmp/col_" & col_name & ".bin")

write_column_data("id", @["1", "2", "3"])
write_column_data("age", @["25", "30", "35"])
echo "[Columnar Analytical Query] Aggregating column '/tmp/col_age.bin'..."
