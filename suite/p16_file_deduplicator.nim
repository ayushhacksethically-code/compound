import std/osproc
#  Project 16: High-Speed File Deduplicator
proc find_duplicates(dir: string) {.discardable.} =
  echo "Finding duplicate checksums in directory: " & dir
  discard execCmd("find " & dir & " -type f -name '*.nim' -exec sha256sum {} + | sort | uniq -w64 -d")

find_duplicates("/home/narayanas/projects/compound")
