---
title: "Getting Started with Compound"
date: 2026-08-21
weight: 1
draft: false
---

# Getting Started with Compound Programming Language

> [!NOTE]
> **Compound** is a high-performance, compiled, dual-dialect programming language designed for systems engineering, web scripting, data analytics, and DevOps automation. It provides two native dialects that compile down to identical, highly optimized native C binaries or JavaScript code.

---

## 🌟 Key Highlights & Philosophy

- **Dual Native Dialects**:
  - **Hinglish (`.hg`)**: Expressive syntax using intuitive Hindi-English phonetic keywords (`rakho`, `dikhao`, `agar` / `toh` / `varna`, `kaam`, `khatam`).
  - **English (`.eg`)**: Expressive syntax using plain English keywords (`keep`, `show`, `if` / `do` / `else`, `task`, `done`).
- **Zero-Cost C Interoperability**: Direct, header-level foreign function interface (FFI) to C standard libraries (`libc`, `libm`, etc.) without wrapper overhead.
- **Deterministic ORC Memory Model**: Nim-powered Atomic Reference Counting with cycle collection—zero stop-the-world garbage collection pauses.
- **Dual Target Compilation**: Compiles via C99/C11 (GCC/Clang) for native ELF/PE binaries, or via JavaScript (`nim js`) for Node.js and web browsers.
- **Interactive Python-Style REPL**: Multi-line block detection, persistent session state, color-highlighted outputs, and built-in management commands.

---

## 🛠️ Toolchain Prerequisites & Installation

### Requirements Matrix

| Tool / Dependency | Recommended Version | Required For |
| :--- | :--- | :--- |
| **Nim Compiler** | `v1.6+` or `v2.0+` | Intermediate code transpilation engine |
| **C Compiler** | `GCC 9+` or `Clang 10+` | Native machine code binary generation |
| **Node.js** | `v14+` | Running compiled JavaScript target files (`js` / `js-run`) |
| **PowerShell** | `pwsh 7+` (Optional) | Executing `ps_kaam` / `ps_command` subshell cmdlets |

> [!IMPORTANT]
> Verify that `nim` and `gcc` (or `clang`) are installed and accessible in your system `PATH` before compiling Compound source programs. Run `compound doctor` to automatically verify system dependencies.

### Building from Source

To build the primary driver binary executable from the repository root:

```bash
nim c -d:release compound.nim
```

This generates a standalone `compound` binary. You can alias or symlink `compound` as `hg` (Hinglish driver) and `eg` (English driver):

```bash
# System-wide installation
sudo cp compound /usr/local/bin/compound
sudo ln -sf /usr/local/bin/compound /usr/local/bin/hg
sudo ln -sf /usr/local/bin/compound /usr/local/bin/eg
```

---

## ⚙️ Compilation Architecture & Pipeline

Compound translates high-level dual-dialect syntax into native binaries through a deterministic four-stage compilation pipeline:

```
┌────────────────────────────────────────────────────────┐
│  Source Code Input (.hg or .eg)                         │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼
┌────────────────────────────────────────────────────────┐
│  Stage 1: String Literal Masking & AST Lexing          │
│  - Replaces "strings" with ___COMPOUND_STR_N___        │
│  - Prevents word replacements inside text literals     │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼
┌────────────────────────────────────────────────────────┐
│  Stage 2: Grammar Transpilation & Block Alignment      │
│  - Maps dialect keywords & synonyms to Nim syntax      │
│  - Translates block openers (toh/do) & closers (khatam)│
│  - Auto-declares implicit variable assignments          │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼
┌────────────────────────────────────────────────────────┐
│  Stage 3: Intermediate Nim Code Generation             │
│  - Generates optimized .nim file                       │
│  - Emits {.importc.} C FFI definitions                 │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼
┌────────────────────────────────────────────────────────┐
│  Stage 4: C Translation & Native Compilation          │
│  - Nim transpiles .nim to ANSI C (C99/C11)             │
│  - GCC/Clang compiles C code into target native binary │
└───────────────────────────┬────────────────────────────┘
```

> [!TIP]
> Use the `parse` command (`compound parse app.hg`) to view the clean intermediate Nim code generated during Stage 3 without triggering Stage 4 native compilation.

---

## 🚀 Command-Line Interface (CLI) Guide

The `compound` CLI (and its aliases `hg` / `eg`) accepts a rich set of subcommands:

```
Usage: compound [init|doctor|run|build|js|js-build|parse|repl] <file.hg|file.eg>
```

### Subcommand Reference

#### 1. `compound run <file>`
Compiles and immediately executes the target `.hg` or `.eg` file.
```bash
hg run examples/demo.hg
eg run examples/demo_en.eg
```

