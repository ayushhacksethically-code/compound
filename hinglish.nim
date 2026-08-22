import std/[strutils, osproc, os]

type
  OptionKind* = enum okSome, okNone
  Option*[T] = object
    case kind*: OptionKind
    of okSome: val*: T
    of okNone: discard

  ResultKind* = enum rkOk, rkErr
  Result*[T, E] = object
    case kind*: ResultKind
    of rkOk: value*: T
    of rkErr: error*: E

proc MilGaya*[T](v: T): Option[T] = Option[T](kind: okSome, val: v)
proc Some*[T](v: T): Option[T] = Option[T](kind: okSome, val: v)
proc Khali*[T](): Option[T] = Option[T](kind: okNone)

proc Sahi*[T, E](v: T): Result[T, E] = Result[T, E](kind: rkOk, value: v)
proc Ok*[T, E](v: T): Result[T, E] = Result[T, E](kind: rkOk, value: v)
proc Galti*[T, E](e: E): Result[T, E] = Result[T, E](kind: rkErr, error: e)

proc checkBorrowAndOwnership*(code: string, isHinglish: bool) =
  var movedVars: seq[string] = @[]
  var lineNum = 0
  let moveKw = if isHinglish: "chala_gaya " else: "moved "

  for rawLine in code.splitLines():
    inc lineNum
    let line = rawLine.strip()
    if line.len == 0 or line.startsWith("#") or line.startsWith("//"):
      continue

    if moveKw in line:
      let parts = line.split(moveKw)
      if parts.len > 1:
        var targetVar = parts[1].strip()
        if targetVar.endsWith(")"): targetVar = targetVar[0 .. ^2].strip()
        if targetVar.endsWith(","): targetVar = targetVar[0 .. ^2].strip()
        if targetVar.len > 0 and targetVar notin movedVars:
          movedVars.add(targetVar)

    for mv in movedVars:
      if moveKw notin line and (line.startsWith(mv & " ") or line.contains(" " & mv & " ") or line.endsWith(" " & mv) or line.contains("(" & mv & ")")):
        if not (line.startsWith("var ") or line.startsWith("rakho ") or line.startsWith("const ") or line.startsWith("let ")):
          let errPrefix = if isHinglish: "[Galti - BorrowChecker]" else: "[Error - BorrowChecker]"
          raise newException(ValueError, errPrefix & " Line " & $lineNum & ": Variable '" & mv & "' use nahi ho sakta kyunki iski ownership move ho chuki hai (" & moveKw.strip() & " " & mv & ").")

proc maskStrings*(line: string, strTable: var seq[string]): string =
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

proc unmaskStrings*(line: string, strTable: seq[string]): string =
  var res = line
  for idx, s in strTable:
    let placeholder = "___COMPOUND_STR_" & $idx & "___"
    res = res.replace(placeholder, s)
  return res

