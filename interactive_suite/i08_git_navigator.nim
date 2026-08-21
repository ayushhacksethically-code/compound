import std/osproc
#  8. Interactive Git Branch & Log Navigator
proc render_git_commit_diff(hash: string, author: string, diff: string) {.discardable.} =
  echo "=== Git Commit Navigator ==="
  echo "Commit: " & hash & " | Author: " & author
  echo "--------------------------------------------------------"
  echo "+ proc transpileHinglish*(code: string): string ="
  echo "- proc oldTranspile(code: string): string ="

render_git_commit_diff("ee357b0", "Narayana", "+/- 101 lines")
