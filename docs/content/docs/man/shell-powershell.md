---
title: "Shell & PowerShell Subshell Automation (shell-powershell)"
date: 2026-08-21
weight: 2
draft: false
---

# MAN PAGE: Shell & PowerShell Automation (`shell-powershell`)

## SYNOPSIS
- **Bash Execution**: `$ "cmd"` | `chalao "cmd"` | `shell "cmd"` | `command("cmd")`
- **PowerShell Execution**: `ps_kaam "cmd"` | `ps "cmd"` | `ps_command "cmd"` | `ps_shell "cmd"`

---

## DESCRIPTION

Compound provides first-class, built-in shell automation primitives. Developers can execute Linux Bash pipelines or cross-platform PowerShell (`pwsh`) cmdlets directly inline without creating boilerplate subprocess handles.

---

## 1. BASH & SYSTEM COMMAND EXECUTION

### Inline Shell Execution (`$` / `chalao` / `shell`)
Appends the target string into a subshell process for background/direct execution.

#### Hinglish (`.hg`):
```hinglish
$ "mkdir -p /tmp/build_artifacts"
chalao "echo 'Build successful' > /tmp/build_artifacts/status.txt"
```

#### English (`.eg`):
```english
$ "mkdir -p /tmp/build_artifacts"
shell "echo 'Build successful' > /tmp/build_artifacts/status.txt"
```

### Capturing Subprocess Output & Exit Codes (`command(...)`)
Returns a tuple `(output: string, exitCode: int)` for trapping command output and status codes.

```hinglish
shamil_karo std/strutils

rakho (output, exitCode) = command("cat /tmp/build_artifacts/status.txt")
agar exitCode == 0 toh
  dikhao "Captured Output:", output.strip()
khatam
```

---

## 2. POWERSHELL CMDLET INTEGRATION (`ps_kaam` / `ps_command` / `ps`)

PowerShell integration transpiles lines prefixed with `ps_kaam`, `ps_command`, or `ps` directly into safe invocation strings using `pwsh -NoProfile -NonInteractive -Command ...`.

### Hinglish (`.hg`):
```hinglish
ps_kaam "Get-Process | Where-Object WorkingSet -gt 50000000"
ps "Write-Host 'PowerShell cmdlet executed cleanly!' -ForegroundColor Green"
```

### English (`.eg`):
```english
ps_command "Get-Process | Where-Object WorkingSet -gt 50000000"
ps "Write-Host 'PowerShell cmdlet executed cleanly!' -ForegroundColor Green"
```

---

## 3. ASYNC SUBPROCESS CONCURRENCY

Executing multiple subprocess operations concurrently using `asyncdispatch`:

```hinglish
shamil_karo std/asyncdispatch
shamil_karo std/osproc

kaam runAsyncJob(id: int): Future[void] {.async.} =
  let (res, code) = execCmdEx("echo 'Proc " & $id & " complete'")
  discard res
khatam

rakho pool = newSeq[Future[void]]()
har i mein 1 .. 10 toh
  pool.add(runAsyncJob(i))
khatam
waitFor(all(pool))
dikhao "All 10 parallel background jobs completed successfully!"
```
