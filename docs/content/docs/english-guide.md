---
title: "English Language Guide (.eg)"
date: 2026-08-21
weight: 3
draft: false
---

# English (`.eg`) Dialect Syntax Guide

The **English** dialect allows non-technical users and software engineers alike to write clean, self-documenting code using plain English terminology (`keep`, `show`, `if`, `task`, `while`, `done`).

---

## 📌 Core Keyword & Construct Cheat Sheet

| Category | English Keyword (`.eg`) | Nim/C Equivalent | Description |
| :--- | :--- | :--- | :--- |
| **Variables** | `keep x = 10` or `var x = 10` | `var x = 10` | Declare mutable variable |
| **Constants** | `fixed MAX = 100` or `const MAX = 100` | `const MAX = 100` | Declare immutable constant |
| **Output** | `show "Hello"` or `print "Hello"` | `echo "Hello"` | Print output to console |
| **Input** | `keep input = ask()` / `input()` | `readLine(stdin)` | Read input from console stdin |
| **Conditionals** | `if ... do`, `otherwise if`, `else` | `if`, `elif`, `else` | Branching evaluation |
| **Loops** | `while ... do`, `for x in container` | `while`, `for x in container` | Loop iteration |
| **Functions** | `task add(a: int): int do ... done` | `proc add(a: int): int` | Function declaration |
| **Return** | `return result` | `return result` | Return value from task |
| **Structs** | `type User = object` or `make User = object` | `type User = object` | Record structure definition |
| **Matching** | `match val do` / `when x do` | `case val of x:` | Pattern matching |
| **Exceptions** | `try`, `catch`, `throw` / `raise` | `try`, `except`, `raise` | Exception handling |
| **Assertions** | `assert x > 0` | `doAssert x > 0` | Assertion validation |
| **Block End** | `done` or `end` | Indent level decrease | End block boundary |

---

## 1. Variables and Constants

Declare mutable variables using `keep`, `var`, or `let`. Declare immutable constants using `fixed` or `const`.

```english
// Explicit variable declaration
keep username = "Alice"
keep score = 100

// Implicit assignment (automatically transpiled to var count)
count = 1

// Immutable constant
fixed MAX_CONNECTIONS = 1000
```

---

## 2. Functions & Tasks (`task`)

Define reusable tasks or functions using `task`, `function`, or `proc`. Return values with `return`. Close blocks with `done` or `end`.

```english
// Task returning an integer value
task calculate_total(price: float64, tax_rate: float64): float64 do
    return price + (price * tax_rate)
done

// Subroutine performing console output
task greet_user(name: string) do
    show "Welcome to Compound,", name
done

keep final_price = calculate_total(100.0, 0.18)
greet_user("Alice")
show "Final Price with Tax:", final_price
```

---

## 3. Conditionals (`if` / `otherwise if` / `else`)

Use intuitive condition comparisons like `is equal to`, `is bigger than`, `is smaller than`.

```english
keep temperature = 32

if temperature is bigger than 30 do
    show "It is hot outside!"
otherwise if temperature is smaller than 15 do
    show "It is cold outside!"
else do
    show "The weather is moderate."
done
```

---

## 4. Loops & Iteration (`while` / `for-in` / `each-in`)

### While Loop (`while`)
```english
keep step = 1
while step is smaller than or equal to 3 do
    show "Current Processing Step:", step
    step += 1
done
```

### Range & Sequence Loop (`for` / `each`)
```english
// Range iteration 1 to 5 inclusive
each n in 1 .. 5 do
    show "Processing item:", n
done

// Collection iteration
keep servers = @["web-01", "db-01", "cache-01"]
for server in servers do
    show "Checking health for server:", server
done
```

---

## 5. Custom Object Types (`type` / `make`)

Define custom data structures using `type` or `make`.

```english
make Account = object
    id: int
    holder_name: string
    balance: float64
done

keep acc1 = Account(id: 401, holder_name: "Charlie", balance: 12500.75)
show "Account Holder:", acc1.holder_name, "Balance:", acc1.balance
```

---

## 6. Pattern Matching (`match` / `when`)

Pattern match against values using `match` and `when` or `case`.

```english
keep http_code = 404

match http_code do
    when 200 do
        show "Status: OK"
    when 404 do
        show "Status: Resource Not Found"
    when 500 do
        show "Status: Internal Server Error"
    otherwise do
        show "Status: Unknown Error Code"
done
```

---

## 7. Exception Handling (`try` / `catch` / `finally`)

Handle runtime errors cleanly using `try`, `catch`, `throw`, and `finally`.

```english
try do
    keep value = 100
    if value is equal to 100 do
        throw "Simulated system processing failure"
    done
catch do
    show "Caught error gracefully inside catch block!"
finally do
    show "Cleanup block executed successfully."
done
```

---

## 8. Shell Automation & C FFI Integration

Call shell scripts or PowerShell cmdlets directly from `.eg` code.

```english
// 1. Direct Bash shell command
$ "echo 'Deployment finished' > /tmp/deploy.log"

// 2. PowerShell Cmdlet Execution
ps_command "Get-Process | Select-Object -First 5"

// 3. Foreign Function Interface (FFI) to C
c_func cos(x: cdouble): cdouble from "math.h"
show "Cosine of 0:", cos(0.0)
```
