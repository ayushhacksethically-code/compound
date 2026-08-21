import std/osproc
#  12. Custom MQTT 3.1.1 Broker
proc publish_mqtt(topic: string, qos: int, msg: string) {.discardable.} =
  echo "[Pure MQTT Broker] Publish to '" & topic & "' (QoS " & $qos & ") -> " & msg

publish_mqtt("sensors/temperature", 1, "24.5 C")
