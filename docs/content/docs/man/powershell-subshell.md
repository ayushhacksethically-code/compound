---
title: "PowerShell Subshell Integration (ps_kaam / ps_command)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: PowerShell Subshell Integration (`ps_kaam` / `ps_command` / `ps`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: `discard execCmd("pwsh -NoProfile -NonInteractive -Command " & quoteShell(cmd))`

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
ps_kaam "PowerShell-Cmdlet-String"
ps "PowerShell-Cmdlet-String"
```

### English Dialect (`.eg`)
```english
ps_command "PowerShell-Cmdlet-String"
ps_shell "PowerShell-Cmdlet-String"
ps "PowerShell-Cmdlet-String"
```

---

## 📝 DESCRIPTION

The `ps_kaam` / `ps_command` directives invoke **PowerShell Core (`pwsh`)** commands directly from within Compound source programs.

When executed, the transpiler wraps the command string inside a non-interactive, profile-bypassing PowerShell invocation:
```nim
discard execCmd("pwsh -NoProfile -NonInteractive -Command " & quoteShell(cmd))
```

This guarantees that user shell profiles (`$PROFILE`) do not introduce startup delays or unexpected side-effects during automated script execution.

---

## ⚙️ SYNONYM MATRIX

| Dialect | Directives | Executed Process Invocation |
| :--- | :--- | :--- |
| **Hinglish (`.hg`)** | `ps_kaam`, `ps_command`, `ps_shell`, `ps` | `pwsh -NoProfile -NonInteractive -Command "..."` |
| **English (`.eg`)** | `ps_command`, `ps_shell`, `ps_kaam`, `ps` | `pwsh -NoProfile -NonInteractive -Command "..."` |

---

## 💡 IMPLEMENTATION & SAFETY NOTES

- **Shell Escaping (`quoteShell`)**: Command string arguments are automatically passed through Nim's `quoteShell` sanitizer, preventing shell injection vulnerabilities when interpolating dynamic variable values into script commands.
- **Cross-Platform Compatibility**: Requires `pwsh` (PowerShell Core 7+) to be installed on Linux/macOS, or standard `powershell.exe` / `pwsh.exe` on Windows hosts.

---

## 🧪 CODE EXAMPLES

### 1. Hinglish PowerShell Automation (`ps_demo.hg`)

```hinglish
dikhao "--- Querying Windows/Linux System Info via PowerShell ---"

// Execute PowerShell process pipeline
ps_kaam "Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5"

// Create structured directory using PowerShell cmdlet
ps "New-Item -ItemType Directory -Force -Path /tmp/ps_compound_output"
```

### 2. English PowerShell Automation (`ps_demo.eg`)

```english
show "--- Querying Network Adapters via PowerShell ---"

// Execute PowerShell cmdlet string
ps_command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"

// Pipe object output directly to JSON file
ps_shell "Get-Service | Where-Object Status -eq 'Running' | ConvertTo-Json | Out-File /tmp/services.json"
```

---

## 🔗 SEE ALSO

- **[Shell & PowerShell Automation Overview](/docs/man/shell-powershell/)**: Complete bash & subshell execution guide.
- **[Standard Library Reference](/docs/man/stdlib-reference/)**: Subprocess execution via `std/osproc`.
