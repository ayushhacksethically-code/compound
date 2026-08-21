import std/[strutils, osproc]

proc maskStrings(line: string, strTable: var seq[string]): string =
  var resultStr = ""
  var inString = false
  var currentStr = ""
  var quoteChar = '"'
  var i = 0
  while i < line.len:
    let c = line[i]
    if not inString:
      if c == '"' or c == '\'':
        inString = true
        quoteChar = c
        currentStr = $c
      else:
        resultStr.add(c)
    else:
      currentStr.add(c)
      if c == quoteChar and (i == 0 or line[i-1] != '\\'):
        inString = false
        let placeholder = "___COMPOUND_STR_" & $strTable.len & "___"
        strTable.add(currentStr)
        resultStr.add(placeholder)
    inc i
  if inString:
    let placeholder = "___COMPOUND_STR_" & $strTable.len & "___"
    strTable.add(currentStr)
    resultStr.add(placeholder)
  return resultStr

proc unmaskStrings(line: string, strTable: seq[string]): string =
  var res = line
  for idx, s in strTable:
    let placeholder = "___COMPOUND_STR_" & $idx & "___"
    res = res.replace(placeholder, s)
  return res

proc translateEnglishLine*(line: string): string =
  var strTable: seq[string] = @[]
  var maskedLine = maskStrings(line, strTable)
  var l = maskedLine.strip()
  if l.len == 0: return ""
  if l.startsWith("//") or l.startsWith("#"): return "# " & unmaskStrings(l.substr(2), strTable)

  # 1. Shell Command Execution ($ "cmd" or shell "cmd")
  if l.startsWith("$ ") or l.startsWith("shell ") or l.startsWith("chalao "):
    let cmdStr = l.replace("$ ", "").replace("shell ", "").replace("chalao ", "")
    return "discard execCmd(" & unmaskStrings(cmdStr, strTable) & ")"

  l = l.replace("command(", "execCmdEx(")

  # 2. Imports & FFI
  if l.startsWith("import ") or l.startsWith("use "):
    return "import " & unmaskStrings(l.replace("import ", "").replace("use ", ""), strTable)
  elif l.startsWith("c_func "):
    let content = l.substr(7)
    if " from " in content:
      let parts = content.split(" from ")
      let header = parts[1].replace("\"", "")
      let fnDef = parts[0]
      return "proc " & unmaskStrings(fnDef, strTable) & " {.importc, header: \"" & unmaskStrings(header, strTable) & "\", discardable.}"
    else:
      return "proc " & unmaskStrings(content, strTable) & " {.importc, discardable.}"

  # 3. Rigid Comparison & Synonym Substitutions
  l = l.replace(" is bigger than or equal to ", " >= ")
  l = l.replace(" is smaller than or equal to ", " <= ")
  l = l.replace(" is bigger than ", " > ")
  l = l.replace(" is larger than ", " > ")
  l = l.replace(" is smaller than ", " < ")
  l = l.replace(" is equal to ", " == ")
  l = l.replace(" is not equal to ", " != ")

  # 4. Math & Bitwise Word Operators
  l = l.replace(" += ", " += ")
  l = l.replace(" -= ", " -= ")
  l = l.replace(" *= ", " *= ")
  l = l.replace(" /= ", " /= ")
  l = l.replace(" %= ", " mod= ")
  l = l.replace(" **= ", " ^= ")
  l = l.replace(" //= ", " div= ")

  l = l.replace(" true", " true")
  l = l.replace(" false", " false")
  l = l.replace(" yes", " true")
  l = l.replace(" no", " false")
  l = l.replace(" none", " nil")
  l = l.replace(" empty", " nil")
  if l == "...": l = "discard"
  l = l.replace("exit()", "quit(0)")
  l = l.replace("stop()", "quit(0)")

  l = l.replace(" &= ", " and= ")
  l = l.replace(" |= ", " or= ")
  l = l.replace(" ^= ", " xor= ")
  l = l.replace(" <<= ", " shl= ")
  l = l.replace(" >>= ", " shr= ")

  l = l.replace(" ** ", " ^ ")
  l = l.replace(" // ", " div ")
  l = l.replace(" % ", " mod ")
  l = l.replace(" << ", " shl ")
  l = l.replace(" >> ", " shr ")

  # 5. Strip Block Opener 'do'
  var hasTrigger = false
  if l.endsWith(" do"):
    l = l[0 .. ^4].strip()
    hasTrigger = true

  # 6. Rigid English Word Token Prefix Grammar (Strict Tokens)
  if l.startsWith("keep "): l = "var " & l.substr(5)
  elif l.startsWith("var "): l = "var " & l.substr(4)
  elif l.startsWith("let "): l = "var " & l.substr(4)
  elif l.startsWith("fixed "): l = "const " & l.substr(6)
  elif l.startsWith("const "): l = "const " & l.substr(6)
  elif l.startsWith("make "): l = "type " & l.substr(5)
  elif l.startsWith("type "): l = "type " & l.substr(5)
  elif l.startsWith("show "): l = "echo " & l.substr(5)
  elif l.startsWith("print "): l = "echo " & l.substr(6)
  elif l.startsWith("if "): l = "if " & l.substr(3)
  elif l.startsWith("elif "): l = "elif " & l.substr(5)
  elif l.startsWith("otherwise if "): l = "elif " & l.substr(13)
  elif l == "else" or l == "otherwise": l = "else"
  elif l.startsWith("while "): l = "while " & l.substr(6)
  elif l.startsWith("for ") and " in " in l: l = l
  elif l.startsWith("each ") and " in " in l:
    let rest = l.substr(5)
    let parts = rest.split(" in ")
    l = "for " & parts[0] & " in " & parts[1]
  elif l.startsWith("task "):
    let content = l.substr(5)
    if "{" in content:
      l = "proc " & content
    else:
      l = "proc " & content & " {.discardable.}"
  elif l.startsWith("function "):
    let content = l.substr(9)
    if "{" in content:
      l = "proc " & content
    else:
      l = "proc " & content & " {.discardable.}"
  elif l.startsWith("proc "):
    let content = l.substr(5)
    if "{" in content:
      l = "proc " & content
    else:
      l = "proc " & content & " {.discardable.}"
  elif l.startsWith("return "): l = "return " & l.substr(7)
  elif l == "return": l = "return"
  elif l == "continue" or l == "skip": l = "continue"
  elif l == "break" or l == "stop": l = "break"
  elif l == "pass" or l == "nothing": l = "discard"
  elif l.startsWith("raise "): l = "raise newException(ValueError, " & l.substr(6) & ")"
  elif l.startsWith("throw "): l = "raise newException(ValueError, " & l.substr(6) & ")"
  elif l.startsWith("try"): l = "try"
  elif l.startsWith("catch "): l = "except " & l.substr(6)
  elif l == "catch" or l == "except": l = "except"
  elif l == "finally": l = "finally"
  elif l.startsWith("assert "): l = "doAssert " & l.substr(7)
  elif l.startsWith("match "): l = "case " & l.substr(6)
  elif l.startsWith("case "): l = "of " & l.substr(5)
  elif l.startsWith("when "): l = "of " & l.substr(5)

  l = l.replace("ask()", "readLine(stdin)")
  l = l.replace("input()", "readLine(stdin)")

  if l.startsWith("proc ") or l.startsWith("iterator "):
    if not l.endsWith("="): l.add(" =")
  elif l.startsWith("type "):
    if l.endsWith("="): l = l[0 .. ^2].strip()
    if l.endsWith("enum"): discard
  elif hasTrigger or l.startsWith("if ") or l.startsWith("elif ") or l == "else" or l.startsWith("while ") or l.startsWith("for ") or l == "try" or l.startsWith("except") or l == "finally" or l.startsWith("case ") or l.startsWith("of "):
    if not l.endsWith(":") and not l.endsWith("="): l.add(":")

  return unmaskStrings(l, strTable)

