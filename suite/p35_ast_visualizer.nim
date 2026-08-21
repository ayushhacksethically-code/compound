import std/osproc
#  Project 35: AST Visualizer & Dependency Grapher
proc generate_dot(fn_name: string, caller: string) {.discardable.} =
  echo "  \"" & caller & "\" -> \"" & fn_name & "\";"

echo "digraph CallGraph {"
generate_dot("transpileHinglish", "main")
generate_dot("translateHinglishLine", "transpileHinglish")
echo "}"