proc translateHinglishLine*(line: string): string =
  var strTable: seq[string] = @[]
  var maskedLine = maskStrings(line, strTable)
  var l = maskedLine.strip()
  if l.len == 0: return ""
  if l.startsWith("//") or l.startsWith("#"): return "# " & unmaskStrings(l.substr(2), strTable)

  # Move Semantics translation
  if "chala_gaya " in l:
    let parts = l.split("chala_gaya ")
    var target = parts[1].strip()
    var rest = ""
    if ")" in target:
      let subParts = target.split(")")
      target = subParts[0].strip()
      rest = ")" & subParts[1..^1].join(")")
    l = parts[0] & "move(" & target & ")" & rest

  # 1. Shell Command Execution ($ "cmd", chalao "cmd", or ps_kaam "cmd")
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
  if l.startsWith("shamil_karo ") or l.startsWith("import_karo "):
    return "import " & unmaskStrings(l.replace("shamil_karo ", "").replace("import_karo ", ""), strTable)
  elif l.startsWith("c_ka_kaam "):
    let content = l.substr(10)
    if " from " in content:
      let parts = content.split(" from ")
      let header = parts[1]
      let fnDef = parts[0]
      return "proc " & unmaskStrings(fnDef, strTable) & " {.importc, header: " & unmaskStrings(header, strTable) & ", discardable.}"
    else:
      return "proc " & unmaskStrings(content, strTable) & " {.importc, discardable.}"

  # 3. Rigid Operator Substitutions (Word bounded / exact tokens)
  l = l.replace(" += ", " += ")
  l = l.replace(" -= ", " -= ")
  l = l.replace(" *= ", " *= ")
  l = l.replace(" /= ", " /= ")
  l = l.replace(" %= ", " mod= ")
  l = l.replace(" **= ", " ^= ")
  l = l.replace(" //= ", " div= ")

  l = l.replace(" ** ", " ^ ")
  l = l.replace(" // ", " div ")
  l = l.replace(" % ", " mod ")
  l = l.replace(" << ", " shl ")
  l = l.replace(" >> ", " shr ")

  # 4. Rigid Hinglish Logical Operators & Word Constants
  l = l.replace(" aur ", " and ")
  l = l.replace(" ya ", " or ")
  l = l.replace(" nahi ", " not ")
  l = l.replace(" sahi", " true")
  l = l.replace(" galat", " false")
  l = l.replace(" khali", " nil")
  if l == "...": l = "discard"
  l = l.replace("bahar_niklo()", "quit(0)")
  l = l.replace("band_karo()", "quit(0)")

  # 5. Strip Block Opener 'toh'
  var hasToh = false
  if l.endsWith(" se toh"):
    l = l[0 .. ^8].strip()
    hasToh = true
  elif l.endsWith(" toh"):
    l = l[0 .. ^5].strip()
    hasToh = true

  # 6. Pattern Matching Case Clauses for Option & Result Types
  if l.startsWith("hai MilGaya(") or l.startsWith("hai Some("):
    let varName = l.split("(")[1].replace(")", "").strip()
    return "of okSome:\nvar " & varName & " = it.val"
  elif l == "hai Khali" or l == "hai None":
    return "of okNone:"
  elif l.startsWith("hai Sahi(") or l.startsWith("hai Ok("):
    let varName = l.split("(")[1].replace(")", "").strip()
    return "of rkOk:\nvar " & varName & " = it.value"
  elif l.startsWith("hai Galti(") or l.startsWith("hai Err("):
    let varName = l.split("(")[1].replace(")", "").strip()
    return "of rkErr:\nvar " & varName & " = it.error"

  # 7. Rigid Word Token Prefix Grammar (Strict Tokens)
  if l.startsWith("pukka kaam "):
    let content = l.substr(11)
    l = "proc " & content & " {.discardable.}"
  elif l.startsWith("pukka "): l = "const " & l.substr(6)
  elif l.startsWith("rakho "): l = "var " & l.substr(6)
  elif l.startsWith("banao "): l = "type " & l.substr(6)
  elif l.startsWith("dikhao "): l = "echo " & l.substr(7)
  elif l.startsWith("agar "): l = "if " & l.substr(5)
  elif l.startsWith("varna agar "): l = "elif " & l.substr(11)
  elif l == "varna": l = "else"
  elif l.startsWith("jabtak "): l = "while " & l.substr(7)
  elif l.startsWith("har ") and " mein " in l:
    let rest = l.substr(4)
    let parts = rest.split(" mein ")
    l = "for " & parts[0] & " in " & parts[1]
  elif l.startsWith("kaam "):
    let content = l.substr(5)
    if "{" in content:
      l = "proc " & content
    else:
      l = "proc " & content & " {.discardable.}"
  elif l.startsWith("wapas "): l = "return " & l.substr(6)
  elif l == "wapas": l = "return"
  elif l == "aage_bhadho" or l == "jaari_rakho": l = "continue"
  elif l == "roko" or l == "tod_do": l = "break"
  elif l == "chhod_do" or l == "kuch_nahi": l = "discard"
  elif l.startsWith("galti_phenko "): l = "raise newException(ValueError, " & l.substr(13) & ")"
  elif l.startsWith("koshish_karo"): l = "try"
  elif l.startsWith("galti_pakdo "): l = "except " & l.substr(12)
  elif l == "galti_pakdo": l = "except"
  elif l == "aakhir_mein": l = "finally"
  elif l.startsWith("shart_jaanch "): l = "doAssert " & l.substr(13)
  elif l.startsWith("chuno "):
    let expr = l.substr(6).strip()
    return "let it = " & expr & "\ncase it.kind:"
  elif l.startsWith("jab ") and not l.contains("defined("): l = "of " & l.substr(4)

  l = l.replace("pucho()", "readLine(stdin)")

  if l.startsWith("proc ") or l.startsWith("iterator "):
    if not l.endsWith("="): l.add(" =")
  elif l.startsWith("type "):
    if l.endsWith("="): l = l[0 .. ^2].strip()
    if l.endsWith("enum"): discard
  elif (hasToh or l.startsWith("if ") or l.startsWith("elif ") or l == "else" or l.startsWith("while ") or l.startsWith("for ") or l == "try" or l.startsWith("except") or l == "finally" or l.startsWith("case ") or l.startsWith("of ")) and not l.startsWith("proc "):
    if not l.endsWith(":"): l.add(":")

  return unmaskStrings(l, strTable)

proc transpileHinglish*(code: string): string =
  checkBorrowAndOwnership(code, true)
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
    if stripped == "khatam" or stripped == "bas":
      if currentIndent > 0: dec currentIndent
      continue

    if stripped.len == 0:
      nimLines.add("")
      continue

    var translated = translateHinglishLine(stripped)

    # If translated contains multiple lines (e.g. from chuno or pattern match)
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


