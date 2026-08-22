---
title: "Data Types & Structs Manual Page"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Primitive Types, Structs, Collections & Memory Model (`types-and-structs`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: Nim type system & C compiler native representation

---

## 📖 OVERVIEW

Compound is a strongly typed, statically typed compiled language. It provides primitive integer and floating-point types, strings, sequence arrays (`seq[T]`), hash maps (`Table[K,V]`), custom value structs (`object`), managed heap pointers (`ref object`), and enumerations (`enum`).

---

## ⚙️ PRIMITIVE TYPES MATRIX

| Type Keyword | Bit Width | Range / Format | C Language Equivalent |
| :--- | :--- | :--- | :--- |
| `int` | Platform Word | Target architecture signed int (32/64-bit) | `intptr_t` / `long` |
| `int8` | 8-bit | $-128 \dots 127$ | `int8_t` |
| `int16` | 16-bit | $-32,768 \dots 32,767$ | `int16_t` |
| `int32` | 32-bit | $-2,147,483,648 \dots 2,147,483,647$ | `int32_t` |
| `int64` | 64-bit | $-9 \times 10^{18} \dots 9 \times 10^{18}$ | `int64_t` |
| `uint` | Platform Word | Unsigned word integer | `uintptr_t` / `unsigned long` |
| `uint8` / `byte` | 8-bit | $0 \dots 255$ | `uint8_t` |
| `float` / `float64`| 64-bit | Double-precision IEEE 754 float | `double` |
| `float32` | 32-bit | Single-precision IEEE 754 float | `float` |
| `bool` | 1 byte | `sahi`/`galat` (HG) or `true`/`false` (EG) | `bool` / `cint` |
| `char` | 8-bit | Single ASCII character | `char` |
| `string` | Variable | UTF-8 managed dynamic string | Nim string header struct |
| `cstring` | Variable | Null-terminated C string pointer | `char*` or `const char*` |

---

## 📦 COMPOSITE COLLECTIONS & STRUCTS

### 1. Dynamic Sequences (`seq[T]`)
Dynamic arrays initialized using `@[...]` syntax:
```hinglish
rakho numbers = @[10, 20, 30, 40]
numbers.add(50)
dikhao "Sequence len:", numbers.len, "Element 0:", numbers[0]
```

### 2. Value Objects (`object`)
Allocated on the stack with value semantics (copied by value on assignment):
```hinglish
banao Point = object
    x: float64
    y: float64
khatam
```

### 3. Managed Reference Objects (`ref object`)
Allocated on the heap with reference semantics managed by ORC:
```hinglish
banao Node = ref object
    data: string
    next: Node
khatam
```

---

## 🧠 DETERMINISTIC ORC MEMORY MODEL

```
     Stack Memory                    Heap Memory (ORC Managed)
┌────────────────────┐              ┌───────────────────────────┐
│ Pointer var (head) ├─────────────►│ Ref Node Object (val: 10) │
└────────────────────┘              │ [Ref Count = 1]           │
                                    └─────────────┬─────────────┘
                                                  │
                                                  ▼
                                    ┌───────────────────────────┐
                                    │ Ref Node Object (val: 20) │
                                    │ [Ref Count = 1]           │
                                    └───────────────────────────┘
```

> [!NOTE]
> When `head` goes out of scope or is set to `khali` / `nil`, ORC decrements the reference count and immediately frees heap allocation for both node objects without garbage collection pauses.

---

## 🧪 CODE EXAMPLES

### Comprehensive Types & Structs Demo (`types_demo.hg`)

```hinglish
// Enum Definition
banao ServerStatus = enum
    StatusOffline, StatusOnline, StatusMaintenance
khatam

// Ref Object Definition
banao ServiceHealth = ref object
    name: string
    status: ServerStatus
    latency_ms: float64
khatam

// Instantiate Reference Objects
rakho s1 = ServiceHealth(name: "Auth Service", status: StatusOnline, latency_ms: 12.4)
rakho s2 = ServiceHealth(name: "DB Service", status: StatusMaintenance, latency_ms: 0.0)

dikhao "Service Name:", s1.name, "| Status:", s1.status, "| Latency:", s1.latency_ms, "ms"
```

---

## 🔗 SEE ALSO

- **[Custom Structs (`banao` / `type`)](/docs/man/banao-type/)**: Struct definition details.
- **[C FFI Directives](/docs/man/c-ffi/)**: Mapping primitive C types.
