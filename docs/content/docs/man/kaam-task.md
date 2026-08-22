---
title: "kaam / task / function (Functions & Subroutines)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Functions & Subroutines (`kaam` / `task` / `function` / `wapas` / `return`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: Nim `proc name(params): ReturnType {.discardable.} =` ➔ C function definition

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
kaam function_name(param1: Type1, param2: Type2): ReturnType [toh]
    // procedure body
    wapas result_expression
khatam
```

### English Dialect (`.eg`)
```english
task function_name(param1: Type1, param2: Type2): ReturnType [do]
    // procedure body
    return result_expression
done

// Alternative Synonym Keywords
function function_name(param1: Type1): ReturnType do ... done
proc function_name(param1: Type1): ReturnType do ... done
```

---

## 📝 DESCRIPTION

The `kaam` / `task` / `function` keywords define reusable procedures and functions. Functions accept strongly typed input parameters and return a typed result (or return `void` if no return type is specified).

---

## ⚙️ SYNTAX, PARAMETERS & RETURN SEMANTICS

| Element | Hinglish (`.hg`) | English (`.eg`) | Description |
| :--- | :--- | :--- | :--- |
| **Declaration Opener** | `kaam name(...)` | `task name(...)` / `function` | Procedure declaration opener. |
| **Parameters** | `(a: int, b: string)` | `(a: int, b: string)` | Parameter definitions with explicit type annotations. |
| **Return Type** | `: return_type` | `: return_type` | Optional return type suffix. Omit for void procedures. |
| **Return Statement** | `wapas expr` | `return expr` | Returns value to caller and exits function immediately. |
| **Block Terminator** | `khatam` / `bas` | `done` / `end` | Marks procedure body end boundary. |

---

## 💡 IMPLEMENTATION & PERFORMANCE MECHANICS

- **`{.discardable.}` Annotation**: The transpiler automatically decorates procedure signatures with Nim's `{.discardable.}` pragma unless the procedure body contains raw `{...}` block annotations. This allows procedures returning values to be invoked like void statements without compiler warnings.
- **Inlining Optimization**: Small functions transpile to inline C functions when compiled with release flags (`compound build -d:release`), eliminating stack frame overhead for micro-benchmarks.
- **Asynchronous Procedures (`{.async.}`)**: Annotating functions with `{.async.}` enables asynchronous event-loop subroutines returning `Future[T]`.

---

## ⚠️ EDGE CASES, SCOPE & RECURSION

> [!NOTE]
> **Parameter Immutability**: Parameters passed to procedures are immutable constants by default within the procedure body. To mutate a parameter, declare a local variable copy (`rakho local_param = param`) or use `var` parameter modifiers (`kaam modify(var x: int)`).

---

## 🧪 CODE EXAMPLES

### 1. Hinglish Recursive Function (`function_demo.hg`)

```hinglish
// Recursive Fibonacci calculation function
kaam fibonacci(n: int): int toh
    agar n <= 1 toh
        wapas n
    khatam
    wapas fibonacci(n - 1) + fibonacci(n - 2)
khatam

dikhao "Fibonacci(10) =", fibonacci(10)

// Subroutine with default discardable return
kaam greet_user(naam: string) toh
    dikhao "Namaste,", naam, "! Aapka swagat hai."
khatam

greet_user("Narayana")
```

### 2. English Math Task (`function_demo.eg`)

```english
task compute_compound_interest(principal: float64, rate: float64, years: int): float64 do
    keep amount = principal
    each yr in 1 .. years do
        amount += (amount * rate)
    done
    return amount
done

keep final_amount = compute_compound_interest(10000.0, 0.08, 5)
show "Final Compound Amount after 5 years:", final_amount
```

---

## 🔗 SEE ALSO

- **[Variables & Scope (`rakho` / `create`)](/docs/man/rakho-create/)**: Managing variable scope inside functions.
- **[C FFI Directives (`c_ka_kaam` / `c_func`)](/docs/man/c-ffi/)**: Binding external C functions.
