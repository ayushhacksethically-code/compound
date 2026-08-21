import std/osproc
#  Project 41: Raylib 2D Arcade Game (Space Invaders)
proc init_game_window(title: string, w: int, h: int) {.discardable.} =
  echo "Initializing Raylib 2D Window: '" & title & "' (" & $w & "x" & $h & ")"
  echo "[Raylib FFI] C Window Render Loop Active (Simulated)"

init_game_window("Compound Space Invaders", 800, 600)
