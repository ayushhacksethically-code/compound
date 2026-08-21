import std/osproc
#  5. Multi-User Telnet Live Chat Room & Hub
proc process_chat_message(user: string, room: string, text: string) {.discardable.} =
  echo "[Telnet Chat Port 8080] [" & room & "] <" & user & ">: " & text

process_chat_message("Narayana", "#general", "Welcome to Compound Telnet Chat!")
