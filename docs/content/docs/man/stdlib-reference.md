---
title: "Standard Library Reference (stdlib-reference)"
date: 2026-08-21
weight: 4
draft: false
---

# MAN PAGE: Standard Library & Built-in Modules (`stdlib-reference`)

## OVERVIEW

Compound seamlessly accesses the full ecosystem of Nim standard library modules (`std/*`). Modules are imported using `shamil_karo` (Hinglish) or `import` / `use` (English).

---

## 1. MODULE IMPORT SYNTAX

### Hinglish (`.hg`)
```hinglish
shamil_karo std/strutils
shamil_karo std/os
shamil_karo std/tables
```

### English (`.eg`)
```english
import std/strutils
import std/os
import std/tables
```

---

## 2. STANDARD MODULE REFERENCE

### A. `std/strutils` (String Processing & Parsing)
- `strip(s: string): string`: Trims leading/trailing whitespace.
- `split(s: string, sep: char): seq[string]`: Splits string into sequence by delimiter.
- `splitLines(s: string): seq[string]`: Splits string into lines.
- `join(s: seq[string], sep: string): string`: Joins sequence of strings.
- `replace(s: string, sub: string, by: string): string`: Replaces substring occurrences.
- `toLowerAscii(s: string): string` / `toUpperAscii(s: string): string`: Case conversion.
- `parseInt(s: string): int`: Converts string to integer.
- `parseFloat(s: string): float`: Converts string to floating-point number.

### B. `std/os` (FileSystem & Environment Utilities)
- `readFile(filename: string): string`: Reads entire file contents into string.
- `writeFile(filename: string, content: string)`: Writes string content to file.
- `fileExists(filename: string): bool`: Returns true if target file exists.
- `dirExists(dir: string): bool`: Returns true if target directory exists.
- `createDir(dir: string)`: Recursively creates directory path.
- `getTempDir(): string`: Returns operating system temporary folder path.
- `joinPath(parts: varargs[string]): string`: Joins path segments cleanly.
- `commandLineParams(): seq[string]`: Returns array of command-line arguments.

### C. `std/tables` (Hash Tables & Dictionaries)
- `initTable[K,V](): Table[K,V]`: Creates empty hash table.
- `toTable(pairs: openArray[(K,V)]): Table[K,V]`: Converts key-value tuple array to table.
- `hasKey(t: Table[K,V], key: K): bool`: Checks key existence.
- `clear(t: var Table[K,V])`: Clears all key-value entries.
- `len(t: Table[K,V]): int`: Returns key count.

### D. `std/math` (Mathematical Operations)
- `sin(x: float64): float64` / `cos(x: float64): float64` / `tan(x: float64): float64`: Trigonometry functions.
- `sqrt(x: float64): float64`: Square root calculation.
- `pow(base: float64, exp: float64): float64`: Power calculation ($base^{exp}$).
- `floor(x: float64): float64` / `ceil(x: float64): float64`: Rounding operations.

### E. `std/asyncdispatch` & `std/asyncnet` (Asynchronous I/O & Networking)
- `Future[T]`: Asynchronous future object type.
- `{.async.}`: Procedure annotation enabling async await semantics.
- `waitFor(f: Future[T]): T`: Synchronously waits for future resolution.
- `all(futures: seq[Future[void]])`: Resolves sequence of concurrent futures.
- `newAsyncSocket()`: Initializes non-blocking asynchronous TCP network socket.

### F. `std/times` (Benchmarking & Timers)
- `cpuTime(): float64`: High-resolution CPU timer timestamp in seconds.
- `now(): DateTime`: Returns current date and time.

---

## 3. IDIOMATIC EXAMPLE

```hinglish
shamil_karo std/strutils, std/os, std/tables, std/times

rakho start_time = cpuTime()

// File writing and reading
rakho test_file = getTempDir() / "compound_test.txt"
writeFile(test_file, "apple,banana,cherry,date")

rakho file_data = readFile(test_file)
rakho items = file_data.strip().split(',')

// Table aggregation
rakho fruit_counts = initTable[string, int]()
har item mein items toh
  fruit_counts[item] = item.len
khatam

dikhao "Parsed fruits count:", fruit_counts.len
dikhao "Benchmark completed in:", cpuTime() - start_time, "seconds"
```
