---
title: "Hinglish Language Guide (.hg)"
date: 2026-08-21
weight: 2
draft: false
---

# Hinglish (`.hg`) Dialect Technical Manual & Language Guide

> [!NOTE]
> The **Hinglish (`.hg`)** dialect enables developers to write production-grade systems code, web engines, and automation scripts using natural Hindi and English phonetics (`rakho`, `dikhao`, `agar` / `toh` / `varna`, `kaam`, `khatam`).

---

## 📋 Comprehensive Keyword Matrix & Synonyms

| Construct / Intent | Hinglish Keyword (`.hg`) | Transpiled Nim / C Target | Description |
| :--- | :--- | :--- | :--- |
| **Variable Declaration** | `rakho x = v` | `var x = v` | Mutable variable declaration |
| **Constant Declaration** | `pukka K = v` | `const K = v` | Immutable constant declaration |
| **Implicit Assignment** | `x = v` | `var x = v` | Automatic variable initialization |
| **Struct / Type Definition**| `banao User = object` | `type User = object` | Custom record type definition |
| **Console Output** | `dikhao arg1, arg2` | `echo arg1, arg2` | Standard output print |
| **Console Input** | `pucho()` | `readLine(stdin)` | Read input line from `stdin` |
| **Conditional If** | `agar cond toh` | `if cond:` | Primary branch execution |
| **Conditional Elif** | `varna agar cond toh` | `elif cond:` | Secondary conditional branch |
| **Conditional Else** | `varna` / `varna toh` | `else:` | Default fallback branch |
| **While Loop** | `jabtak cond toh` | `while cond:` | Pre-condition loop iteration |
| **For-In Loop** | `har item mein list toh` | `for item in list:` | Collection iteration |
| **Function / Task** | `kaam name(args): T toh` | `proc name(args): T {.discardable.} =` | Subroutine procedure definition |
| **Return Value** | `wapas expr` | `return expr` | Return execution result |
| **Loop Continue** | `aage_bhadho` / `jaari_rakho` | `continue` | Skip to next loop iteration |
| **Loop Break** | `roko` / `tod_do` | `break` | Terminate loop execution |
| **Discard Statement** | `chhod_do` / `kuch_nahi` | `discard` | Explicit no-op statement |
| **Pattern Match** | `chuno val toh` | `case val` | Switch multi-way selection |
| **Match Case** | `jab case_val toh` | `of case_val:` | Specific match value branch |
| **Try Block** | `koshish_karo toh` | `try:` | Protected exception block |
| **Catch Exception** | `galti_pakdo toh` | `except:` | Trap runtime exception |
| **Finally Block** | `aakhir_mein toh` | `finally:` | Guaranteed cleanup block |
| **Raise Exception** | `galti_phenko "msg"` | `raise newException(ValueError, "msg")` | Throw runtime error |
| **Runtime Assertion** | `shart_jaanch cond` | `doAssert cond` | Validation assertion check |
| **Module Import** | `shamil_karo mod` / `import_karo` | `import mod` | Import Nim/Compound stdlib module |
| **C FFI Function** | `c_ka_kaam fn from "hdr.h"` | `proc fn {.importc, header: "hdr.h".}` | Direct C library function binding |
| **Bash Command** | `$ "cmd"` / `chalao "cmd"` | `discard execCmd("cmd")` | Execute shell subprocess |
| **PowerShell Command** | `ps_kaam "cmd"` / `ps "cmd"` | `discard execCmd("pwsh ...")` | Execute PowerShell cmdlet |
| **Boolean True** | `sahi` | `true` | Logical true constant |
| **Boolean False** | `galat` | `false` | Logical false constant |
| **Nil / Null Pointer** | `khali` | `nil` | Null pointer reference |
| **Logical AND / OR / NOT** | `aur` / `ya` / `nahi` | `and` / `or` / `not` | Logical operators |
| **Exit Program** | `bahar_niklo()` / `band_karo()` | `quit(0)` | Immediate program termination |
| **Block Terminator** | `khatam` / `bas` | Indentation un-indent | Close block scope boundary |
| **Strict Procedure `[UNSTABLE / STAGING]`** | `pakka kaam fn(...) toh` | `proc fn(...)` | Opt-in static borrow-checked task |
| **Move Semantics `[UNSTABLE / STAGING]`** | `chala_gaya var` | Ownership transfer | Transfer resource ownership statically |
| **Option Variant `[UNSTABLE / STAGING]`** | `MilGaya(v)` / `Khali` | `Option[T]` variant | `Some(value)` or `None` variant |
| **Result Variant `[UNSTABLE / STAGING]`** | `Sahi(v)` / `Galti(e)` | `Result[T, E]` variant | `Ok(value)` or `Err(error)` variant |
| **Sum-Type Match `[UNSTABLE / STAGING]`** | `hai Variant(...) toh` | `of Variant:` | Pattern match sum-type case branch |


