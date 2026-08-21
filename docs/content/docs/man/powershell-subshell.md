---
title: "powershell-subshell"
date: 2026-08-21
description: "Man page for PowerShell Subshell Automation (ps_kaam / ps_command) in Compound"
---

# `powershell-subshell` Manual Page

## NAME
**powershell-subshell** - First-class PowerShell cmdlet integration for Compound (`.hg` / `.eg`).

---

## OVERVIEW FOR EVERYONE (NON-TECH & TECH)

### Non-Technical Summary:
`powershell-subshell` allows you to directly call PowerShell cmdlets from inside your Compound code using `ps_kaam` (Hinglish) or `ps_command` (English).

### Technical Architecture:
* **Transpiler Rule**: Intercepts `ps_kaam`, `ps_command`, `ps_shell`, and `ps` prefixes.
* **Execution**: Transpiles into safe quoted PowerShell invocation (`pwsh -NoProfile -NonInteractive -Command`).

---

## SYNOPSIS

### Hinglish (`.hg`):
```hinglish
ps_kaam "Write-Host 'Namaste from PowerShell!'"
ps "Get-Date"
```

### Plain English (`.eg`):
```english
ps_command "Write-Host 'Hello from PowerShell!'"
ps "Get-Date"
```

---

## SEE ALSO
* [chronokv-db](../chronokv-db/)
* [vscode-tooling](../vscode-tooling/)
