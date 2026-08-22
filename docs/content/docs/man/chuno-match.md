---
title: "chuno / match (Pattern Matching & Switch)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Pattern Matching & Switch Branching (`chuno` / `match`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: Nim `case expr of val:` ➔ C `switch(expr) { case val: ... default: ... }`

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
chuno expression [toh]
    jab val1 [toh]
        // block for val1
    jab val2, val3 [toh]
        // block for val2 or val3
    varna [toh]
        // default fallback block
khatam
```

### English Dialect (`.eg`)
```english
match expression [do]
    when val1 [do]
        // block for val1
    when val2, val3 [do]
        // block for val2 or val3
    otherwise [do]
        // default fallback block
done
```

---

## 📝 DESCRIPTION

The `chuno` / `match` construct performs multi-way value branching against integers, strings, enums, characters, or ordinal types.

Unlike traditional C `switch` statements, Compound pattern matching:
1. **No Implicit Fallthrough**: Does not require explicit `break` statements between branches.
2. **Exhaustiveness Checking**: Requires all potential discrete enum/ordinal cases to be handled, or an explicit default fallback branch (`varna` / `otherwise`).
3. **Multi-Value Branches**: Allows comma-separated match values (`jab 1, 2, 3 toh`).

---

## ⚙️ SYNTAX & KEYWORD EQUIVALENTS

| Dialect | Expression Opener | Match Branch Opener | Default Fallback | Terminator |
| :--- | :--- | :--- | :--- | :--- |
| **Hinglish (`.hg`)** | `chuno expr toh` | `jab val toh` | `varna` / `varna toh` | `khatam` / `bas` |
| **English (`.eg`)** | `match expr do` / `case` | `when val do` / `of` | `otherwise` / `else` | `done` / `end` |
| **Transpiled Nim** | `case expr` | `of val:` | `else:` | Indent un-indent |

---

## 💡 IMPLEMENTATION & PERFORMANCE NOTES

- **C Jump Tables**: When matching integer or enum ordinals, GCC/Clang compiles `chuno`/`match` into direct C jump tables ($O(1)$ branch lookup).
- **String Branching**: When matching strings, Nim transpiles the branch into an optimized string hashing comparison loop.

---

## ⚠️ EDGE CASES & SCOPE

> [!NOTE]
> **Compound Constant Expressions**: Match values inside `jab` / `when` branches must be compile-time constant expressions (literals or `pukka`/`fixed` constants). Variable identifiers cannot be used as target match patterns.

---

## 🧪 CODE EXAMPLES

### 1. Hinglish Pattern Matching (`match_demo.hg`)

```hinglish
rakho http_status = 404

chuno http_status toh
    jab 200, 201 toh
        dikhao "Status 200/201: Anurodh Safal Hua!"
    jab 400, 401, 403 toh
        dikhao "Status 4xx: Grahak Galti (Client Error)"
    jab 404 toh
        dikhao "Status 404: Resource Nahi Mila!"
    jab 500, 502, 503 toh
        dikhao "Status 5xx: Server Galti"
    varna toh
        dikhao "Agyaat HTTP Response Code"
khatam
```

### 2. English String Matching (`match_demo.eg`)

```english
keep environment = "production"

match environment do
    when "development" do
        show "Loading debug options & detailed trace logs."
    when "staging" do
        show "Connecting to staging cluster databases."
    when "production" do
        show "Production environment active: Enforcement of SSL & strict security."
    otherwise do
        show "Unknown environment mode specified."
done
```

---

## 🔗 SEE ALSO

- **[Conditionals (`agar` / `if`)](/docs/man/agar-if/)**: Boolean expression branching.
- **[Structs & Enums (`banao` / `type`)](/docs/man/banao-type/)**: Enum definitions for match targets.
