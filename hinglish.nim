import std/[strutils, osproc]

proc translateHinglishLine*(line: string): string =
  var l = line.strip()
  if l.len == 0: return ""
  if l.startsWith("//") or l.startsWith("#"): return "# " & l.substr(2)

  # 1. Shell Command Execution ($ "cmd" or chalao "cmd")
  if l.startsWith("$ ") or l.startsWith("shell ") or l.startsWith("chalao "):
    let cmdStr = l.replace("$ ", "").replace("shell ", "").replace("chalao ", "")
    return "discard execCmd(" & cmdStr & ")"

  l = l.replace("command(", "execCmdEx(")

  # 2. Imports & FFI
  if l.startsWith("shamil_karo ") or l.startsWith("import_karo "):
    return "import " & l.replace("shamil_karo ", "").replace("import_karo ", "")
  elif l.startsWith("c_ka_kaam "):
    let content = l.substr(10)
    if " from " in content:
      let parts = content.split(" from ")
      let header = parts[1].replace("\"", "")
      let fnDef = parts[0]
      return "proc " & fnDef & " {.importc, header: \"" & header & "\", discardable.}"
    else:
      return "proc " & content & " {.importc, discardable.}"

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

  # 6. Rigid Word Token Prefix Grammar (Strict Tokens)
  if l.startsWith("rakho "): l = "var " & l.substr(6)
  elif l.startsWith("pukka "): l = "const " & l.substr(6)
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
  elif l.startsWith("chuno "): l = "case " & l.substr(6)
  elif l.startsWith("jab "): l = "of " & l.substr(4)

  l = l.replace("pucho()", "readLine(stdin)")

  if l.startsWith("proc ") or l.startsWith("iterator "):
    if not l.endsWith("="): l.add(" =")
  elif l.startsWith("type "):
    if l.endsWith("="): l = l[0 .. ^2].strip()
    if l.endsWith("enum"): discard
  elif hasToh or l.startsWith("if ") or l.startsWith("elif ") or l == "else" or l.startsWith("while ") or l.startsWith("for ") or l == "try" or l.startsWith("except") or l == "finally" or l.startsWith("case ") or l.startsWith("of "):
    if not l.endsWith(":"): l.add(":")

  return l

proc transpileHinglish*(code: string): string =
  var lines = code.splitLines()
  var nimLines: seq[string] = @["import std/osproc"]
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
