import std/osproc
#  Project 47: Cellular Automata Engine (Conway's Game of Life)
proc render_grid() {.discardable.} =
  echo "=== Conway's Game of Life Grid ==="
  echo "[X][ ][X]"
  echo "[ ][X][ ]"
  echo "[X][X][X]"

render_grid()
