import std/[strutils, osproc, os]

import hinglish

proc translateEnglishLine*(line: string): string =
  var strTable: seq[string] = @[]
  var maskedLine = maskStrings(line, strTable)
  var l = maskedLine.strip()
  if l.len == 0: return ""
  if l.startsWith("//") or l.startsWith("#"): return "# " & unmaskStrings(l.substr(2), strTable)

  # Move Semantics translation
  if "moved " in l:
    let parts = l.split("moved ")
    var target = parts[1].strip()
    var rest = ""
    if ")" in target:
      let subParts = target.split(")")
      target = subParts[0].strip()
      rest = ")" & subParts[1..^1].join(")")
    l = parts[0] & "move(" & target & ")" & rest

  # 1. Shell Command Execution ($ "cmd", shell "cmd", or ps_command "cmd")
  if l.startsWith("ps_kaam ") or l.startsWith("ps_command ") or l.startsWith("ps_shell ") or l.startsWith("ps "):
    var cmdStr = l
    if cmdStr.startsWith("ps_kaam "): cmdStr = cmdStr.substr(8)
    elif cmdStr.startsWith("ps_command "): cmdStr = cmdStr.substr(11)
    elif cmdStr.startsWith("ps_shell "): cmdStr = cmdStr.substr(9)
    elif cmdStr.startsWith("ps "): cmdStr = cmdStr.substr(3)
    let unmasked = unmaskStrings(cmdStr, strTable)
    return "discard execCmd(\"pwsh -NoProfile -NonInteractive -Command \" & quoteShell(" & unmasked & "))"
  elif l.startsWith("$ ") or l.startsWith("shell ") or l.startsWith("chalao "):
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
      let header = parts[1]
      let fnDef = parts[0]
      return "proc " & unmaskStrings(fnDef, strTable) & " {.importc, header: " & unmaskStrings(header, strTable) & ", discardable.}"
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
  l = l.replace(" yes ", " true ")
  l = l.replace(" no ", " false ")
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

  # 6. Pattern Matching Case Clauses for Option & Result Types
  if l.startsWith("is Some(") or l.startsWith("is MilGaya("):
    let varName = l.split("(")[1].replace(")", "").strip()
    return "of okSome:\n  var " & varName & " = it.val"
  elif l == "is None" or l == "is Khali":
    return "of okNone:"
  elif l.startsWith("is Ok(") or l.startsWith("is Sahi("):
    let varName = l.split("(")[1].replace(")", "").strip()
    return "of rkOk:\n  var " & varName & " = it.value"
  elif l.startsWith("is Err(") or l.startsWith("is Galti("):
    let varName = l.split("(")[1].replace(")", "").strip()
    return "of rkErr:\n  var " & varName & " = it.error"

  # 7. Rigid English Word Token Prefix Grammar (Strict Tokens)
  if l.startsWith("strict task "):
    let content = l.substr(12)
    l = "proc " & content & " {.discardable.}"
  elif l.startsWith("keep "): l = "var " & l.substr(5)
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
  elif l.startsWith("match "):
    let expr = l.substr(6).strip()
    return "let it = " & expr & "\ncase it.kind:"
  elif l.startsWith("case "): l = "of " & l.substr(5)
  elif l.startsWith("when ") and not l.contains("defined("): l = "of " & l.substr(5)

  l = l.replace("ask()", "readLine(stdin)")
  l = l.replace("input()", "readLine(stdin)")

  if l.startsWith("proc ") or l.startsWith("iterator "):
    if not l.endsWith("="): l.add(" =")
  elif l.startsWith("type "):
    if l.endsWith("="): l = l[0 .. ^2].strip()
    if l.endsWith("enum"): discard
  elif (hasTrigger or l.startsWith("if ") or l.startsWith("elif ") or l == "else" or l.startsWith("while ") or l.startsWith("for ") or l == "try" or l.startsWith("except") or l == "finally" or l.startsWith("case ") or l.startsWith("of ")) and not l.startsWith("proc "):
    if not l.endsWith(":") and not l.endsWith("="): l.add(":")

  return unmaskStrings(l, strTable)

proc transpileEnglish*(code: string): string =
  checkBorrowAndOwnership(code, false)
  var lines = code.splitLines()
  var nimLines: seq[string] = @[
    "when not defined(js):\n  import std/[osproc, os]",
    "type OptionKind* = enum okSome, okNone",
    "type Option*[T] = object",
    "  case kind*: OptionKind",
    "  of okSome: val*: T",
    "  of okNone: discard",
    "type ResultKind* = enum rkOk, rkErr",
    "type Result*[T, E] = object",
    "  case kind*: ResultKind",
    "  of rkOk: value*: T",
    "  of rkErr: error*: E",
    "proc MilGaya*[T](v: T): Option[T] = Option[T](kind: okSome, val: v)",
    "proc Some*[T](v: T): Option[T] = Option[T](kind: okSome, val: v)",
    "proc Khali*[T](): Option[T] = Option[T](kind: okNone)",
    "proc Sahi*[T, E](v: T): Result[T, E] = Result[T, E](kind: rkOk, value: v)",
    "proc Ok*[T, E](v: T): Result[T, E] = Result[T, E](kind: rkOk, value: v)",
    "proc Galti*[T, E](e: E): Result[T, E] = Result[T, E](kind: rkErr, error: e)"
  ]
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

    # If translated contains multiple lines
    let subLines = translated.splitLines()
    for sLine in subLines:
      let subStripped = sLine.strip()
      if subStripped.len == 0: continue

      var tLine = subStripped

      if tLine.startsWith("var "):
        let parts = tLine.substr(4).split("=")
        let varName = parts[0].split(":")[0].strip()
        if varName notin declaredVars: declaredVars.add(varName)

      if tLine == "else:" or tLine.startsWith("elif ") or tLine.startsWith("except") or tLine == "finally:":
        var indentToUse = currentIndent - 1
        if indentToUse < 0: indentToUse = 0
        nimLines.add("  ".repeat(indentToUse) & tLine)
        if tLine.endsWith(":"): inc currentIndent
        continue

      if tLine.startsWith("of "):
        var indentToUse = currentIndent - 1
        if indentToUse < 0: indentToUse = 0
        nimLines.add("  ".repeat(indentToUse) & tLine)
        currentIndent = indentToUse + 1
        continue

      if tLine.len > 0:
        nimLines.add("  ".repeat(currentIndent) & tLine)
        if (tLine.endsWith(":") or tLine.endsWith("=") or tLine.endsWith("object") or tLine.startsWith("iterator ")) and not tLine.startsWith("#"):
          inc currentIndent

  return nimLines.join("\n")
