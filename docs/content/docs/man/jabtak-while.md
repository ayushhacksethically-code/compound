---
title: "jabtak / while (Loops & Iteration)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Loops & Iteration (`jabtak` / `while` / `har` / `for`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: Nim `while` and `for` ➔ C `while (...) { ... }` and `for (...) { ... }`

---

## 📖 SYNOPSIS

### 1. Pre-Condition While Loop
- **Hinglish (`.hg`)**: `jabtak condition [toh]` ... `khatam`
- **English (`.eg`)**: `while condition [do]` ... `done`

### 2. Collection & Range Iteration Loop
- **Hinglish (`.hg`)**: `har item mein collection [toh]` ... `khatam`
- **English (`.eg`)**: `for item in collection [do]` ... `done`  
  *(Alternative Synonym: `each item in collection [do]` ... `done`)*

---

## 📝 DESCRIPTION

Compound provides pre-condition conditional loops (`jabtak` / `while`) and iterator loops (`har` / `for` / `each`) for iterating over numeric ranges (`1 .. 10`), sequences (`@["a", "b"]`), strings, hash table key-value pairs, and custom iterators.

### Control Flow Interrupt Directives

| Intent | Hinglish Directive | English Directive | Nim / C Target |
| :--- | :--- | :--- | :--- |
| **Skip to Next Iteration** | `aage_bhadho` / `jaari_rakho` | `continue` / `skip` | `continue` |
| **Break / Terminate Loop** | `roko` / `tod_do` | `break` / `stop` | `break` |

---

## ⚙️ SYNTAX & ITERATOR MATRIX

| Loop Structure | Syntax (`.hg` / `.eg`) | Target Transpiled Nim Code |
| :--- | :--- | :--- |
| **Numeric Range (Inclusive)** | `har i mein 1 .. 10 toh` | `for i in 1 .. 10:` |
| **Numeric Range (Exclusive)** | `har i mein 0 ..< 10 toh` | `for i in 0 ..< 10:` |
| **Sequence Iteration** | `har item mein list_var toh` | `for item in list_var:` |
| **Table Key-Value Pair** | `har k, v mein table_var toh` | `for k, v in table_var:` |
| **Countdown Loop** | `har i mein countdown(10, 1) toh` | `for i in countdown(10, 1):` |

---

## 💡 IMPLEMENTATION & PERFORMANCE NOTES

- **C Loop Optimization**: `for` and `while` loops transpile into native C loops. GCC/Clang unrolls tight loops and vectorizes numeric array calculations.
- **Zero Heap Allocation**: Iterating over sequences (`for x in seq`) borrows elements by value or immutable reference, incurring zero heap allocation overhead during loop execution.

---

## ⚠️ EDGE CASES & SHADOWING

> [!WARNING]
> **Loop Variable Shadowing**: The iteration variable (`i` in `for i in 1 .. 10`) is local to the loop block. Avoid modifying the iteration variable manually inside the loop body, as doing so leads to undefined iteration behavior in C backends.

---

## 🧪 CODE EXAMPLES

### 1. Hinglish Loops (`loop_demo.hg`)

```hinglish
shamil_karo tables

// 1. While Loop with Continue and Break
dikhao "--- While Loop Demo ---"
rakho i = 1
jabtak i <= 10 toh
    agar i == 5 toh
        i += 1
        aage_bhadho // Skip 5
    khatam
    agar i == 8 toh
        roko // Break loop at 8
    khatam
    dikhao "Current count:", i
    i += 1
khatam

// 2. Hash Table Iteration
dikhao "--- Table Iteration ---"
rakho grahak_data = initTable[string, int]()
grahak_data["Delhi"] = 110001
grahak_data["Mumbai"] = 400001

har shahar, pincode mein grahak_data toh
    dikhao "Shahar:", shahar, "| Pincode:", pincode
khatam
```

### 2. English Loops (`loop_demo.eg`)

```english
// 1. Range and Sequence Loop
show "--- Numeric Range Iteration ---"
each num in 1 .. 5 do
    show "Number squared:", num, "*", num, "=", num * num
done

// 2. Collection Iteration
keep servers = @["web-01.prod", "db-01.prod", "cache-01.prod"]
for server in servers do
    show "Pinging server host:", server
done
```

---

## 🔗 SEE ALSO

- **[Conditionals (`agar` / `if`)](/docs/man/agar-if/)**: Conditional expression branching.
- **[Functions & Subroutines (`kaam` / `task`)](/docs/man/kaam-task/)**: Encapsulating loops inside reusable procedures.
