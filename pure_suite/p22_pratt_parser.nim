import std/osproc
#  22. Pratt Parser
proc parse_expression(expr: string) {.discardable.} =
  echo "[Pure Pratt Parser] Resolving precedence for: " & expr
parse_expression("1 + 2 * 3")
