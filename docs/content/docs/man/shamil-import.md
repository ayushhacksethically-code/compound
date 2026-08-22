---
title: "shamil / import (Module Imports & Standard Library)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Module Imports & Standard Library (`shamil_karo` / `import`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: Nim `import module_name` ➔ C file/header linking

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
shamil_karo module_name
shamil_karo std/module_name
import_karo module_name
```

### English Dialect (`.eg`)
```english
import module_name
import std/module_name
use module_name
```

---

## 📝 DESCRIPTION

The `shamil_karo` / `import` / `use` keywords import built-in standard library modules, user-defined sub-modules (`.hg` or `.eg` files), and third-party Nim packages into the current program scope.

Multiple module imports can be combined in a single comma-separated statement:
```hinglish
shamil_karo os, strutils, tables, math
```

---

## ⚙️ STANDARD LIBRARY MODULE MATRIX

| Standard Module | Namespace | Primary Functions & Features |
| :--- | :--- | :--- |
| **`std/strutils`** | String Utilities | `split`, `join`, `strip`, `replace`, `parseInt`, `parseFloat`, `toLowerAscii`, `toUpperAscii` |
| **`std/os`** | Operating System | `readFile`, `writeFile`, `fileExists`, `dirExists`, `getTempDir`, `execShellCmd`, `copyFile` |
| **`std/osproc`** | Subprocess Execution | `execCmdEx`, `execCmd`, `quoteShell`, `startProcess`, `close` |
| **`std/tables`** | Data Structures | `Table[K, V]`, `initTable`, `toTable`, `hasKey`, `[]`, `[]=`, `len`, `clear` |
| **`std/math`** | Mathematics | `sin`, `cos`, `sqrt`, `pow`, `floor`, `ceil`, `round`, `ln`, `log10` |
| **`std/asyncdispatch`** | Async I/O | `Future[T]`, `{.async.}`, `waitFor`, `all`, `sleepAsync` |
| **`std/json`** | JSON Parsing | `parseJson`, `%*`, `JsonNode`, `$`, `hasKey`, `[]` |

---

## 💡 IMPLEMENTATION & MODULE RESOLUTION

- **Local Module Imports**: Importing local files (`shamil_karo my_module`) searches the local file directory for `my_module.hg`, `my_module.eg`, or `my_module.nim`.
- **Top-Level Header Transpilation**: Imported modules are prepended to the generated intermediate Nim file prior to compilation.

---

## 🧪 CODE EXAMPLES

### 1. Hinglish Module Import Demo (`import_demo.hg`)

```hinglish
// Import multiple standard library modules
shamil_karo std/strutils, std/os, std/tables

dikhao "=== Module Utilities Demo ==="

// 1. String Utilities
rakho raw_text = "   Compound Language Engine   "
dikhao "Stripped Text:", raw_text.strip()
dikhao "Uppercase:", raw_text.toUpperAscii()

// 2. Hash Table Data Structure
rakho scores = initTable[string, int]()
scores["Alice"] = 95
scores["Bob"] = 88

dikhao "Alice Score:", scores["Alice"]
```

### 2. English Async & Math Import (`import_demo.eg`)

```english
import std/math, std/json

show "=== Math & JSON Demo ==="

keep radius = 5.0
keep area = PI * (radius ** 2)
show "Circle Area with Radius 5.0:", area

// JSON Serialization
keep user_json = %*{"name": "Narayana", "active": true, "roles": ["admin", "dev"]}
show "Serialized JSON String:", $user_json
```

---

## 🔗 SEE ALSO

- **[Standard Library Reference](/docs/man/stdlib-reference/)**: Exhaustive standard library module listing.
- **[C FFI Directives](/docs/man/c-ffi/)**: Importing C header files directly.