proc transpileEnglish*(code: string): string =
  var lines = code.splitLines()
  var nimLines: seq[string] = @["import std/osproc"]
  var declaredVars: seq[string] = @[]
  var currentIndent = 0

  for rawLine in lines:
    let stripped = rawLine.strip()

    # 7. Rigid Block Closer Tokens
    if stripped == "done" or stripped == "end":
      if currentIndent > 0: dec currentIndent
      continue

    if stripped.len == 0:
      nimLines.add("")
      continue

    var translated = translateEnglishLine(stripped)

    if translated.startsWith("var "):
      let parts = translated.substr(4).split("=")
      let varName = parts[0].split(":")[0].strip()
      if varName notin declaredVars: declaredVars.add(varName)

    # Automatic variable declaration on assignment (Python-style 'a = 0' -> 'var a = 0')
    if "=" in translated and not (translated.startsWith("var ") or translated.startsWith("const ") or translated.startsWith("type ") or translated.startsWith("if ") or translated.startsWith("proc ") or translated.startsWith("iterator ") or translated.startsWith("discard ") or translated.endsWith("=")):
      let parts = translated.split("=")
      let varName = parts[0].strip()
      if not (varName.contains(" ") or varName.contains("(") or varName.contains("[") or varName.contains("]") or varName.contains(".")):
        if varName notin declaredVars:
          declaredVars.add(varName)
          translated = "var " & translated

    if translated == "else:" or translated.startsWith("elif ") or translated.startsWith("except") or translated == "finally:" or translated.startsWith("of "):
      var indentToUse = currentIndent - 1
      if indentToUse < 0: indentToUse = 0
      nimLines.add("  ".repeat(indentToUse) & translated)
      if not translated.endsWith(":"): inc currentIndent
      continue

    if translated.len > 0:
      nimLines.add("  ".repeat(currentIndent) & translated)
      if translated.endsWith(":") or translated.endsWith("=") or translated.endsWith("object") or translated.startsWith("iterator "):
        inc currentIndent

  return nimLines.join("\n")

