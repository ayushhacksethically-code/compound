import std/osproc
#  Project 26: WebSocket Live Chat Server
proc broadcast_msg(room: string, user: string, text: string) {.discardable.} =
  echo "[Room: " & room & "] <" & user & ">: " & text

broadcast_msg("dev", "alice", "Hello Compound language!")
broadcast_msg("dev", "bob", "Hinglish and English dual syntax is amazing!")
