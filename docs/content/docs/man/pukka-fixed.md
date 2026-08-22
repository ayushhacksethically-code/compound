---
title: "pukka / fixed (Constants & Immutability)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Constants & Immutability (`pukka` / `fixed` / `const`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: Nim `const K = value` ➔ C `#define` or immutable C `const` global/stack variable

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
pukka CONSTANT_NAME = compile_time_expression
```

### English Dialect (`.eg`)
```english
fixed CONSTANT_NAME = compile_time_expression
const CONSTANT_NAME = compile_time_expression
```

---

## 📝 DESCRIPTION

The `pukka` / `fixed` / `const` keywords declare **immutable compile-time constants**.

Once declared, constant values cannot be reassigned or mutated. Constant expressions are evaluated at compile time by the Nim compiler engine, enabling dead-code elimination, loop unrolling, and pre-computed lookups.

---

## ⚙️ SYNONYM MATRIX

| Dialect | Primary Keyword | Allowed Synonyms | Target Transpiled Nim Syntax |
| :--- | :--- | :--- | :--- |
| **Hinglish (`.hg`)** | `pukka` | `const` | `const K = v` |
| **English (`.eg`)** | `fixed` | `const` | `const K = v` |

---

## 💡 IMPLEMENTATION & PERFORMANCE NOTES

- **Compile-Time Evaluation**: Complex mathematical expressions, string formatting, or compile-time function calls (`const FOO = compute()") are pre-calculated during Stage 3 compilation.
- **Zero Memory Overhead**: Primitive constants (`int`, `float`, `bool`) are folded directly into assembly instruction operands, incurring zero RAM allocation overhead.

---

## ⚠️ EDGE CASES & MUTABILITY RESTRICTIONS

> [!WARNING]
> **Reassignment Rejection**: Attempting to assign a new value to a `pukka` or `fixed` constant (e.g. `MAX_USERS = 2000`) results in a compile-time error (`Error: cannot modify constant`).

---

## 🧪 CODE EXAMPLES

### 1. Hinglish Constant Declarations (`constant_demo.hg`)

```hinglish
// Global compile-time constants
pukka MAX_CONNECTIONS = 5000
pukka APPLICATION_NAME = "ChronoKV Production Cluster"
pukka PI_VAL = 3.141592653589793

dikhao "App Name:", APPLICATION_NAME
dikhao "Max Connections Allowed:", MAX_CONNECTIONS
dikhao "Pi Value:", PI_VAL
```

### 2. English Constant Declarations (`constant_demo.eg`)

```english
fixed BUFFER_SIZE = 4096
fixed HOST_ADDRESS = "127.0.0.1"

show "Buffer Size:", BUFFER_SIZE, "bytes"
show "Binding to Host:", HOST_ADDRESS
```

---

## 🔗 SEE ALSO

- **[Variables & Scope (`rakho` / `create`)](/docs/man/rakho-create/)**: Declaring mutable variables.
- **[Structs & Enums (`banao` / `type`)](/docs/man/banao-type/)**: Constant enum definitions.
