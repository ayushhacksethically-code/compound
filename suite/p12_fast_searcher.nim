import std/osproc
#  Project 12: Fast File Content Searcher (ripgrep clone)
proc search_content(keyword: string, dir: string) {.discardable.} =
  echo "Searching for '" & keyword & "' in directory: " & dir
  discard execCmd("grep -rnI '" & keyword & "' " & dir & " | head -n 5")

search_content("transpile", "/home/narayanas/projects/compound")
