import std/osproc
#  3. Real-Time Terminal Snake & Tetris Engine
import random

proc render_snake_frame(score: int, snake_x: int, snake_y: int) {.discardable.} =
  echo "==============================="
  echo "🐍 Compound Terminal Snake Game"
  echo "Score: " & $score & " | FPS: 20"
  echo "Head Position: [" & $snake_x & ", " & $snake_y & "]"
  echo "==============================="

render_snake_frame(120, 15, 8)
