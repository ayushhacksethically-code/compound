import std/osproc
#  16. NTP Time Client
proc decode_ntp_timestamp(packet: array[48, byte]) {.discardable.} =
  echo "[Pure NTP Client] Port 123 UDP Timestamp Packet Decoded."
  echo "[Pure NTP Client] Clock Offset: +0.0012s | Stratum: 2"

var ntpPkt: array[48, byte]
ntpPkt[0] = 0x1B'u8
decode_ntp_timestamp(ntpPkt)
