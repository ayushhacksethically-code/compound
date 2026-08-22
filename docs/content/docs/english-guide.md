---
title: "English Language Guide (.eg)"
date: 2026-08-21
weight: 3
draft: false
---

# English (`.eg`) Dialect Technical Manual & Language Guide

> [!NOTE]
> The **English (`.eg`)** dialect allows developers, software engineers, and domain specialists to write expressive, high-performance systems and scripting code using clean, natural English terminology (`keep`, `show`, `if` / `do` / `else`, `task`, `while`, `done`).

---

## 📋 Comprehensive Keyword & Synonym Reference

| Construct / Intent | Primary English Syntax | Alternative Synonyms | Transpiled Nim / C Target |
| :--- | :--- | :--- | :--- |
| **Variable Declaration** | `keep x = 10` | `var x = 10`, `let x = 10` | `var x = 10` |
| **Constant Declaration** | `fixed MAX = 100` | `const MAX = 100` | `const MAX = 100` |
| **Implicit Assignment** | `x = 10` | (auto variable declaration) | `var x = 10` |
| **Type Struct Definition**| `type User = object` | `make User = object` | `type User = object` |
| **Console Output** | `show "Hello"` | `print "Hello"` | `echo "Hello"` |
| **Console Input** | `keep text = ask()` | `keep text = input()` | `readLine(stdin)` |
| **Conditional If** | `if cond do` | `if cond:` | `if cond:` |
| **Conditional Elif** | `otherwise if cond do` | `elif cond do`, `elif cond:` | `elif cond:` |
| **Conditional Else** | `else` | `otherwise` | `else:` |
| **While Loop** | `while cond do` | `while cond:` | `while cond:` |
| **For-In Loop** | `for item in container do` | `each item in container do` | `for item in container:` |
| **Function / Task** | `task name(arg: T): R do` | `function name()`, `proc name()` | `proc name(arg: T): R {.discardable.} =` |
| **Return Statement** | `return expr` | `return` | `return expr` |
| **Loop Continue** | `continue` | `skip` | `continue` |
| **Loop Break** | `break` | `stop` | `break` |
| **Pass / Discard** | `pass` | `nothing` | `discard` |
| **Pattern Match** | `match val do` | `match val:` | `case val:` |
| **Match Case** | `when case_val do` | `case case_val do` | `of case_val:` |
| **Try Block** | `try` / `try do` | `try:` | `try:` |
| **Catch Exception** | `catch` / `catch do` | `except` | `except:` |
| **Finally Block** | `finally` / `finally do` | `finally:` | `finally:` |
| **Raise Error** | `throw "msg"` | `raise "msg"` | `raise newException(ValueError, "msg")` |
| **Assert Condition** | `assert cond` | `assert cond` | `doAssert cond` |
| **Module Import** | `import module_name` | `use module_name` | `import module_name` |
| **C FFI Function** | `c_func fn(args): T from "hdr.h"` | `c_func fn(args): T` | `proc fn(args): T {.importc, header: "hdr.h", discardable.}` |
| **Bash Command** | `$ "cmd"` | `shell "cmd"`, `chalao "cmd"` | `discard execCmd("cmd")` |
| **PowerShell Command** | `ps_kaam "cmd"` | `ps_command "cmd"`, `ps "cmd"` | `discard execCmd("pwsh -NoProfile -NonInteractive -Command " & quoteShell("cmd"))` |
| **Boolean True** | `true` | `yes` | `true` |
| **Boolean False** | `false` | `no` | `false` |
| **Nil / Null Handle** | `nil` | `none`, `empty` | `nil` |
| **Block Terminator** | `done` | `end` | Indentation level decrease |
| **Strict Procedure `[UNSTABLE / STAGING]`** | `strict task fn(...) do` | `pukka kaam` | `proc fn(...)` opt-in borrow-checked procedure |
| **Move Semantics `[UNSTABLE / STAGING]`** | `moved var` | `chala_gaya` | Transfer variable ownership statically |
| **Option Type `[UNSTABLE / STAGING]`** | `Some(v)` / `None` | `MilGaya` / `Khali` | Value present (`Some`) or missing (`None`) |
| **Result Type `[UNSTABLE / STAGING]`** | `Ok(v)` / `Err(e)` | `Sahi` / `Galti` | Success result (`Ok`) or Error (`Err`) |
| **Sum-Type Match `[UNSTABLE / STAGING]`** | `is Variant(...) do` | `hai Variant(...) toh` | Pattern match sum-type variant branch |


