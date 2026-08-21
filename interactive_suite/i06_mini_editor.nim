import std/osproc
#  6. Minimal Terminal Code Editor (nano / micro Clone)
import strutils

var textBuffer = @["import std/os", "", "proc main() =", "  echo \"Hello Editor\""]

proc render_editor(file_name: string, row: int, col: int) {.discardable.} =
  echo "=== Compound Code Editor: " & file_name & " ==="
  for i, line in textBuffer:
    echo $(i + 1) & " | " & line
  echo "--------------------------------------------------------"
  echo "Ln " & $row & ", Col " & $col & " | ^S: Save | ^F: Search | ^Q: Quit"

render_editor("main.hg", 4, 15)
