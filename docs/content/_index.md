---
title: "Compound Language"
type: docs
---

# Compound Programming Language Documentation

Welcome to the official documentation hub for **Compound**, a compiled, dual-dialect programming language engineered for high performance, dual-dialect expressiveness, zero-cost C interoperability, and cross-platform automation.

> [!NOTE]
> Compound allows software engineers and non-technical domain specialists to write code in two native dialects: **Hinglish (`.hg`)** and **Plain English (`.eg`)**. Both dialects transpile into native C code via Nim, compiling to ELF machine binaries (via GCC/Clang) or standalone JavaScript bundles (via Node.js/Browsers).

---

## 🚀 Key User Guides

- **[Getting Started with Compound](/docs/getting-started/)**: Toolchain installation matrix, compiler architecture pipeline, CLI subcommand reference (`run`, `build`, `parse`, `js`, `js-build`, `init`, `doctor`), interactive Python-style REPL shell, and ORC memory management.
- **[Hinglish Language Guide (`.hg`)](/docs/hinglish-guide/)**: Idiomatic guide to Hinglish programming (`rakho`, `dikhao`, `agar`/`toh`/`varna`, `kaam`, `khatam`, `chuno`, `koshish_karo`, `c_ka_kaam`).
- **[English Language Guide (`.eg`)](/docs/english-guide/)**: Idiomatic guide to English programming (`keep`, `show`, `if`/`do`/`else`, `task`, `done`, `match`, `try`, `c_func`).

---

## 📚 Technical Manual Pages (`/docs/man/`)

Exhaustive Python-style reference pages for every syntax construct, memory model feature, standard library module, and automation subsystem:

| Manual Page | Covered Dialect Keywords | Focus Area |
| :--- | :--- | :--- |
| **[Conditionals & Branching](/docs/man/agar-if/)** | `agar`, `if`, `varna agar`, `otherwise if`, `varna`, `else` | Runtime condition evaluation & branch optimization |
| **[Loops & Iteration](/docs/man/jabtak-while/)** | `jabtak`, `while`, `har`, `for`, `each`, `aage_bhadho`, `roko` | Pre-condition loops, collection iteration, continue/break |
| **[Pattern Matching](/docs/man/chuno-match/)** | `chuno`, `match`, `jab`, `when`, `varna`, `otherwise` | Multi-way switch selection & C jump tables |
| **[Exception Handling](/docs/man/koshish-try/)** | `koshish_karo`, `try`, `galti_pakdo`, `catch`, `galti_phenko`, `shart_jaanch` | Runtime exceptions, assertions (`doAssert`), guaranteed finally |
| **[Variables & Scope](/docs/man/rakho-create/)** | `rakho`, `keep`, `var`, `let`, `x = v` | Variable allocation, type inference, implicit auto-declaration |
| **[Constants & Immutability](/docs/man/pukka-fixed/)** | `pukka`, `fixed`, `const` | Compile-time constants & memory folding |
| **[Types & Structs](/docs/man/banao-type/)** | `banao`, `type`, `make`, `object`, `ref object`, `enum` | Struct definition, value vs reference semantics |
| **[Data Types & Memory Model](/docs/man/types-and-structs/)** | Primitive types (`int`, `float`, `string`), `seq[T]`, `Table[K,V]` | Bit-widths, heap allocation, ORC reference counting |
| **[Functions & Subroutines](/docs/man/kaam-task/)** | `kaam`, `task`, `function`, `wapas`, `return` | Subroutines, return values, `{.discardable.}` semantics |
| **[Module Imports](/docs/man/shamil-import/)** | `shamil_karo`, `import`, `use` | Standard and local module resolution |
| **[Standard Library Reference](/docs/man/stdlib-reference/)** | `std/strutils`, `std/os`, `std/tables`, `std/math`, `std/asyncdispatch` | Function signatures, parameters, return types |
| **[C FFI Integration](/docs/man/c-ffi/)** | `c_ka_kaam`, `c_func`, `from "header.h"` | Zero-cost native C ABI binding & header inclusions |
| **[Bash & Subshell Automation](/docs/man/shell-powershell/)** | `$`, `chalao`, `shell`, `command` | Fire-and-forget subshells, output capture tuples |
| **[PowerShell Core Subshell](/docs/man/powershell-subshell/)** | `ps_kaam`, `ps_command`, `ps` | `pwsh` cmdlet execution with `quoteShell` escaping |
| **[ChronoKV Engine](/docs/man/chronokv-db/)** | `storage_put`, `storage_get`, `storage_flush_sstable` | Embedded LSM-Tree engine, SSTables, Raft consensus |
| **[Console Input & Output](/docs/man/dikhao-show/)** | `dikhao`, `show`, `print`, `pucho`, `ask` | Console printing, stdin line reading, EOF handling |
| **[VS Code Tooling](/docs/man/vscode-tooling/)** | Extensions, `.vsix`, auto-closing brackets | IDE extension installation & syntax highlighting |