---

## 1. Variable Declarations & Scope Rules

### Syntax Signatures
```hinglish
rakho variable_naam = expression
pukka CONSTANT_NAAM = expression
variable_naam = expression
```

### Semantics & Variable Shadowing
- **`rakho`**: Declares a mutable variable inside the current block scope.
- **`pukka`**: Declares a compile-time constant or immutable value.
- **Implicit Auto-Declaration**: Assigning to a previously undeclared identifier automatically emits `var variable_naam = ...`.

```hinglish
// Global variables
pukka GYAP_PAD = 100
rakho kul_ginti = 0

// Implicit auto-declaration
grahak_naam = "Rahul"
dikhao "Grahak init:", grahak_naam

kaam chalao_ginti() toh
    // Inner variable shadowing kul_ginti
    rakho kul_ginti = 10
    dikhao "Inner ginti:", kul_ginti
khatam

chalao_ginti()
dikhao "Outer ginti:", kul_ginti  // Output: 0
```

---

## 2. Expressions, Operators, & Words

Hinglish provides intuitive phonetic logical operators alongside standard mathematical operations:

### Logical & Word Operators Matrix

| Hinglish Word | Nim / Standard Equivalent | Meaning / Description |
| :--- | :--- | :--- |
| `aur` | `and` | Short-circuit Logical AND |
| `ya` | `or` | Short-circuit Logical OR |
| `nahi` | `not` | Logical NOT inversion |
| `sahi` | `true` | Boolean True |
| `galat` | `false` | Boolean False |
| `khali` | `nil` | Null / unassigned reference handle |

### Math & Bitwise Operators

| Operator | Action | Nim Backend Equivalent |
| :--- | :--- | :--- |
| `a ** b` | Exponentiation ($a^b$) | `a ^ b` |
| `a // b` | Integer Division ($\lfloor a/b \rfloor$) | `a div b` |
| `a % b` | Modulo Remainder ($a \pmod b$) | `a mod b` |
| `a << b` | Left Bitwise Shift | `a shl b` |
| `a >> b` | Right Bitwise Shift | `a shr b` |

```hinglish
rakho a = 15
rakho b = 20

agar a < b aur b == 20 toh
    dikhao "Sahi condition mil gayi!"
khatam

rakho pow_val = 2 ** 10
dikhao "2 ** 10 =", pow_val  // 1024
```

---

## 3. Control Flow Mechanics

### Branching (`agar` / `varna agar` / `varna`)

```hinglish
rakho umar = 22

agar umar >= 60 toh
    dikhao "Senior Citizen"
varna agar umar >= 18 toh
    dikhao "Adult Citizen"
varna
    dikhao "Minor"
khatam
```

### Pre-Condition Loops (`jabtak ... toh ... khatam`)

```hinglish
rakho i = 1
jabtak i <= 5 toh
    dikhao "Loop kram:", i
    i += 1
khatam
```

### Iteration Loops (`har ... mein ... toh ... khatam`)

