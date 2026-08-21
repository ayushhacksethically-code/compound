import std/osproc
#  Project 9: Firewall Rule Synthesizer
proc apply_rule(port: int, action: string) {.discardable.} =
  echo "Applying firewall rule for port " & $port & " (" & action & ")"
  discard execCmd("echo '[iptables] -A INPUT -p tcp --dport " & $port & " -j " & action & "'")

apply_rule(80, "ACCEPT")
apply_rule(443, "ACCEPT")
apply_rule(22, "ACCEPT")