#### 2. `compound build <file>`
Compiles the target program into a native binary executable in the current working directory.
```bash
hg build main.hg    # Output: ./main
eg build main.eg    # Output: ./main
```

#### 3. `compound parse <file>`
Outputs the generated intermediate Nim/C source code to `stdout` for inspection and debugging.
```bash
hg parse calc.hg
```

#### 4. `compound js <file>` (or `js-run`)
Compiles the file to JavaScript (`.js`) using `nim js` and executes it immediately via `node`.
```bash
hg js app.hg
```

#### 5. `compound js-build <file>`
Compiles the file into a standalone JavaScript bundle suitable for deployment in web browsers or serverless functions.
```bash
eg js-build web_client.eg
```

#### 6. `compound init [project_name]`
Scaffolds a new Compound project workspace with directory layout, dialect configuration, and entry file.
```bash
compound init my_app
```
**Generated Structure:**
```
my_app/
├── compound.toml
└── src/
    └── main.hg (or main.eg depending on binary invoked)
```

#### 7. `compound doctor`
Inspects system environment tools (Nim, GCC/Clang, Node.js, PowerShell) and reports toolchain health status:
```bash
$ compound doctor
🩺 Compound Toolchain Doctor
• Nim Compiler:      OK (/usr/bin/nim)
• GCC / Clang C:     OK (/usr/bin/gcc)
• Node.js (JS):      OK (/usr/bin/node)
• Compound Root:     /home/user/.compound
```

#### 8. `compound repl` (or `shell`, `-i`)
Launches the interactive Python-style REPL shell for instant experimentation.
```bash
hg repl
```

---

## 💻 Interactive REPL Shell Deep-Dive

The Compound REPL provides a interactive environment inspired by Python's IDLE:

### Key Features & Mechanics
- **Primary Prompt (`>>> `)**: Displayed when awaiting new top-level statements.
- **Multi-Line Prompt (`... `)**: Displayed when inside open blocks (`agar`, `if`, `kaam`, `task`, `jabtak`, `while`, `chuno`, `match`).
- **Block Completion**: Send a blank line (press Enter on empty prompt) or type block closers (`khatam`, `bas`, `done`, `end`) to evaluate the multi-line block.
- **State Persistence**: Declared variables, imported modules, and functions persist across command evaluations in the REPL session.

### Built-in REPL Commands

| Command (English) | Command (Hinglish) | Action |
| :--- | :--- | :--- |
| `help` | `madad` | Display REPL command cheat sheet |
| `clear` | `saaf` | Clear active REPL environment, memory, and declared variables |
| `exit` / `quit` | `bahar` | Exit the REPL session |

### Interactive REPL Session Walkthrough

```hinglish
>>> rakho naam = "Narayana"
Narayana
>>> kaam greet(n: string) toh
...   dikhao "Namaste,", n
... khatam
>>> greet(naam)
Namaste, Narayana
>>> saaf
Environment saaf kar diya gaya hai.
>>> exit
Alvida!
```

---

## 🧠 Deterministic Memory Model (ORC)

Compound uses Nim's **ORC (Optimized Reference Counting)** memory manager:

> [!NOTE]
> **Why ORC?** Traditional garbage collection introduces random "stop-the-world" latency spikes. ORC resolves allocations deterministically at compiler-inserted destructor points while managing cycles with a lightweight, asynchronous cycle collector.

- **Stack Allocation (`object`)**: Value types are allocated directly on the stack with zero heap allocation overhead.
- **Heap Allocation (`ref object`)**: Managed reference types are allocated on heap. Memory is reclaimed immediately when reference counts hit zero.
- **Nil Assignment (`khali` / `nil`)**: Reassigning a reference variable to `nil` immediately unreferences memory and releases underlying resources.

---

## 🧪 First Programs: Hello World Comparison

### Hinglish Dialect (`hello.hg`)

```hinglish
// Hello World in Hinglish (Zero imports required!)
rakho sandesh = "Namaste Compound Duniya!"
dikhao sandesh

kaam jod_do(a: int, b: int): int toh
    wapas a + b
khatam

rakho result = jod_do(15, 25)
dikhao "15 + 25 =", result
```

### English Dialect (`hello.eg`)

```english
// Hello World in English (Zero imports required!)
keep message = "Hello Compound World!"
show message

task add_numbers(a: int, b: int): int do
    return a + b
done

keep result = add_numbers(15, 25)
show "15 + 25 =", result
```

### Compilation & Output Comparison

```bash
$ hg run hello.hg
Namaste Compound Duniya!
15 + 25 = 40

$ eg run hello.eg
Hello Compound World!
15 + 25 = 40
```
