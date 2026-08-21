---
title: "Data Types & Structs (types-and-structs)"
date: 2026-08-21
weight: 3
draft: false
---

# MAN PAGE: Custom Types, Structs & Data Collections (`types-and-structs`)

## OVERVIEW

Compound supports primitive data types, custom structures (`object` and `ref object`), dynamic sequences (`seq[T]`), Hash Tables (`Table[K,V]`), and tuples.

---

## 1. CUSTOM OBJECT STRUCTS (`banao` / `type` / `make`)

Define custom data structures using `banao` (Hinglish) or `type` / `make` (English).

### Value Objects (`object`) vs Reference Objects (`ref object`)
- **`object`**: Value semantics. Stack allocated or nested directly inside parent structures. Copied on assignment.
- **`ref object`**: Managed heap reference. Deterministic ORC automatic memory management.

```hinglish
// Value object struct
banao Point = object
  x: float64
  y: float64
khatam

// Managed reference object struct (Heap allocated)
banao Node = ref object
  data: int
  next: Node
khatam

rakho p1 = Point(x: 10.0, y: 20.5)
rakho head = Node(data: 1, next: nil)
```

---

## 2. DYNAMIC SEQUENCES (`seq[T]`)

Dynamic arrays in Compound are represented as `seq[T]` with literal notation `@[...]`.

### Sequence Operations

| Operation | Syntax Example | Description |
| :--- | :--- | :--- |
| **Literal Creation** | `rakho s = @[1, 2, 3]` | Create pre-filled sequence |
| **Empty Alloc** | `rakho s = newSeq[string]()` | Initialize empty sequence |
| **Append** | `s.add("item")` | Append element to back |
| **Length** | `s.len` | Return number of elements |
| **Indexing** | `s[0]` | Access element by 0-based index |
| **Slicing** | `s[0..2]` | Extract sub-sequence slice |
| **Deletion** | `s.delete(index)` | Remove item at index |

```english
keep numbers = @[10, 20, 30, 40]
numbers.add(50)

show "Sequence Length:", numbers.len
show "First Item:", numbers[0]
show "Slice (0..2):", numbers[0..2]
```

---

## 3. HASH TABLES & MAPS (`Table[K, V]`)

Hash Tables provide key-value dictionary mappings, imported from `std/tables`.

```hinglish
shamil_karo std/tables

// Table creation via literal pair sequence
rakho kvMap = toTable({"user1": 101, "user2": 102})

// Table creation via initTable
rakho cache = initTable[string, string]()
cache["session_id_101"] = "active"

// Verification & Lookup
agar cache.hasKey("session_id_101") toh
  dikhao "Session Status:", cache["session_id_101"]
khatam

dikhao "Total Cache Entries:", cache.len
```

---

## 4. TUPLES & DESTRUCTURING

Tuples allow grouping heterogeneous data elements without defining a formal struct type.

```hinglish
// Tuple definition and destructuring
rakho record = (1001, "Prod_Server", true)
rakho (server_id, server_name, is_active) = record

dikhao "Server ID:", server_id
dikhao "Server Name:", server_name
dikhao "Active State:", is_active
```
