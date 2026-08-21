# COMPOUND PROGRAMMING LANGUAGE SPECIFICATION & CHEAT SHEET

> **Version**: 1.0.0  
> **Status**: Production Specification  
> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Target Execution Backend**: Nim 1.6+ / 2.0+ ➔ C99/C11 (GCC/Clang) ➔ Native Machine Binary  
> **Memory Model**: Deterministic ORC (Atomic Reference Counting + Cycle Collector)

---

## 📋 TABLE OF CONTENTS
1. [Language Architecture Overview](#1-language-architecture-overview)
2. [Master Keyword Comparison Matrix](#2-master-keyword-comparison-matrix)
3. [Lexical Structure & Transpilation Pipeline](#3-lexical-structure--transpilation-pipeline)
4. [Variables, Data Types & Memory Semantics](#4-variables-data-types--memory-semantics)
5. [Control Flow & Block Mechanics](#5-control-flow--block-mechanics)
6. [Functions & Subroutines (`kaam` / `task`)](#6-functions--subroutines-kaam--task)
7. [Custom Types & Data Structures (`banao` / `type`)](#7-custom-types--data-structures-banao--type)
8. [Pattern Matching & Multi-Branching (`chuno` / `match`)](#8-pattern-matching--multi-branching-chuno--match)
9. [Exception Handling & Assertions](#9-exception-handling--assertions)
10. [Foreign Function Interface (C FFI)](#10-foreign-function-interface-c-ffi)
11. [Shell & PowerShell Subshell Integration](#11-shell--powershell-subshell-integration)
12. [Interactive REPL Specification](#12-interactive-repl-specification)
13. [Standard Library Reference & Module Import](#13-standard-library-reference--module-import)

---

## 1. LANGUAGE ARCHITECTURE OVERVIEW

The **Compound Programming Language** is designed to provide ultra-low barrier-to-entry programming via dual intuitive dialects—**Hinglish (`.hg`)** and **Plain English (`.eg`)**—without sacrificing native C execution speed, strict type safety, or zero-cost C library interoperability.

### Transpilation & Build Engine

```
[ .hg / .eg Source Code ]
           │
           ▼
  ┌─────────────────┐
  │  String Masking │  (Preserves string literals & escape sequences)
  └────────┬────────┘
           │
           ▼
  ┌─────────────────┐
  │ Dialect Lexer & │  (hinglish.nim / english.nim)
  │ Grammar Transpiler│
  └────────┬────────┘
           │
           ▼
  ┌─────────────────┐
  │ Nim Intermediate│  (Generated .nim source file)
  │ Code Generator  │
  └────────┬────────┘
           │
           ▼
  ┌─────────────────┐
  │ Nim Compiler    │  (nim c -r / -d:release)
  └────────┬────────┘
           │
           ▼
  ┌─────────────────┐
  │ C Compiler (GCC)│  (Translates to C99 and compiles native machine binary)
  └────────┬────────┘
           │
           ▼
[ Native Machine Executable ]
```

---

## 2. MASTER KEYWORD COMPARISON MATRIX

| Construct / Feature | Hinglish Keyword (`.hg`) | English Keyword (`.eg`) | Nim/C Backend Representation |
| :--- | :--- | :--- | :--- |
| **Variable Declaration** | `rakho x = v` | `keep x = v` / `var x = v` | `var x = v` |
| **Implicit Var Assign** | `x = v` | `x = v` | `var x = v` |
| **Constant Declaration** | `pukka K = v` | `fixed K = v` / `const K = v` | `const K = v` |
| **Type Definition** | `banao T = object` | `type T = object` / `make T` | `type T = object` |
| **Console Output** | `dikhao arg1, arg2` | `show arg1, arg2` / `print` | `echo arg1, arg2` |
| **Console Input** | `pucho()` | `ask()` / `input()` | `readLine(stdin)` |
| **If Branch** | `agar <cond> toh` | `if <cond> do` | `if <cond>:` |
| **Elif Branch** | `varna agar <cond> toh` | `otherwise if <cond> do` | `elif <cond>:` |
| **Else Branch** | `varna` / `varna toh` | `else` / `otherwise` | `else:` |
| **While Loop** | `jabtak <cond> toh` | `while <cond> do` | `while <cond>:` |
| **For Loop** | `har x mein container toh` | `for x in container do` | `for x in container:` |
| **Block Terminator** | `khatam` / `bas` | `done` / `end` | Indentation un-indent |
| **Function / Task** | `kaam fn(args): T toh` | `task fn(args): T do` | `proc fn(args): T {.discardable.} =` |
| **Return Statement** | `wapas expr` | `return expr` | `return expr` |
| **Loop Continue** | `aage_bhadho` / `jaari_rakho`| `continue` / `skip` | `continue` |
| **Loop Break** | `roko` / `tod_do` | `break` / `stop` | `break` |
| **Discard Expression** | `chhod_do` / `kuch_nahi` | `pass` / `nothing` | `discard` |
| **Match / Case Switch**| `chuno expr toh` / `jab v` | `match expr do` / `when v` | `case expr` / `of v:` |
| **Try Block** | `koshish_karo toh` | `try do` | `try:` |
| **Catch Block** | `galti_pakdo toh` | `catch do` / `except` | `except:` |
| **Finally Block** | `aakhir_mein toh` | `finally do` | `finally:` |
| **Raise Exception** | `galti_phenko msg` | `throw msg` / `raise msg` | `raise newException(ValueError, msg)` |
| **Runtime Assertion** | `shart_jaanch cond` | `assert cond` | `doAssert cond` |
| **Module Import** | `shamil_karo mod` | `import mod` / `use mod` | `import mod` |
| **C FFI Function** | `c_ka_kaam fn from "h.h"`| `c_func fn from "h.h"` | `proc fn {.importc, header: "h.h".}` |
| **Bash Command** | `$ "cmd"` / `chalao` | `$ "cmd"` / `shell` | `discard execCmd("cmd")` |
| **PowerShell Command** | `ps_kaam "cmd"` / `ps` | `ps_command "cmd"` / `ps` | `discard execCmd("pwsh ...")` |
| **Boolean True** | `sahi` | `true` / `yes` | `true` |
| **Boolean False** | `galat` | `false` / `no` | `false` |
| **Nil / Null Pointer** | `khali` | `nil` / `none` / `empty` | `nil` |
| **Logical AND** | `aur` | `and` | `and` |
| **Logical OR** | `ya` | `or` | `or` |
| **Logical NOT** | `nahi` | `not` | `not` |

---

## 3. LEXICAL STRUCTURE & TRANSPILATION PIPELINE

### String Literal Protection Mechanism
During transpilation, string literals inside quotes (`"..."` and `'...'`) are replaced with unique internal placeholders (`___COMPOUND_STR_N___`) prior to operator substitution. This prevents keywords inside text strings (such as `"aur"`, `"or"`, `"if"`) from being altered. String contents are restored seamlessly after grammar processing.

### Auto-Variable Declaration Rule
When an assignment expression `name = expression` is encountered without an explicit `rakho`/`keep`/`var`/`const` modifier, the transpiler checks if `name` has been previously declared. If undeclared, the transpiler automatically prepends `var ` to transform it into a valid declaration.

---

## 4. VARIABLES, DATA TYPES & MEMORY SEMANTICS

### Basic Types
- `int`, `int8`, `int16`, `int32`, `int64`
- `uint`, `uint8`, `uint16`, `uint32`, `uint64`
- `float`, `float32`, `float64`
- `string`, `char`, `bool` (`sahi`/`galat`, `true`/`false`)

### Deterministic ORC Memory Engine
Compound relies on Nim's **ORC memory management model**:
1. **Value Semantics (`object`)**: Allocated directly on stack or inline within parent object. Copied by value. Zero heap overhead.
2. **Reference Semantics (`ref object`)**: Allocated on heap. Managed via atomic reference counts with automatic cyclic structure collection.
3. **Explicit Memory Release**: Assigning `nil` (`khali`) to a reference handle immediately decrements reference count and triggers immediate memory deallocation.

---

## 5. CONTROL FLOW & BLOCK MECHANICS

### Block Openers & Closers
- **Openers**: Block-opening keywords (`agar`, `if`, `varna agar`, `otherwise if`, `jabtak`, `while`, `kaam`, `task`, `chuno`, `match`, `koshish_karo`, `try`) optionally end with `toh` (Hinglish) or `do` (English).
- **Closers**: Explicit block terminators `khatam` / `bas` (Hinglish) or `done` / `end` (English) decrement the active indentation block level.

---

## 6. FUNCTIONS & SUBROUTINES (`kaam` / `task`)

Functions are declared using `kaam` or `task`. Procedures return values using `wapas` or `return`.

```hinglish
kaam add_values(x: int, y: int): int toh
  wapas x + y
khatam
```

```english
task add_values(x: int, y: int): int do
  return x + y
done
```

By default, procedures are transpiled with `{.discardable.}` annotations, allowing callers to invoke functions for side effects without explicitly discarding return values.

---

## 7. CUSTOM TYPES & DATA STRUCTURES (`banao` / `type`)

Custom data types are declared using `banao` or `type`/`make`:

```hinglish
banao UserProfile = object
  id: int
  username: string
  is_admin: bool
khatam

rakho u1 = UserProfile(id: 1, username: "admin", is_admin: true)
```

---

## 8. PATTERN MATCHING & MULTI-BRANCHING (`chuno` / `match`)

```hinglish
chuno response_code toh
  jab 200 toh
    dikhao "Success"
  jab 404 toh
    dikhao "Not Found"
  varna toh
    dikhao "Unknown Error"
khatam
```

---

## 9. EXCEPTION HANDLING & ASSERTIONS

```hinglish
koshish_karo toh
  shart_jaanch balance >= 0
  agar balance == 0 toh
    galti_phenko "Zero balance error"
  khatam
galti_pakdo toh
  dikhao "Caught runtime exception"
aakhir_mein toh
  dikhao "Completed transaction attempt"
khatam
```

---

## 10. FOREIGN FUNCTION INTERFACE (C FFI)

Bind C procedures directly using `c_ka_kaam` or `c_func`:

```hinglish
c_ka_kaam puts(s: cstring): cint from "stdio.h"
c_ka_kaam sqrt(x: cdouble): cdouble from "math.h"

puts("Hello C World from Compound!")
dikhao "Sqrt(16.0) =", sqrt(16.0)
```

---

## 11. SHELL & POWERSHELL SUBSHELL INTEGRATION

Execute shell commands directly:
- **Bash**: `$ "echo 'Hello' > /tmp/out.txt"`
- **PowerShell**: `ps_kaam "Get-Date"` or `ps "Get-Process"`

---

## 12. INTERACTIVE REPL SPECIFICATION

The interactive REPL shell driver supports:
- `>>> ` primary prompt and `... ` multi-line prompt.
- Memory state persistence across single-line statements.
- System commands: `help` / `madad`, `clear` / `saaf`, `exit` / `quit` / `bahar`.

---

## 13. STANDARD LIBRARY REFERENCE & MODULE IMPORT

Import standard modules using `shamil_karo` or `import`:
- `std/strutils`: String manipulation (`split`, `join`, `strip`, `replace`, `parseInt`).
- `std/os`: File and OS interaction (`readFile`, `writeFile`, `fileExists`, `getTempDir`).
- `std/tables`: Hash map data structures (`Table`, `initTable`, `toTable`, `hasKey`).
- `std/math`: Mathematical operations (`sin`, `cos`, `sqrt`, `pow`, `floor`).
- `std/asyncdispatch`: Asynchronous I/O (`Future[T]`, `{.async.}`, `waitFor`, `all`).

---

## 14. JAVASCRIPT TARGET ENGINE & WEB SUITE

Compound compiles `.hg` and `.eg` directly to JavaScript using `nim js`:
- `hg js <file.hg>` / `eg js <file.eg>`: Compiles to `.js` and executes with Node.js / JS runtime.
- `hg js-build <file.hg>` / `eg js-build <file.eg>`: Generates standalone `.js` for web browsers.

### Verified JavaScript Target Suite (`js_suite/`):
1. **`j01_sph_fluid.hg`**: SPH Fluid Simulation (10,000 particle array step).
2. **`j02_nes_emulator.hg`**: NES 6502 CPU Bitwise Execution & Instruction Decoder.
3. **`j03_chronokv_playground.hg`**: ChronoKV In-Memory Web Playground & MemTable.
4. **`j04_raft_visualizer.hg`**: Raft Consensus State Machine Visualizer Engine.
5. **`j05_crypto_sha256.hg`**: Pure SHA-256 32-bit Bitwise Shift Cryptographic Suite.
6. **`j06_markdown_repl.hg`**: Live Markdown & Compound AST Parser.
7. **`j07_websocket_canvas.hg`**: Real-Time WebSocket Whiteboard Protocol Packer.
8. **`j08_raytracer_workers.hg`**: Ray Tracing Vector Math & Sphere Intersection Engine.
9. **`j09_bytecode_vm.hg`**: Bytecode Virtual Machine & Stack Evaluator.
10. **`j10_astar_pathfinding.hg`**: A* Pathfinding Grid Search Heuristic Engine.

