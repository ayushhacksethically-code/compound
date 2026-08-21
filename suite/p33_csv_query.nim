import std/osproc
#  Project 33: CSV/TSV Querying Engine
import strutils

var csvData = """id,name,role
1,Alice,DevOps
2,Bob,Systems Engineer
3,Charlie,Architect"""

proc query_csv(data: string) {.discardable.} =
  for line in data.splitLines():
    if "DevOps" in line or "Systems" in line:
      echo "[CSV Match] " & line

query_csv(csvData)
