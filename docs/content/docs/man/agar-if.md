---
title: "agar / if (Conditionals & Branching)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Conditionals (`agar` / `if` / `varna` / `otherwise`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Equivalent**: Nim `if`, `elif`, `else` ➔ C conditional jump statements (`if (...) { ... } else if (...) { ... } else { ... }`)

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
agar condition [toh]
    // primary branch block
varna agar condition [toh]
    // secondary branch block
varna [toh]
    // default fallback block
khatam
```

### English Dialect (`.eg`)
```english
if condition [do]
    // primary branch block
otherwise if condition [do]
    // secondary branch block
else [do]
    // default fallback block
done
```

---

## 📝 DESCRIPTION

The `agar` / `if` statement evaluates dynamic boolean conditions sequentially at runtime. Execution proceeds to the block belonging to the first condition that evaluates to `true` (`sahi`). Once a branch completes, execution jumps past the entire conditional structure to the statement immediately following the block terminator (`khatam` / `bas` or `done` / `end`).

---

## ⚙️ SYNTAX & PARAMETERS

### Parameter Table

| Parameter / Element | Type | Dialect Syntax | Description |
| :--- | :--- | :--- | :--- |
| **`condition`** | `bool` | Any valid boolean expression | Evaluated to determine execution path. Expressions can use logical operators (`aur`/`and`, `ya`/`or`, `nahi`/`not`). |
| **Block Opener** | Token | `toh` (Hinglish) / `do` (English) | Optional keyword signifying end of condition expression. |
| **Block Terminator** | Token | `khatam`/`bas` (HG) / `done`/`end` (EG) | Mandatory token marking the end of the multi-branch structure. |

### Synonym Matrix

| Dialect | Primary Keyword | Allowed Synonyms | Target Transpiled Nim Syntax |
| :--- | :--- | :--- | :--- |
| **Hinglish (`.hg`)** | `agar` | `agar ... toh` | `if ...:` |
| | `varna agar` | `varna agar ... toh` | `elif ...:` |
| | `varna` | `varna toh`, `varna:` | `else:` |
| **English (`.eg`)** | `if` | `if ... do` | `if ...:` |
| | `otherwise if` | `elif`, `otherwise if ... do` | `elif ...:` |
| | `else` | `otherwise`, `else do` | `else:` |

---

## 💡 IMPLEMENTATION & PERFORMANCE NOTES

- **String Literal Protection**: Comparison strings (e.g. `agar status == "if_ok"`) are protected by string masking (`maskStrings`) during transpilation so internal string content is never altered.
- **Short-Circuit Evaluation**: Logical `aur`/`and` and `ya`/`or` perform short-circuiting at runtime—if the left side of `aur` is `false`, the right side is not evaluated.
- **Branch Prediction & C Compilation**: The Nim backend transpiles `if/elif/else` into direct C `if / else if / else` chains, enabling full GCC/Clang branch prediction and jump table optimization.

---

## ⚠️ EDGE CASES, SCOPE & SHADOWING

> [!WARNING]
> **Block Scoping**: Variables declared inside an `agar`/`if` block (`rakho` or `keep`) exist within the block's scope. However, in intermediate Nim/C code generation, top-level block variable declarations share scope with the enclosing function unless scoped within explicit block contexts. Take care when re-declaring variable identifiers across multiple `varna agar` branches.

> [!NOTE]
> **Nested Conditionals**: Nested `agar`/`if` statements require matching `khatam`/`done` closers for every opened conditional block to maintain correct indentation alignment in generated Nim code.

---

## 🧪 CODE EXAMPLES

### 1. Hinglish Dialect (`conditional_demo.hg`)

```hinglish
rakho taapmaan = 38
rakho aam_hava = sahi

agar taapmaan is bigger than 40 toh
    dikhao "Khatarnak Garmi! Ghar par rahein."
varna agar taapmaan is bigger than 30 aur aam_hava == sahi toh
    dikhao "Kaafi Garmi Hai, Paani Piyein."
varna agar taapmaan is smaller than 10 toh
    dikhao "Kaafi Thand Hai!"
varna
    dikhao "Mausam Suhana Hai."
khatam
```

### 2. English Dialect (`conditional_demo.eg`)

```english
keep temperature = 38
keep AC_active = true

if temperature is bigger than 40 do
    show "Extreme Heat Warning! Stay indoors."
otherwise if temperature is bigger than 30 and AC_active is equal to true do
    show "Hot Weather: Ensure Air Conditioning is ON."
otherwise if temperature is smaller than 10 do
    show "Cold Weather Alert!"
else do
    show "Weather conditions are optimal."
done
```

---

## 🔗 SEE ALSO

- **[Pattern Matching (`chuno` / `match`)](/docs/man/chuno-match/)**: Multi-branch selection based on value matching.
- **[While Loops (`jabtak` / `while`)](/docs/man/jabtak-while/)**: Conditional iteration loops.
