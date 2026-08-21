import std/osproc
#  Project 13: Disk Space Analyzer (du clone)
proc analyze_disk(dir: string) {.discardable.} =
  echo "Analyzing disk usage in: " & dir
  discard execCmd("du -h --max-depth=1 " & dir & " 2>/dev/null | sort -hr | head -n 6")

analyze_disk("/home/narayanas/projects/compound")
