import std/osproc
#  Project 28: Static Binary Asset CDN
import os

proc serve_asset(path: string) {.discardable.} =
  if fileExists(path):
    echo "Serving static cached asset: " & path & " (Size: " & $getFileSize(path) & " bytes)"
  else:
    echo "Asset not found: " & path

serve_asset("/home/narayanas/projects/compound/compound")
