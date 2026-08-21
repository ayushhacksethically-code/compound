import std/osproc
#  Project 25: Custom DNS Cache Server
proc query_dns(domain: string) {.discardable.} =
  echo "DNS Resolver query for: " & domain
  discard execCmd("dig +short " & domain & " | head -n 1")

query_dns("google.com")
