import std/osproc
#  Project 27: Microservice Health Prober & Uptime Dashboard
proc probe_endpoint(name: string, url: string) {.discardable.} =
  echo "Probing service: " & name & " (" & url & ")"
  discard execCmd("curl -s -o /dev/null -w '[Prober] Status: %{http_code} | Latency: %{time_total}s\n' " & url & " || echo '[Prober] Connection Offline'")

probe_endpoint("Google HTTP", "https://google.com")
