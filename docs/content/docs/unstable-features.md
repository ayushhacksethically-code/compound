---
title: "Unstable & Staging Features [STAGING]"
date: 2026-08-22
weight: 5
draft: false
---

# Unstable & Staging Features (`feature/borrow-checker-unstable`)

> [!WARNING]
> **UNSTABLE / STAGING FEATURE NOTICE**  
> The constructs detailed on this page are actively being developed on the `feature/borrow-checker-unstable` branch. Syntax rules, borrow checker error messages, and API contracts are subject to refinement before landing in a stable main release.

---

## ⚡ Overview of Staging Capabilities

The `feature/borrow-checker-unstable` branch introduces zero-cost linear ownership memory management, algebraic sum-types, pattern matching destructors, and a native monolithic test harness to the Compound language ecosystem:

1. **Opt-in Borrow Checker** (`pakka kaam` in Hinglish / `strict task` in English)
2. **Explicit Move Semantics** (`chala_gaya` in Hinglish / `moved` in English)
3. **Sum-Types (Option & Result)** (`MilGaya`, `Khali`, `Sahi`, `Galti` / `Some`, `None`, `Ok`, `Err`)
4. **Sum-Type Pattern Matching** (`chuno ... hai` in Hinglish / `match ... is` in English)
5. **Monolithic Test Suite & Native Harness** (`tests/monolith_runner.hg`)

---

## 🛡️ 1. Opt-In Borrow Checker (`pakka kaam` / `strict task`)

Compound provides an opt-in memory safety model that statically tracks variable ownership at compile time. Functions declared with strict modifiers enforce single-owner rules and prevent use-after-move bugs.

### Keywords
- **Hinglish (`.hg`)**: `pakka kaam function_name(...) toh`
- **English (`.eg`)**: `strict task function_name(...) do`

### Semantics
When a function is defined with `pakka kaam` / `strict task`:
- All heap-allocated resources, objects, and strings passed with move keywords transfer ownership exclusively.
- The compile-time borrow checker scans function statements to guarantee moved variables are never read or reused again.

---

## 📦 2. Explicit Move Semantics (`chala_gaya` / `moved`)

Move semantics transfer ownership of a resource from one variable to another without copying data in memory.

### Keywords
- **Hinglish (`.hg`)**: `chala_gaya variable_name`
- **English (`.eg`)**: `moved variable_name`

### Code Examples

#### Hinglish Dialect (`.hg`)
```hinglish
kaam print_val(v: string) toh
    dikhao "Passed: " & v
khatam

kaam main() toh
    rakho item = "ValidItem"
    // Transfer ownership of 'item' to print_val
    print_val(chala_gaya item)
khatam

main()
```

#### English Dialect (`.eg`)
```english
task print_val(v: string) do
    show "Passed: " & v
end

task main() do
    keep item = "ValidItem"
    // Transfer ownership of 'item' to print_val
    print_val(moved item)
end

main()
```

### Compile-Time Error Contract (Negative Testing)

Attempting to read or pass a variable after its ownership has been moved triggers a compile-time BorrowChecker error.

#### Negative Example (`.hg`)
```hinglish
kaam main() toh
    rakho secret = "MySecret"
    rakho moved_secret = chala_gaya secret
    
    // ❌ COMPILE ERROR: BorrowChecker prevents use-after-move!
    dikhao secret
khatam

main()
```

#### Compiler Output Contract
```text
[Galti - BorrowChecker] Line 4: Variable 'secret' use nahi ho sakta kyunki iski ownership move ho chuki hai (chala_gaya secret).
```

---

## 🧩 3. Sum-Types Option & Result

Algebraic sum-types allow safe handling of optional values and operations that may fail, replacing `nil` pointers and silent exceptions with type-safe variants.

### Option Type Variants
| Dialect | Some Variant | None Variant |
| :--- | :--- | :--- |
| **Hinglish (`.hg`)** | `MilGaya(val)` | `Khali` |
| **English (`.eg`)** | `Some(val)` | `None` |

### Result Type Variants
| Dialect | Ok Variant | Err Variant |
| :--- | :--- | :--- |
| **Hinglish (`.hg`)** | `Sahi(val)` | `Galti(err)` |
| **English (`.eg`)** | `Ok(val)` | `Err(err)` |

---

## 🔍 4. Pattern Matching Destructuring (`chuno` / `match`)

Use pattern matching to deconstruct `Option` and `Result` sum-types cleanly into local bound variables.

### Hinglish Example (`.hg`)
```hinglish
kaam test_option() toh
    rakho opt = MilGaya(99)
    chuno opt
        hai MilGaya(num) toh
            dikhao "Number: " & $num
        hai Khali toh
            dikhao "Empty"
    khatam
khatam

kaam test_result() toh
    rakho res = Sahi("Success")
    chuno res
        hai Sahi(msg) toh
            dikhao "Result: " & msg
        hai Galti(err) toh
            dikhao "Error: " & err
    khatam
khatam

kaam main() toh
    test_option()
    test_result()
khatam

main()
```

### English Example (`.eg`)
```english
task test_option() do
    keep opt = Some(99)
    match opt
        is Some(num) do
            show "Number: " & $num
        is None do
            show "Empty"
    end
end

task test_result() do
    keep res = Ok("Success")
    match res
        is Ok(msg) do
            show "Result: " & msg
        is Err(err) do
            show "Error: " & err
    end
end

task main() do
    test_option()
    test_result()
end

main()
```

---

## 🧪 5. Monolithic Test Suite (6 Pillars) & Native Harness

The `feature/borrow-checker-unstable` branch includes a production test suite verified by a native Compound test runner written entirely in `.hg` (`tests/monolith_runner.hg`).

### The 6 Architecture Pillars
1. **Legacy & Interop (Suite A)**: Validates basic variables, C transpilation, JS transpilation pipeline, and shell command interop across `.hg` and `.eg` files.
2. **Linear Ownership & Move Semantics (Suite B)**: Verifies positive move syntax and enforces negative compile-time error contracts via `BorrowChecker`.
3. **Sum-Type Pattern Matching (Suite C)**: Verifies `MilGaya`/`Some` and `Sahi`/`Ok` pattern destructuring and execution paths.
4. **Binary Footprint & Performance Sanity Check**: Ensures compiler executable size and compilation speed remain within release benchmarks.
5. **Interactive REPL Automation (Suite D)**: Feeds simulated PTY stdin into `./compound repl` to verify live session evaluation.
6. **Visual Dashboard Summary**: Renders real-time test execution counts (`TOTAL PASSED`, `TOTAL FAILED`) directly from native `.hg` logic.

### Running the Monolithic Test Suite
```bash
# Run the native test harness
./compound run tests/monolith_runner.hg
```

---

## 🔗 Related Manual Pages
- [agar / if (Conditionals & Branching)](/docs/man/agar-if/)
- [chuno / match (Pattern Matching & Switch)](/docs/man/chuno-match/)
- [kaam / task (Functions & Subroutines)](/docs/man/kaam-task/)
- [pukka / fixed (Constants & Immutability)](/docs/man/pukka-fixed/)
- [Borrow Checker Technical Reference Page](/docs/man/borrow-checker-unstable/)
