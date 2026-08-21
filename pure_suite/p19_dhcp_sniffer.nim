import std/[osproc, os]
#  19. DHCP Packet Sniffer & Decoder
proc decode_dhcp_packet(mac: string, requested_ip: string) {.discardable.} =
  echo "[Pure DHCP Sniffer] Captured DHCPREQUEST from MAC: " & mac
  echo "[Pure DHCP Sniffer] Requested IP Lease: " & requested_ip

decode_dhcp_packet("AA:BB:CC:DD:EE:FF", "192.168.1.150")
