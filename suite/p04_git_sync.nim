import std/osproc
#  Project 4: Git Workspace Synchronizer
proc sync_repo(path: string) {.discardable.} =
  echo "Synchronizing git workspace at: " & path
  discard execCmd("git -C " & path & " status --short")

sync_repo("/home/narayanas/projects/compound")