---

## 1. Variables, Scope, & Auto-Declaration

### Syntax Signatures
```english
keep variable_name = expression
fixed CONSTANT_NAME = expression
variable_name = value
```

### Semantics & Scope Behavior
- **Explicit Variable Declaration (`keep` / `var` / `let`)**: Allocates a mutable variable in the current lexical scope.
- **Constant Declaration (`fixed` / `const`)**: Declares an immutable constant evaluated at compile-time or program initialization.
- **Implicit Auto-Declaration**: Assigning to a previously undeclared identifier (`a = 50`) automatically inserts `var a = 50`.

> [!WARNING]
> **Variable Shadowing & Scope**: Declaring a variable inside an inner block (`if`, `while`, `task`) with the same name as an outer variable shadows the outer variable within that block. Take care not to accidentally re-declare identifiers.

### Code Example
```english
// Global constant & variable
fixed MAX_ITEMS = 100
keep total_count = 0

// Implicit auto-declaration on assignment
user_name = "Alice"
show "User initialized:", user_name

task process_data() do
    // Local variable shadowing total_count
    keep total_count = 5
    show "Inner count:", total_count
done

process_data()
show "Outer count:", total_count  // Prints 0
```

---

## 2. Expressions, Operators, & Synonyms

Compound supports expressive natural-language comparison operators alongside standard mathematical symbols:

### Natural Comparison Operator Matrix

| English Phrase Syntax | Standard Symbol Syntax | Nim/C Transpiled Operator |
| :--- | :--- | :--- |
| `a is bigger than b` | `a > b` | `a > b` |
| `a is larger than b` | `a > b` | `a > b` |
| `a is smaller than b` | `a < b` | `a < b` |
| `a is bigger than or equal to b` | `a >= b` | `a >= b` |
| `a is smaller than or equal to b` | `a <= b` | `a <= b` |
| `a is equal to b` | `a == b` | `a == b` |
| `a is not equal to b` | `a != b` | `a != b` |

### Math & Bitwise Operators

| Compound Syntax | Operator Meaning | Nim Backend Syntax |
| :--- | :--- | :--- |
| `a ** b` | Exponentiation ($a^b$) | `a ^ b` |
| `a // b` | Integer Division ($\lfloor a/b \rfloor$) | `a div b` |
| `a % b` | Modulo Remainder ($a \pmod b$) | `a mod b` |
| `a << b` | Bitwise Left Shift | `a shl b` |
| `a >> b` | Bitwise Right Shift | `a shr b` |
| `a &= b` | Bitwise AND Assignment | `a and= b` |
| `a |= b` | Bitwise OR Assignment | `a or= b` |

```english
keep width = 10
keep height = 20

if width is smaller than height do
    show "Area calculation:", width * height
done

keep base = 2
keep power = 8
show "2 ** 8 =", base ** power  // Prints 256
```

---

## 3. Control Flow: Conditionals & Iteration

### Conditionals (`if` / `otherwise if` / `else`)

```english
keep temperature = 35

if temperature is bigger than 30 do
    show "Extreme Heat Warning!"
otherwise if temperature is smaller than 15 do
    show "Cold Weather Alert"
else do
    show "Optimal Temperature"
done
```

### While Loop (`while ... do ... done`)

