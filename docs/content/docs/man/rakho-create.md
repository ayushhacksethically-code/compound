---
title: "rakho / keep (Variables & Scope)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Variable Declarations & Scope (`rakho` / `keep` / `var` / `let`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: Nim `var variable = expression` ➔ C variable definition

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
// Explicit Variable Declaration
rakho variable_name = expression
rakho variable_name: Type = expression

// Implicit Auto-Declaration on Assignment
variable_name = expression
```

### English Dialect (`.eg`)
```english
// Explicit Variable Declaration
keep variable_name = expression
var variable_name = expression
let variable_name = expression

// Implicit Auto-Declaration on Assignment
variable_name = expression
```

---

## 📝 DESCRIPTION

The `rakho` / `keep` / `var` / `let` keywords declare **mutable variables** within the current lexical scope.

Compound supports **automatic implicit variable declaration**: if an assignment statement `identifier = expression` is encountered and `identifier` has not been previously declared in the active scope, the transpiler automatically prepends `var ` to transform the line into a valid declaration.

---

## ⚙️ SYNONYM & SCOPE MATRIX

| Dialect | Primary Declaration Keyword | Synonyms | Scope Boundary |
| :--- | :--- | :--- | :--- |
| **Hinglish (`.hg`)** | `rakho` | `rakho` | Current block scope (`kaam`, `agar`, `jabtak`) |
| **English (`.eg`)** | `keep` | `var`, `let` | Current block scope (`task`, `if`, `while`) |
| **Implicit Mode** | `x = 10` | Auto-declares `var x = 10` | Enclosing block scope |

---

## 💡 IMPLEMENTATION & TYPE INFERENCE NOTES

- **Type Inference**: Primitive types (`int`, `float`, `string`, `bool`) are automatically inferred from initializer expressions (`rakho score = 100` infers `score: int`).
- **Explicit Type Annotations**: You can provide explicit type annotations (`rakho items: seq[string] = @[]`) when initializing empty collections or interface types.

---

## ⚠️ EDGE CASES & VARIABLE SHADOWING

> [!WARNING]
> **Variable Shadowing**: Re-declaring a variable name within an inner block scope masks the outer variable for the duration of the inner block. Avoid ambiguous identifiers across nested procedures.

---

## 🧪 CODE EXAMPLES

### 1. Hinglish Variable Declarations (`variable_demo.hg`)

```hinglish
// Explicit declaration with type inference
rakho user_count = 50
rakho app_version = "v1.2.0"
rakho active_status = sahi

// Implicit auto-declaration
total_revenue = 150000.75
dikhao "Revenue:", total_revenue

// Sequence initialization with explicit type
rakho items: seq[string] = @["Server-A", "Server-B"]
items.add("Server-C")

dikhao "Total servers active:", items.len
```

### 2. English Variable Declarations (`variable_demo.eg`)

```english
keep worker_threads = 8
keep server_name = "production-cluster-01"

// Implicit variable assignment
connection_timeout = 30
show "Connection Timeout set to:", connection_timeout, "seconds"
```

---

## 🔗 SEE ALSO

- **[Constants & Immutability (`pukka` / `fixed`)](/docs/man/pukka-fixed/)**: Declaring immutable values.
- **[Structs & Custom Types (`banao` / `type`)](/docs/man/banao-type/)**: Initializing struct instances into variables.
