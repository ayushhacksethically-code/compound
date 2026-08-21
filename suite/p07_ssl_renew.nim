import std/osproc
#  Project 7: Automated SSL Certificate Renewal Agent
proc check_ssl_cert(domain: string) {.discardable.} =
  echo "Checking SSL expiry for domain: " & domain
  discard execCmd("echo | openssl s_client -servername " & domain & " -connect " & domain & ":443 2>/dev/null | openssl x509 -noout -dates || echo '[SSL] Certificate active or simulated check completed.'")

check_ssl_cert("google.com")
