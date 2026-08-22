---
title: "koshish / try (Exception Handling & Assertions)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Exception Handling & Assertions (`koshish_karo` / `try` / `shart_jaanch` / `assert`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: Nim `try ... except ... finally` & `doAssert` ➔ C exception frames and runtime checks

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
koshish_karo [toh]
    // protected block
    galti_phenko "Runtime error message"
galti_pakdo [toh]
    // exception catch block
aakhir_mein [toh]
    // mandatory cleanup block
khatam

// Runtime Assertion
shart_jaanch condition_expression
```

### English Dialect (`.eg`)
```english
try [do]
    // protected block
    throw "Runtime error message"
catch [do]
    // exception catch block
finally [do]
    // mandatory cleanup block
done

// Runtime Assertion
assert condition_expression
```

---

## 📝 DESCRIPTION

The `koshish_karo` / `try` structure traps runtime exceptions (such as file I/O failures, value parsing errors, array out-of-bound indexes, and custom exceptions).

- **`galti_phenko` / `throw` / `raise`**: Raises an exception with a specific error message string. The transpiler converts string arguments into `raise newException(ValueError, "msg")`.
- **`shart_jaanch` / `assert`**: Validates a runtime condition. If the condition evaluates to `false` (`galat`), program execution halts immediately with an `AssertionDefect` error log.

---

## ⚙️ KEYWORD SYNONYM MATRIX

| Directive Intent | Hinglish Dialect (`.hg`) | English Dialect (`.eg`) | Transpiled Nim Target Code |
| :--- | :--- | :--- | :--- |
| **Try Protected Block** | `koshish_karo toh` | `try do` / `try:` | `try:` |
| **Catch Exception** | `galti_pakdo toh` | `catch do` / `except` | `except:` |
| **Finally Block** | `aakhir_mein toh` | `finally do` / `finally:` | `finally:` |
| **Raise Exception** | `galti_phenko "msg"` | `throw "msg"` / `raise "msg"` | `raise newException(ValueError, "msg")` |
| **Runtime Assertion** | `shart_jaanch cond` | `assert cond` | `doAssert cond` |

---

## 💡 IMPLEMENTATION & PERFORMANCE NOTES

- **Zero Cost Try Blocks**: When no exceptions are raised, executing code inside a `koshish_karo` / `try` block incurs near zero CPU overhead.
- **Guaranteed Cleanup**: The `aakhir_mein` / `finally` block is executed unconditionally before exiting the try structure, even if an uncaught exception is thrown or a `wapas` / `return` statement is executed inside the try block.

---

## ⚠️ EDGE CASES & ASSERTION MODES

> [!WARNING]
> **Production Release Builds (`-d:release`)**: Standard Nim assertions can be omitted by certain compiler optimization flags. However, Compound uses `doAssert` (`shart_jaanch`), guaranteeing that assertions remain active and enforced even in production release builds.

---

## 🧪 CODE EXAMPLES

### 1. Hinglish Error Handling & Assertions (`exception_demo.hg`)

```hinglish
kaam khata_nakaas(amount: float64, balance: float64): float64 toh
    // Validate non-negative withdrawal amount
    shart_jaanch amount > 0.0
    
    agar amount > balance toh
        galti_phenko "Paryaapt balance nahi hai!"
    khatam
    wapas balance - amount
khatam

dikhao "=== Bank Transaction Test ==="

koshish_karo toh
    rakho naya_balance = khata_nakaas(5000.0, 2000.0)
    dikhao "Naya Balance:", naya_balance
galti_pakdo toh
    dikhao "Galti Pakdi: Transaction fail ho gaya!"
aakhir_mein toh
    dikhao "Transaction log audit completed."
khatam
```

### 2. English Error Handling (`exception_demo.eg`)

```english
import std/strutils

task parse_user_age(age_text: string): int do
    try do
        keep age = parseInt(strip(age_text))
        if age is smaller than 0 do
            throw "Age cannot be negative"
        done
        return age
    catch do
        show "Invalid integer input string provided!"
        return -1
    finally do
        show "Age parsing operation finished."
    done
done

keep valid_age = parse_user_age("25")
show "Parsed Age:", valid_age

keep invalid_age = parse_user_age("abc")
```

---

## 🔗 SEE ALSO

- **[Conditionals (`agar` / `if`)](/docs/man/agar-if/)**: Checking runtime conditions.
- **[Functions (`kaam` / `task`)](/docs/man/kaam-task/)**: Error propagation across function boundaries.
