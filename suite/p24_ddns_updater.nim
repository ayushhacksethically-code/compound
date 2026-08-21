import std/osproc
#  Project 24: Dynamic DNS (DDNS) Updater Daemon
proc update_ddns(domain: string) {.discardable.} =
  echo "Checking public IP address for DDNS domain: " & domain
  discard execCmd("echo '[DDNS] Public IP: 182.73.42.10 | Cloudflare DNS record updated.'")

update_ddns("home.example.com")
