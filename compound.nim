import std/[strutils, os, osproc, terminal]
import hinglish
import english

type LanguageMode = enum
  langHinglish, langEnglish

# ANSI Color Helpers
proc colorPrompt(text: string): string =
  return ansiStyleCode(styleBright) & ansiForegroundColorCode(fgCyan) & text & ansiResetCode

proc colorMultiPrompt(text: string): string =
  return ansiStyleCode(styleBright) & ansiForegroundColorCode(fgYellow) & text & ansiResetCode

proc colorResult(text: string): string =
  return ansiForegroundColorCode(fgGreen) & text & ansiResetCode

proc colorError(text: string): string =
  return ansiStyleCode(styleBright) & ansiForegroundColorCode(fgRed) & text & ansiResetCode

proc runRepl(mode: LanguageMode) =
  let isColor = isatty(stdout)

  if mode == langHinglish:
    styledEcho(fgCyan, styleBright, "=== Compound Interactive REPL Shell (Hinglish - hg) ===")
    styledEcho(fgWhite, "• Python-style prompts (>>> & ...), auto-indentation, and color support.")
    styledEcho(fgWhite, "• Block poora hone ke baad khali Enter (blank line) dabayein execution ke liye.")
    styledEcho(fgWhite, "• Help/Commands: 'help' ya 'madad' | Exit: 'exit' ya 'bahar'\n")
  else:
    styledEcho(fgCyan, styleBright, "=== Compound Interactive REPL Shell (English - eg) ===")
    styledEcho(fgWhite, "• Python-style prompts (>>> & ...), auto-indentation, and color support.")
    styledEcho(fgWhite, "• Press a blank Enter line to complete and execute a multi-line block.")
    styledEcho(fgWhite, "• Help/Commands: 'help' | Exit: 'exit' or 'quit'\n")

  var persistentCode: seq[string] = @[]
  var currentBlockLines: seq[string] = @[]
  var inMultiLineBlock = false
  var indentLevel = 0

  while true:
    var pStr = ""
    if not inMultiLineBlock:
      pStr = ">>> "
      if isColor: pStr = colorPrompt(pStr)
    else:
      pStr = "... "
      if isColor: pStr = colorMultiPrompt(pStr)

    stdout.write(pStr)
    stdout.flushFile()

    var line = ""
    try:
      line = readLine(stdin)
    except EOFError:
      echo ""
      break

    let trimmed = line.strip()

    if not inMultiLineBlock:
      if trimmed == "exit" or trimmed == "quit" or trimmed == "bahar":
        if isColor: styledEcho(fgYellow, if mode == langHinglish: "Alvida!" else: "Goodbye!")
        else: echo if mode == langHinglish: "Alvida!" else: "Goodbye!"
        break
      elif trimmed == "saaf" or trimmed == "clear":
        persistentCode.setLen(0)
        currentBlockLines.setLen(0)
        indentLevel = 0
        if isColor: styledEcho(fgGreen, if mode == langHinglish: "Environment saaf kar diya gaya hai." else: "Environment cleared.")
        else: echo if mode == langHinglish: "Environment saaf kar diya gaya hai." else: "Environment cleared."
        continue
      elif trimmed == "madad" or trimmed == "help":
        echo "\n--- REPL Shell Commands ---"
        echo "  help / madad : Show this help message"
        echo "  clear / saaf : Reset REPL variables & state memory"
        echo "  exit / bahar : Exit REPL interactive shell"
        echo "---------------------------\n"
        continue
      elif trimmed.len == 0:
        continue

    # Block opening checks
    let opensBlock = trimmed.startsWith("agar ") or trimmed.startsWith("if ") or
                      trimmed.startsWith("jabtak ") or trimmed.startsWith("while ") or trimmed.startsWith("repeat ") or
                      trimmed.startsWith("kaam ") or trimmed.startsWith("task ") or trimmed.startsWith("function ") or
                      trimmed.startsWith("chuno ") or trimmed.startsWith("match ") or trimmed.startsWith("koshish_karo") or trimmed.startsWith("try") or
                      trimmed.endsWith(":") or trimmed.endsWith(" toh") or trimmed.endsWith(" do")

    if opensBlock and not inMultiLineBlock:
      inMultiLineBlock = true
      indentLevel = 1
      currentBlockLines.add(line)
      continue

    if inMultiLineBlock:
      # Block closure keyword OR blank Enter line triggers multi-line block execution
      if trimmed.len == 0 or trimmed == "khatam" or trimmed == "bas" or trimmed == "done" or trimmed == "end":
        if trimmed.len > 0:
          currentBlockLines.add(line)
        inMultiLineBlock = false
        indentLevel = 0
        
        let blockText = currentBlockLines.join("\n")
        currentBlockLines.setLen(0)

        let sessionSource = (persistentCode & @[blockText]).join("\n")
        let nimCode = if mode == langEnglish: transpileEnglish(sessionSource) else: transpileHinglish(sessionSource)

        let tempNim = getTempDir() / "compound_repl_session.nim"
        writeFile(tempNim, nimCode)

        let (output, exitCode) = execCmdEx("nim c -r --hints:off --warnings:off " & tempNim)
        if exitCode != 0:
          let errLine = output.strip().splitLines()[^1]
          let errMsg = if mode == langHinglish: "Galti: " & errLine else: "Error: " & errLine
          if isColor: styledEcho(fgRed, styleBright, errMsg) else: echo errMsg
        else:
          persistentCode.add(blockText)
          let resLines = output.splitLines()
          for l in resLines:
            if l.strip().len > 0 and not l.contains("[Exec]"):
              if isColor: styledEcho(fgGreen, styleBright, l) else: echo l
        continue
      else:
        # Increase or decrease auto-indentation level based on inner block keywords
        if trimmed.endsWith(":") or trimmed.endsWith(" do") or trimmed.endsWith(" toh") or trimmed.startsWith("else:") or trimmed.startsWith("otherwise"):
          inc indentLevel
        currentBlockLines.add(line)
        continue

    # Single Line Execution
    let sessionSource = (persistentCode & @[line]).join("\n")
    let nimCode = if mode == langEnglish: transpileEnglish(sessionSource) else: transpileHinglish(sessionSource)

    let tempNim = getTempDir() / "compound_repl_session.nim"
    writeFile(tempNim, nimCode)

    let (output, exitCode) = execCmdEx("nim c -r --hints:off --warnings:off " & tempNim)

    if exitCode != 0:
      let errLine = output.strip().splitLines()[^1]
      let errMsg = if mode == langHinglish: "Galti: " & errLine else: "Error: " & errLine
      if isColor: styledEcho(fgRed, styleBright, errMsg) else: echo errMsg
    else:
      persistentCode.add(line)
      let resLines = output.splitLines()
      for l in resLines:
        if l.strip().len > 0 and not l.contains("[Exec]"):
          if isColor: styledEcho(fgGreen, styleBright, l) else: echo l

