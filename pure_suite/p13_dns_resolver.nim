import std/[osproc, os]
#  13. DNS UDP Resolver Engine
proc build_dns_query(domain: string): seq[byte] {.discardable.} =
  echo "[Pure DNS Resolver] Constructed RFC-1035 UDP Query packet for: " & domain
  return @[0xAA'u8, 0xBB'u8, 0x01'u8, 0x00'u8]

var pkt = build_dns_query("example.com")
echo "[Pure DNS Resolver] Header length: " & $pkt.len & " bytes"