```hinglish
// Numeric range iteration
har num mein 1 .. 5 toh
    dikhao "Ginti:", num
khatam

// Sequence collection iteration
rakho shahar_list = @["Delhi", "Mumbai", "Bengaluru"]
har shahar mein shahar_list toh
    dikhao "Shahar naam:", shahar
khatam
```

---

## 4. Functions & Procedures (`kaam`)

### Syntax Signature
```hinglish
kaam name(param1: Type1, param2: Type2): ReturnType toh
    // block body
    wapas result
khatam
```

> [!NOTE]
> Functions defined with `kaam` carry the Nim `{.discardable.}` pragma automatically. You can invoke them for side-effects without binding their output value.

```hinglish
kaam guna_karo(x: int, y: int): int toh
    wapas x * y
khatam

rakho res = guna_karo(8, 9)
dikhao "8 * 9 =", res
```

---

## 5. Structs & Record Types (`banao`)

```hinglish
banao UserRecord = object
    id: int
    naam: string
    active: bool
khatam

rakho user1 = UserRecord(id: 101, naam: "Amit Kumar", active: sahi)
dikhao "User Naam:", user1.naam, "Active status:", user1.active
```

---

## 6. Pattern Matching (`chuno` / `jab`)

```hinglish
rakho code = 200

chuno code toh
    jab 200 toh
        dikhao "Kaam Safal (200 OK)"
    jab 404 toh
        dikhao "Nahi Mila (404 Not Found)"
    varna toh
        dikhao "Agyaat Code"
khatam
```

---

## 7. Error Handling & Exceptions (`koshish_karo`)

```hinglish
task sthiti_jaanch(val: int) toh
    shart_jaanch val > 0
    agar val == 0 toh
        galti_phenko "Zero value anumati nahi hai"
    khatam
khatam

koshish_karo toh
    sthiti_jaanch(0)
galti_pakdo toh
    dikhao "Galti pakad li runtime block mein!"
aakhir_mein toh
    dikhao "Hamesha chalne wala final cleanup block."
khatam
```

---

## 8. C FFI Integration & Subshell Execution

### Calling Native C Functions (`c_ka_kaam`)
```hinglish
c_ka_kaam puts(s: cstring): cint from "stdio.h"
c_ka_kaam ceil(x: cdouble): cdouble from "math.h"

puts("Namaste C Ecosystem se Hinglish dialect dwaara!")
dikhao "Ceil(4.3) =", ceil(4.3)
```

### Subshell Execution (`$` & `ps_kaam`)
```hinglish
// Zero imports required!

// 1. Direct Bash command execution
$ "echo 'Logging data' >> /tmp/hinglish_app.log"

// 2. PowerShell command execution
ps_kaam "Get-Process | Where-Object WorkingSet -gt 100MB"
```

---

## 9. Borrow Checker, Move Semantics & Sum-Types `[UNSTABLE / STAGING]`

> [!WARNING]
> Features in this section belong to the experimental `feature/borrow-checker-unstable` branch. See the complete specification at [Unstable Features Specification](/docs/unstable-features/).

### Opt-In Borrow Checker (`pakka kaam`) & Move Semantics (`chala_gaya`)

```hinglish
kaam process(val: string) toh
    dikhao "Processed item:", val
khatam

pakka kaam main() toh
    rakho item = "SensitiveData"
    // Explicit ownership move
    process(chala_gaya item)
    
    // ❌ Accessing 'item' here triggers compile-time [Galti - BorrowChecker]
khatam
```

### Sum-Types (`MilGaya`, `Khali`, `Sahi`, `Galti`) & Pattern Matching (`chuno ... hai`)

```hinglish
kaam test_sum_types() toh
    rakho opt = MilGaya(42)
    chuno opt
        hai MilGaya(val) toh
            dikhao "Value found:", val
        hai Khali toh
            dikhao "No value"
    khatam

    rakho res = Sahi("Operation Complete")
    chuno res
        hai Sahi(msg) toh
            dikhao "Success:", msg
        hai Galti(err) toh
            dikhao "Failed:", err
    khatam
khatam
```

