---
title: "Manual Pages & Technical Reference"
bookCollapseSection: false
weight: 2
---

# Manual Pages & Technical Reference

> Complete technical reference manual for the Compound programming language syntaxes, memory model, compiler flags, FFI integration, and standard libraries.

---

## 📚 Technical Manual Pages

### Language Keywords & Control Flow
- **[agar / if (Conditionals & Branching)](/docs/man/agar-if/)**: `agar`, `if`, `varna agar`, `otherwise if`, `varna`, `else` conditional logic.
- **[jabtak / while (Loops & Iteration)](/docs/man/jabtak-while/)**: Pre-condition loops, collection iteration (`har`/`for`), `aage_bhadho`/`continue`, `roko`/`break`.
- **[chuno / match (Pattern Matching & Switch)](/docs/man/chuno-match/)**: Switch pattern matching (`chuno`/`match`, `jab`/`when`).
- **[koshish / try (Exception Handling & Assertions)](/docs/man/koshish-try/)**: Exception handling (`koshish_karo`/`try`, `galti_pakdo`/`catch`, `galti_phenko`/`throw`) and assertions (`shart_jaanch`/`assert`).

### Variables, Data Types & Memory
- **[rakho / keep (Variables & Scope)](/docs/man/rakho-create/)**: Declaring mutable variables (`rakho`/`keep`), implicit auto-declarations, and scope rules.
- **[pukka / fixed (Constants & Immutability)](/docs/man/pukka-fixed/)**: Declaring immutable compile-time constants (`pukka`/`fixed`).
- **[banao / type (Custom Types & Structs)](/docs/man/banao-type/)**: Value structs (`object`), heap references (`ref object`), and enumerations (`enum`).
- **[types-and-structs (Data Types & Memory Model)](/docs/man/types-and-structs/)**: Primitive bit-widths, sequence arrays, tables, and deterministic ORC memory management.

### Subroutines, Modules & FFI
- **[kaam / task (Functions & Subroutines)](/docs/man/kaam-task/)**: Subroutine definitions (`kaam`/`task`), return values (`wapas`/`return`), and `{.discardable.}` semantics.
- **[shamil / import (Module Imports)](/docs/man/shamil-import/)**: Importing modules (`shamil_karo`/`import`) and namespace resolution.
- **[stdlib-reference (Standard Library Specification)](/docs/man/stdlib-reference/)**: Exhaustive reference for `std/strutils`, `std/os`, `std/tables`, `std/math`, `std/asyncdispatch`.
- **[c-ffi (C Foreign Function Interface)](/docs/man/c-ffi/)**: Binding C standard library routines (`c_ka_kaam`/`c_func`) with zero binding overhead.

### Subprocess Automation & Embedded Storage
- **[shell-powershell (Bash & Shell Automation)](/docs/man/shell-powershell/)**: Subprocess CLI execution (`$`, `chalao`, `command`) and exit code trapping.
- **[powershell-subshell (PowerShell Core Integration)](/docs/man/powershell-subshell/)**: Executing PowerShell cmdlets (`ps_kaam`, `ps_command`) via non-interactive subshells.
- **[chronokv-db (ChronoKV LSM-Tree Storage Engine)](/docs/man/chronokv-db/)**: Production LSM-Tree MemTable, SSTables, and Raft consensus distributed storage.
- **[dikhao / show (Console Input & Output)](/docs/man/dikhao-show/)**: Standard output printing (`dikhao`/`show`) and input reading (`pucho`/`ask`).

### IDE Tooling
- **[vscode-tooling (VS Code Extension & Syntax Highlighting)](/docs/man/vscode-tooling/)**: Installing `.vsix` extension package for syntax highlighting and auto-closing block alignment.

### 🔬 Experimental & Staging Features
- **[Borrow Checker & Staging Features [UNSTABLE / STAGING]](/docs/man/borrow-checker-unstable/)**: Opt-in Borrow Checker (`pukka kaam`/`strict task`), Explicit Move Semantics (`chala_gaya`/`moved`), Sum-Types (`MilGaya`/`Some`, `Sahi`/`Ok`), and Native Monolithic Test Harness (`tests/monolith_runner.hg`).

