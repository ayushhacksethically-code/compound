---
title: "Getting Started with Compound"
date: 2026-08-21
weight: 1
draft: false
---

# Getting Started with Compound Programming Language

**Compound** is a compiled, dual-dialect programming language designed for ultimate clarity, high performance, and rapid systems engineering. It allows developers to write code in two native dialects:

- **Hinglish (`.hg`)**: Program using natural Hindi and English phonetics (`rakho`, `dikhao`, `agar/toh/varna`, `kaam`, `khatam`).
- **English (`.eg`)**: Program using clean, expressive plain English (`keep`, `show`, `if/do/else`, `task`, `done`).

Both dialects compile directly into optimized **Nim intermediate code**, which compiles to pure **C code**, and finally into a **native machine binary** via GCC or Clang.

---

## 🛠️ Toolchain Installation & Setup

The standard Compound toolchain provides two main command-line drivers: `hg` (Hinglish compiler CLI) and `eg` (English compiler CLI).

### Environment Requirements
- **Nim Compiler**: `nim` (v1.6+ or v2.0+)
- **C Compiler**: `gcc` or `clang`
- **PowerShell (Optional for PS Cmdlets)**: `pwsh`

### Building the Compiler Binaries
In the root directory of the repository, build the primary driver compiler executable:

```bash
nim c -d:release compound.nim
```

You can alias or symlink `compound` as `hg` and `eg`:
```bash
ln -sf /path/to/compound /usr/local/bin/hg
ln -sf /path/to/compound /usr/local/bin/eg
```

---

## ⚡ Execution Pipeline & Compiler Architecture

Compound uses a 4-stage compilation pipeline:

```
[ .hg / .eg Source File ]
          │
          ▼
┌───────────────────────────┐
│ Compound Lexer/Transpiler │  (hinglish.nim / english.nim)
└─────────┬─────────────────┘
          │ (Generates Nim AST / Source)
          ▼
┌───────────────────────────┐
│ Nim Compiler Core         │  (nim c -r / -d:release)
└─────────┬─────────────────┘
          │ (Transpiles to C code)
          ▼
┌───────────────────────────┐
│ C Compiler Engine         │  (GCC / Clang)
└─────────┬─────────────────┘
          │
          ▼
[ Native Binary Executable ]
```

1. **Source Parsing**: The `.hg` or `.eg` code is parsed line-by-line. String literals are masked to preserve internal formatting.
2. **Grammar Transpilation**: Dialect keywords, operator synonyms, block openers (`toh`/`do`), and closers (`khatam`/`done`) are mapped directly to clean Nim syntax.
3. **C Code Generation**: The generated `.nim` file is fed into the Nim compiler engine, producing high-performance C source files.
4. **Native Compilation**: GCC/Clang compiles the C source code into a standalone binary.

---

## 🚀 CLI Commands & Driver Flags

Both `hg` and `eg` CLIs support identical flags and subcommands:

### 1. Execute Code Immediately (`run`)
Compiles and executes the program in a single step:
```bash
hg run program.hg
eg run program.eg
```

### 2. Build Native Binary (`build`)
Compiles the program into a standalone executable binary in the current directory:
```bash
hg build program.hg
eg build program.eg
```

### 3. View Transpiled Nim Code (`parse`)
Inspects the generated intermediate Nim/C source code without building binary output:
```bash
hg parse program.hg
eg parse program.eg
```

### 4. Compile & Run JavaScript (`js` / `js-run`)
Compiles `.hg` or `.eg` code directly to JavaScript via `nim js` and executes it immediately using Node.js:
```bash
hg js program.hg
eg js program.eg
```

### 5. Build Standalone JavaScript File (`js-build`)
Compiles `.hg` or `.eg` code into a standalone `.js` file suitable for web browsers or Node.js backends:
```bash
hg js-build program.hg
eg js-build program.eg
```

### 6. Interactive REPL Shell (`shell` / `repl` / `-i`)
Launches the interactive Python-style REPL shell:
```bash
hg shell
eg repl
```

---

## 💻 Interactive REPL Shell Features

The Compound REPL shell provides an intuitive environment for rapid experimentation:

- **Python-Style Prompts**: Primary prompt `>>> ` for top-level statements; multi-line prompt `... ` inside indentation blocks.
- **Automatic Block Management**: Entering block statements (`agar`, `if`, `kaam`, `task`, `jabtak`, `while`) automatically switches to multi-line mode with auto-indentation.
- **Block Execution**: Complete a block by entering `khatam`, `bas`, `done`, `end`, or pressing **Enter** on an empty line.
- **REPL Commands**:
  - `help` / `madad`: Displays the REPL command cheat sheet.
  - `clear` / `saaf`: Clears variable memory and resets persistent state.
  - `exit` / `quit` / `bahar`: Quits the interactive shell.

---

## 🧠 Deterministic ORC Memory Management

Compound leverages Nim's **ORC (Optimized Reference Counting)** deterministic memory management system:

- **Zero Garbage Collection Pauses**: Memory allocation and deallocation happen deterministically at scope boundaries without stop-the-world pauses.
- **Cyclic Structure Handling**: ORC includes a fast cycle collector for handling complex graph and reference cycles safely.
- **Value vs Reference Types**:
  - `object` types are allocated on the stack (value semantics, zero heap overhead).
  - `ref object` types are heap-allocated managed references with automated cleanup when no longer referenced.
- **Explicit Memory Release**: Setting a heap pointer to `nil` immediately unreferences memory for deterministic destruction.
