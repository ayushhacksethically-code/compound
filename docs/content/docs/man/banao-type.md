---
title: "banao / type (Custom Types & Structs)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Custom Types & Structs (`banao` / `type` / `make`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Equivalent**: Nim `type T = object` / `type T = ref object` ➔ C `struct` definition

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
// Stack-Allocated Object (Value Semantics)
banao ObjectName = object
    field1: Type1
    field2: Type2
khatam

// Heap-Allocated Managed Reference Object (Reference Semantics)
banao RefObjectName = ref object
    field1: Type1
    field2: Type2
khatam

// Enum Definition
banao EnumName = enum
    valA, valB, valC
khatam
```

### English Dialect (`.eg`)
```english
// Stack-Allocated Object (Value Semantics)
type ObjectName = object
    field1: Type1
    field2: Type2
done

// Alternative Synonym Syntax
make ObjectName = object
    field1: Type1
    field2: Type2
done
```

---

## 📝 DESCRIPTION

The `banao` / `type` / `make` keywords construct custom composite record structures (`object`), managed pointers (`ref object`), and enumerations (`enum`). 

Compound types are strongly typed at compile-time and translated directly to native C `struct` representations.

---

## ⚙️ VALUE SEMANTICS VS REFERENCE SEMANTICS

| Structure Type | Syntax (`.hg` / `.eg`) | Memory Allocation | Memory Cleanup Mechanism | Copy Semantics |
| :--- | :--- | :--- | :--- | :--- |
| **Value Object** | `object` | Stack / Inline in parent struct | Automatically popped on stack unwind | Copy-by-value (deep copy on assignment) |
| **Reference Object** | `ref object` | Heap | Atomic Reference Counting (ORC) | Copy-by-reference (pointer assignment) |
| **Enumeration** | `enum` | Stack (Integer ordinal) | Immediate stack cleanup | Copy-by-value (integer value) |

> [!NOTE]
> **Deterministic Cleanup**: When a `ref object` has zero references remaining, ORC immediately invokes its destructor, releasing heap allocation with zero latency pauses.

---

## ⚠️ EDGE CASES & MEMORY MANAGEMENT

> [!IMPORTANT]
> **Nil Pointer Checking**: Fields in `ref object` types default to `nil` (`khali`) until explicitly instantiated using the constructor `RefObjectName(...)` or `new(RefObjectName)`. Accessing fields on a `nil` handle triggers a runtime `NilAccessDefect` exception.

```hinglish
banao Node = ref object
    val: int
    next: Node
khatam

// Instantiating recursive ref object
rakho head = Node(val: 10, next: nil)
head.next = Node(val: 20, next: nil)
```

---

## 🧪 CODE EXAMPLES

### 1. Hinglish Dialect (`struct_demo.hg`)

```hinglish
// Define custom value object struct
banao GrahakAccount = object
    id: int
    naam: string
    balance: float64
    active: bool
khatam

// Instantiate value object
rakho acc1 = GrahakAccount(id: 1001, naam: "Rohan Sharma", balance: 45000.50, active: sahi)

dikhao "Account ID:", acc1.id
dikhao "Grahak Naam:", acc1.naam
dikhao "Kul Balance:", acc1.balance
```

### 2. English Dialect (`struct_demo.eg`)

```english
// Define custom object type
type UserProfile = object
    user_id: int64
    email: string
    role: string
done

// Define heap reference structure for graph node
make NetworkNode = ref object
    node_id: int
    address: string
done

keep user1 = UserProfile(user_id: 8849201, email: "user@example.com", role: "Administrator")
show "User ID:", user1.user_id, "Email:", user1.email, "Role:", user1.role
```

---

## 🔗 SEE ALSO

- **[Types & Data Structures Specification](/docs/man/types-and-structs/)**: Exhaustive reference of primitives, collections, and memory semantics.
- **[Variable Declarations (`rakho` / `create`)](/docs/man/rakho-create/)**: Initializing instances of custom object types.
