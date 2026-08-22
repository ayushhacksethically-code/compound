---
title: "Shell & PowerShell Subshell Automation"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Bash & PowerShell Subshell Automation (`$` / `chalao` / `shell` / `command`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: `discard execCmd("cmd")` & `execCmdEx("cmd")`

---

## 📖 SYNOPSIS

### 1. Fire-and-Forget Shell Command Execution
- **Hinglish (`.hg`)**: `$ "bash command"` or `chalao "bash command"`
- **English (`.eg`)**: `$ "bash command"` or `shell "bash command"`

### 2. Capturing Output & Exit Status Code (`command` / `execCmdEx`)
```hinglish
rakho (output_string, exit_code) = command("shell_command_string")
```

### 3. PowerShell Core Cmdlet Execution
- **Hinglish (`.hg`)**: `ps_kaam "pwsh cmdlet"` or `ps "pwsh cmdlet"`
- **English (`.eg`)**: `ps_command "pwsh cmdlet"` or `ps "pwsh cmdlet"`

---

## 📝 DESCRIPTION

Compound provides native primitives for embedding system shell commands (`bash`, `sh`, `zsh`, `pwsh`) directly inside `.hg` and `.eg` programs.

1. **Inline Shell Directives (`$` / `chalao` / `shell`)**: Execute shell commands as subprocesses, streaming standard output and error directly to the console.
2. **Captured Execution (`command`)**: Executes a command and captures both its stdout string and non-zero exit status code in a 2-tuple return value `(string, int)`.
3. **PowerShell Directives (`ps_kaam` / `ps_command`)**: Spawns PowerShell Core in non-interactive, profile-bypassing mode (`pwsh -NoProfile -NonInteractive -Command ...`).

---

## ⚙️ FEATURE MATRIX

| Syntax Pattern | Return Value | Transpiled Nim Target Code | Description |
| :--- | :--- | :--- | :--- |
| `$ "cmd"` | None | `discard execCmd("cmd")` | Fire-and-forget shell command |
| `chalao "cmd"` / `shell "cmd"` | None | `discard execCmd("cmd")` | Fire-and-forget shell synonym |
| `command("cmd")` | `(string, int)` | `execCmdEx("cmd")` | Captures output text and exit status code |
| `ps_kaam "cmd"` / `ps_command "cmd"` | None | `discard execCmd("pwsh ...")` | Executes PowerShell Core cmdlet |

---

## 💡 IMPLEMENTATION & SECURITY NOTES

- **String Protection**: Dynamic command strings inside quotes are protected against keyword transpilation during syntax parsing.
- **Pipes & Redirection**: Standard shell operators like pipes (`|`), input/output redirection (`>`, `>>`, `<`), and subshell expansions (`$(...)`) are fully supported within command strings.

---

## 🧪 CODE EXAMPLES

### Subprocess Automation Suite in Hinglish (`shell_suite.hg`)

```hinglish
shamil_karo std/strutils

dikhao "=== Subprocess Automation Suite ==="

// 1. Fire-and-forget shell execution with pipes and redirection
$ "mkdir -p /tmp/compound_suite && echo 'Automated Log Data' > /tmp/compound_suite/app.log"

// 2. Capture output and exit code
rakho (output, exitCode) = command("cat /tmp/compound_suite/app.log")
dikhao "Captured Command Output:", output.strip()
dikhao "Exit Status Code:", exitCode

// 3. Trapping command errors cleanly
rakho (errOutput, errCode) = command("ls /non_existent_directory_999 2>/dev/null")
agar errCode != 0 toh
    dikhao "Successfully trapped non-zero exit status code:", errCode
khatam

// 4. Invoking PowerShell Core cmdlet
ps_kaam "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"
```

---

## 🔗 SEE ALSO

- **[PowerShell Subshell Integration](/docs/man/powershell-subshell/)**: Detailed PowerShell execution guide.
- **[Standard Library Reference](/docs/man/stdlib-reference/)**: `std/osproc` module reference.
