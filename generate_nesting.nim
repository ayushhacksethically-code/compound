import std/strutils

# Create deeply nested parentheses string: ((((... 1 ...))))
var nestedExpr = "1"
for i in 1 .. 500:
  nestedExpr = "(" & nestedExpr & ")"

let code = "rakho val = " & nestedExpr & "\ndikhao val\n"
writeFile("/home/narayanas/projects/compound/deep_nesting_test.hg", code)
