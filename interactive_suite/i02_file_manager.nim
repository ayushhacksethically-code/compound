import std/osproc
#  2. Terminal File Manager & Directory Browser (ranger / mc Clone)
import os

proc render_browser(dir_path: string) {.discardable.} =
  echo "=== Terminal File Browser: " & dir_path & " ==="
  echo "[Parent] /home/narayanas | [Current] " & dir_path & " | [Preview]"
  echo "-> file1.txt (1024 B)"
  echo "-> file2.hg  (2048 B)"
  echo "[Controls] Arrow keys: Navigate | Enter: Open | d: Delete"

render_browser("/home/narayanas/projects/compound")
