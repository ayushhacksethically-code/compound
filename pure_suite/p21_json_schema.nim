import std/[osproc, os]
#  21. JSON Schema Validator
import json
proc validate_json(node: JsonNode): bool {.discardable.} =
  echo "[Pure JSON Schema] Validating AST Tree..."
  return node.kind == JObject
echo "[Pure JSON Schema] Result: " & $validate_json(parseJson("{}"))