```english
keep counter = 1
while counter is smaller than or equal to 5 do
    show "Iteration counter:", counter
    counter += 1
done
```

### For & Each Loops (`for` / `each`)

```english
// Numeric range iteration (inclusive)
each step in 1 .. 5 do
    show "Step number:", step
done

// Collection iteration
keep services = @["auth", "billing", "notifications"]
for service in services do
    show "Deploying microservice:", service
done
```

---

## 4. Functions & Tasks (`task`)

### Syntax Signature
```english
task task_name(param1: Type1, param2: Type2): ReturnType do
    // body
    return result
done
```

> [!NOTE]
> Functions declared with `task` or `function` are transpiled with the Nim `{.discardable.}` pragma, allowing callers to ignore return values without throwing compiler warnings.

### Code Example
```english
task compute_tax(subtotal: float64, rate: float64): float64 do
    if subtotal is smaller than 0.0 do
        return 0.0
    done
    return subtotal * rate
done

keep tax = compute_tax(150.00, 0.18)
show "Tax computed:", tax
```

---

## 5. Custom Object Types & Structs (`type` / `make`)

```english
make DatabaseConnection = object
    host: string
    port: int
    active: bool
done

keep conn = DatabaseConnection(host: "localhost", port: 5432, active: true)
show "Database Host:", conn.host, "Port:", conn.port
```

---

## 6. Pattern Matching (`match` / `when`)

```english
keep status_code = 404

match status_code do
    when 200 do
        show "HTTP Status: OK (200)"
    when 404 do
        show "HTTP Status: Not Found (404)"
    when 500 do
        show "HTTP Status: Internal Server Error (500)"
    otherwise do
        show "HTTP Status: Unknown Code"
done
```

---

## 7. Exception Handling & Assertions

```english
task divide(a: float64, b: float64): float64 do
    assert b != 0.0
    if b is equal to 0.0 do
        throw "Division by zero is undefined"
    done
    return a / b
done

try do
    keep res = divide(10.0, 0.0)
    show "Result:", res
catch do
    show "Caught error during division operation!"
finally do
    show "Execution clean-up complete."
done
```

---

## 8. Foreign Function Interface (C FFI) & Shell Integration

### Direct C FFI Binding (`c_func`)
```english
// Import standard C functions directly from header files
c_func sin(x: cdouble): cdouble from "math.h"
c_func puts(msg: cstring): cint from "stdio.h"

puts("Hello C Ecosystem from English Dialect!")
show "sin(3.14159 / 2) =", sin(1.570795)
```

### Shell & PowerShell Execution
```english
// Subprocess command with output return tuple (output, exitCode) - zero imports required!

// 1. Direct Bash command execution
$ "mkdir -p /tmp/compound_test && touch /tmp/compound_test/log.txt"

// 2. PowerShell execution
ps_command "Get-Service | Select-Object -First 3"
```

---

## 9. Borrow Checker, Move Semantics & Sum-Types `[UNSTABLE / STAGING]`

> [!WARNING]
> Features in this section belong to the experimental `feature/borrow-checker-unstable` branch. See the complete specification at [Unstable Features Specification](/docs/unstable-features/).

### Opt-In Borrow Checker (`strict task`) & Move Semantics (`moved`)

```english
task process(val: string) do
    show "Processed item:", val
done

strict task main() do
    keep item = "SensitiveData"
    // Explicit ownership move
    process(moved item)
    
    // ❌ Accessing 'item' here triggers compile-time [Error - BorrowChecker]
done
```

### Sum-Types (`Some`, `None`, `Ok`, `Err`) & Pattern Matching (`match ... is`)

```english
task test_sum_types() do
    keep opt = Some(42)
    match opt
        is Some(val) do
            show "Value found:", val
        is None do
            show "No value"
    end

    keep res = Ok("Operation Complete")
    match res
        is Ok(msg) do
            show "Success:", msg
        is Err(err) do
            show "Failed:", err
    end
done
```

