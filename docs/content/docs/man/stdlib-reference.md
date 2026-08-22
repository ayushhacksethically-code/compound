---
title: "Standard Library Reference Specification"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Standard Library Reference Specification (`stdlib`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Integration**: Native Nim Standard Library API Ecosystem

---

## 📖 OVERVIEW & MODULE SUMMARY

The **Compound Standard Library** exposes high-performance modules for string manipulation, filesystem I/O, hash maps, math operations, subprocess automation, JSON parsing, and async networking.

---

## 📚 MODULE REFERENCE MANUAL

### 1. `std/strutils` — String Manipulation Utilities

| Function Signature | Description | Return Type |
| :--- | :--- | :--- |
| `strip(s: string): string` | Removes leading and trailing whitespace. | `string` |
| `split(s: string, sep: char/string): seq[string]` | Splits string into sequence substrings by delimiter. | `seq[string]` |
| `splitLines(s: string): seq[string]` | Splits multiline string into sequence of individual line strings. | `seq[string]` |
| `join(a: openArray[string], sep: string): string` | Concatenates array of strings separated by delimiter. | `string` |
| `replace(s: string, sub: string, by: string): string` | Replaces occurrences of substring `sub` with `by`. | `string` |
| `parseInt(s: string): int` | Parses integer number from string text. | `int` |
| `parseFloat(s: string): float64` | Parses floating-point number from string text. | `float64` |
| `toLowerAscii(s: string): string` | Converts string characters to lowercase ASCII. | `string` |
| `toUpperAscii(s: string): string` | Converts string characters to uppercase ASCII. | `string` |
| `startsWith(s: string, prefix: string): bool` | Checks if string begins with given prefix string. | `bool` |
| `endsWith(s: string, suffix: string): bool` | Checks if string ends with given suffix string. | `bool` |
| `contains(s: string, sub: string): bool` | Checks if substring exists anywhere inside string. | `bool` |

---

### 2. `std/os` — Filesystem & Operating System Interface

| Function Signature | Description | Return Type |
| :--- | :--- | :--- |
| `readFile(filename: string): string` | Reads entire file contents from disk into memory string. | `string` |
| `writeFile(filename: string, content: string)` | Overwrites target file on disk with string content. | `void` |
| `fileExists(filename: string): bool` | Checks if regular file exists on disk path. | `bool` |
| `dirExists(dirpath: string): bool` | Checks if directory exists on disk path. | `bool` |
| `createDir(dirpath: string)` | Creates directory and all necessary parent directories. | `void` |
| `removeFile(filename: string)` | Deletes regular file from filesystem. | `void` |
| `getTempDir(): string` | Returns system temporary directory path (`/tmp` on Unix). | `string` |
| `getEnv(varName: string): string` | Reads value of system environment variable. | `string` |

---

### 3. `std/tables` — Key-Value Hash Tables

| Function Signature | Description | Return Type |
| :--- | :--- | :--- |
| `initTable[K, V](): Table[K, V]` | Constructs new empty Hash Table instance. | `Table[K, V]` |
| `hasKey(t: Table[K, V], key: K): bool` | Returns `true` if key exists in table. | `bool` |
| `len(t: Table[K, V]): int` | Returns total count of key-value pairs stored in table. | `int` |
| `clear(t: var Table[K, V])` | Removes all key-value entries from table instance. | `void` |
| `del(t: var Table[K, V], key: K)` | Deletes specific key-value entry from table. | `void` |

---

### 4. `std/osproc` — Process Execution & Automation

| Function Signature | Description | Return Type |
| :--- | :--- | :--- |
| `execCmdEx(command: string): (string, int)` | Executes shell command string and returns output tuple. | `(string, int)` |
| `execCmd(command: string): int` | Executes shell command streaming output to console. | `int` |
| `quoteShell(s: string): string` | Sanitizes string for shell argument passing. | `string` |

---

### 5. `std/asyncdispatch` — Event-Loop Asynchronous I/O

| Function Signature | Description | Return Type |
| :--- | :--- | :--- |
| `waitFor[T](fut: Future[T]): T` | Blocks until async Future completes and returns result. | `T` |
| `all(futs: seq[Future[void]]): Future[void]` | Combines multiple Futures into a single completion Future. | `Future[void]` |
| `sleepAsync(ms: int): Future[void]` | Non-blocking async sleep timer. | `Future[void]` |

---

## 🧪 CODE EXAMPLES

### Comprehensive Standard Library Integration (`stdlib_demo.hg`)

```hinglish
shamil_karo std/strutils, std/os, std/tables, std/math

dikhao "=== Standard Library Test Suite ==="

// 1. Filesystem & String Manipulation
rakho temp_path = getTempDir() & "/compound_test_file.txt"
writeFile(temp_path, "Line 1: Hello\nLine 2: Compound Stdlib\nLine 3: High Performance")

agar fileExists(temp_path) toh
    rakho text = readFile(temp_path)
    rakho lines = text.splitLines()
    dikhao "Total File Lines Read:", lines.len
    removeFile(temp_path) // Cleanup file
khatam

// 2. Math Operations
dikhao "Sqrt(144) =", sqrt(144.0)
dikhao "2^8 =", pow(2.0, 8.0)
```

---

## 🔗 SEE ALSO

- **[Module Imports (`shamil_karo` / `import`)](/docs/man/shamil-import/)**: Import syntax reference.
- **[ChronoKV Engine Architecture](/docs/man/chronokv-db/)**: Database implementation leveraging standard tables and disk I/O.