proc main() =
  var args = commandLineParams()
  let binaryName = extractFilename(paramStr(0))
  var defaultMode = langHinglish
  if binaryName.toLowerAscii().startsWith("eg") or (args.len > 1 and args[1].endsWith(".eg")):
    defaultMode = langEnglish

  if args.len == 0:
    runRepl(defaultMode)
    quit(0)

  let command = args[0]
  if command == "repl" or command == "shell" or command == "-i":
    runRepl(defaultMode)
    quit(0)

  if args.len < 2:
    echo "Usage: hg / eg [run|build|parse|repl] <file.hg|file.eg>"
    quit(1)

  let filename = args[1]
  if not fileExists(filename):
    if defaultMode == langHinglish:
      echo "Galti: File '", filename, "' nahi mili!"
    else:
      echo "Error: File '", filename, "' not found!"
    quit(1)

  let sourceCode = readFile(filename)
  var nimCode = if defaultMode == langEnglish: transpileEnglish(sourceCode) else: transpileHinglish(sourceCode)

  case command
  of "parse":
    echo "=== Generated Nim / C Code ==="
    echo nimCode
    echo "=============================="

  of "run", "build":
    let targetNimFile = filename.changeFileExt("nim")
    writeFile(targetNimFile, nimCode)

    var compileCmd = "nim c "
    if command == "run":
      compileCmd.add("-r ")
    compileCmd.add(targetNimFile)

    let (output, exitCode) = execCmdEx(compileCmd)
    if exitCode != 0:
      let lines = output.strip().splitLines()
      var userErrorLine = ""
      for l in lines:
        if l.contains("Error:") or l.contains("Galti:"):
          userErrorLine = l
          break
      if userErrorLine.len == 0 and lines.len > 0:
        userErrorLine = lines[^1]
      
      let formattedErr = userErrorLine.replace(targetNimFile, filename)
      if defaultMode == langHinglish:
        echo "Galti: ", formattedErr
      else:
        echo "Error: ", formattedErr
      quit(exitCode)
    else:
      if command == "run":
        let lines = output.splitLines()
        var printOutput = false
        for l in lines:
          if l.contains("[Exec]"):
            printOutput = true
            continue
          if printOutput:
            echo l

  else:
    echo "Unknown command: ", command

when isMainModule:
  main()
