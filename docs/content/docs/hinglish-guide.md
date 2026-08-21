---
title: "Hinglish Language Guide (.hg)"
date: 2026-08-21
weight: 2
draft: false
---

# Hinglish (`.hg`) Dialect Syntax Guide

The **Hinglish** dialect allows developers to program using natural Hindi and English phonetics. It translates intuitive words like `rakho`, `dikhao`, `agar`, `toh`, and `khatam` into high-performance native machine binaries.

---

## 📌 Core Keyword & Construct Cheat Sheet

| Category | Hinglish Keyword (`.hg`) | Nim/C Equivalent | Description |
| :--- | :--- | :--- | :--- |
| **Variables** | `rakho x = 10` | `var x = 10` | Declare mutable variable |
| **Constants** | `pukka MAX = 100` | `const MAX = 100` | Declare immutable constant |
| **Output** | `dikhao "Hello"` | `echo "Hello"` | Print formatted output to console |
| **Input** | `rakho input = pucho()` | `readLine(stdin)` | Read line from standard input |
| **Conditionals** | `agar ... toh`, `varna agar`, `varna` | `if`, `elif`, `else` | Branching logic |
| **Loops** | `jabtak ... toh`, `har x mein container` | `while`, `for x in container` | Iteration loops |
| **Functions** | `kaam add(a: int): int toh ... khatam` | `proc add(a: int): int` | Subroutine definition |
| **Return** | `wapas result` | `return result` | Return value from function |
| **Structs** | `banao User = object` | `type User = object` | Custom record/type definition |
| **Matching** | `chuno val toh` / `jab x toh` | `case val of x:` | Pattern matching |
| **Exceptions** | `koshish_karo`, `galti_pakdo`, `galti_phenko` | `try`, `except`, `raise` | Exception handling |
| **Assertions** | `shart_jaanch x > 0` | `doAssert x > 0` | Runtime assertion check |
| **Block End** | `khatam` or `bas` | Indent level decrease | End block boundary |

---

## 1. Variables and Constants

Variables can be declared explicitly using `rakho` or created implicitly on first assignment. Constants are declared using `pukka`.

```hinglish
// Explicit variable declaration
rakho user_name = "Rahul"
rakho counter = 10

// Implicit assignment (automatically transpiled to var counter_2)
counter_2 = 20

// Immutable constant
pukka MAX_LIMIT = 500
```

---

## 2. Functions & Subroutines (`kaam`)

Functions are defined using `kaam`. Use `wapas` to return a value. Blocks must close with `khatam` or `bas`.

```hinglish
// Function returning an integer
kaam jod(a: int, b: int): int toh
  wapas a + b
khatam

// Void function with side effects
kaam abhinandan(naam: string) toh
  dikhao "Namaste,", naam
khatam

rakho total = jod(25, 75)
abhinandan("Amit")
dikhao "Total jod:", total
```

---

## 3. Conditionals (`agar` / `toh` / `varna agar` / `varna`)

Conditionals evaluate expressions and route execution. Opening lines optionally end with `toh`.

```hinglish
rakho score = 85

agar score >= 90 toh
  dikhao "Grade: A+"
varna agar score >= 75 toh
  dikhao "Grade: A"
varna toh
  dikhao "Grade: Pass"
khatam
```

---

## 4. Loops & Iteration (`jabtak` / `har ... mein`)

### While Loop (`jabtak`)
```hinglish
rakho i = 1
jabtak i <= 5 toh
  dikhao "Iteration ginti:", i
  i += 1
khatam
```

### Range & Sequence Loop (`har ... mein`)
```hinglish
// Range iteration 1 to 5 inclusive
har n mein 1 .. 5 toh
  dikhao "Number:", n
khatam

// Sequence iteration
rakho fruits = @["Aam", "Kela", "Seb"]
har fruit mein fruits toh
  dikhao "Phal:", fruit
khatam
```

---

## 5. Custom Objects & Structures (`banao`)

Define custom data structures with `banao`. You can create value objects or reference types (`ref object`).

```hinglish
banao Khata = object
  id: int
  naam: string
  balance: float64
khatam

rakho k1 = Khata(id: 101, naam: "Priya", balance: 5000.50)
dikhao "Khata Naam:", k1.naam, "| Balance:", k1.balance
```

---

## 6. Pattern Matching (`chuno` / `jab`)

Multi-branch evaluation is handled cleanly with `chuno` and `jab`.

```hinglish
rakho status_code = 200

chuno status_code toh
  jab 200 toh
    dikhao "Safal (OK)"
  jab 404 toh
    dikhao "Nahi mila (Not Found)"
  jab 500 toh
    dikhao "Server Galti (Internal Error)"
  varna toh
    dikhao "Agyaat status code"
khatam
```

---

## 7. Exception Handling (`koshish_karo` / `galti_pakdo` / `aakhir_mein`)

Safely trap runtime errors using `koshish_karo` and `galti_pakdo`. Use `galti_phenko` to raise exceptions and `aakhir_mein` for cleanup blocks.

```hinglish
koshish_karo toh
  rakho x = 10
  agar x == 10 toh
    galti_phenko "Seema se bahar ki galti!"
  khatam
galti_pakdo toh
  dikhao "Galti pakdi gayi safalta se!"
aakhir_mein toh
  dikhao "Har haal mein chalega (Cleanup done)"
khatam
```

---

## 8. Shell Automation & C FFI Integration

Hinglish integrates seamlessly with Linux shell scripts and native C libraries.

```hinglish
// 1. Execute Bash command directly
$ "echo 'Creating log file...' > /tmp/hg_app.log"

// 2. Execute command and capture output
rakho (output, exit_code) = command("uname -r")
dikhao "Kernel version:", output.strip()

// 3. Native C Library FFI Import
c_ka_kaam sin(x: cdouble): cdouble from "math.h"
c_ka_kaam printf(fmt: cstring, val: cdouble): cint from "stdio.h"

printf("Sin(1.57) value: %.4f\n", sin(1.5708))
```
