---
title: "C FFI Integration (c_ka_kaam / c_func)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Foreign Function Interface to C (`c_ka_kaam` / `c_func`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: Nim `proc name(...) {.importc, header: "header.h", discardable.}` ➔ Direct C header inclusion & ABI binding

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
c_ka_kaam function_name(param1: Type1, param2: Type2): ReturnType from "header.h"
c_ka_kaam function_name(param1: Type1): ReturnType
```

### English Dialect (`.eg`)
```english
c_func function_name(param1: Type1, param2: Type2): ReturnType from "header.h"
c_func function_name(param1: Type1): ReturnType
```

---

## 📝 DESCRIPTION

The `c_ka_kaam` / `c_func` directives bind C standard library functions, operating system APIs (POSIX, Win32), and third-party static/shared C libraries (`.a`, `.so`, `.dll`, `.dylib`) directly into Compound programs with **zero binding overhead**.

When `from "header.h"` is specified, the transpiler generates Nim code annotated with `{.header: "header.h".}`, causing GCC/Clang to `#include <header.h>` directly in the compiled C intermediate file.

---

## ⚙️ C TYPE MAPPING MATRIX

| Compound / Nim Type | Equivalent C Type | Size / Description |
| :--- | :--- | :--- |
| `cint` | `int` | Standard C signed integer |
| `cuint` | `unsigned int` | Standard C unsigned integer |
| `cschar` / `cchar` | `char` | C char byte |
| `cstring` | `char*` or `const char*` | Null-terminated C string pointer |
| `cdouble` | `double` | 64-bit IEEE 754 floating point |
| `cfloat` | `float` | 32-bit IEEE 754 floating point |
| `pointer` | `void*` | Generic opaque untyped raw memory pointer |
| `clong` | `long` | C long integer |
| `culong` | `unsigned long` | C unsigned long integer |

---

## 💡 IMPLEMENTATION & PERFORMANCE MECHANICS

- **Zero Wrapper Overhead**: Calling a `c_ka_kaam` function compiles to a direct C function call (`puts("hello")`) in generated C code—no runtime marshalling layer or dynamic lookup table is involved.
- **`{.discardable.}` Pragma**: FFI function declarations carry Nim's `{.discardable.}` pragma, enabling callers to invoke functions returning error integer codes (like `puts` or `printf`) without assigning or discarding their return value explicitly.

---

## ⚠️ EDGE CASES, STRING CONVERSION & MEMORY SAFETY

> [!IMPORTANT]
> **Compound `string` vs C `cstring`**: Compound `string` is a GC/ORC-managed dynamic string structure with length header. C functions expect a null-terminated `cstring` (`const char*`). Automatically convert `string` to `cstring` using `cstring(my_string)` when passing values into C FFI calls!

> [!CAUTION]
> **Pointer Lifetime**: Pointers returned from C functions (such as `malloc` or `fopen`) are owned by the C runtime. Ensure manual deallocation (`free` / `fclose`) or wrap them in Compound destructor routines to prevent native heap memory leaks.

---

## 🧪 CODE EXAMPLES

### 1. Binding C Math & Stdio Functions (`ffi_demo.hg`)

```hinglish
// Bind standard C library functions
c_ka_kaam puts(s: cstring): cint from "stdio.h"
c_ka_kaam sqrt(x: cdouble): cdouble from "math.h"
c_ka_kaam pow(x: cdouble, y: cdouble): cdouble from "math.h"

puts("Namaste C Standard Library se!")

rakho val = 25.0
rakho sq = sqrt(val)
dikhao "Square root of 25.0 =", sq

rakho p = pow(2.0, 10.0)
dikhao "2.0 ^ 10.0 =", p
```

### 2. POSIX System Call Binding in English (`ffi_demo.eg`)

```english
// Import POSIX C system calls
c_func getpid(): cint from "unistd.h"
c_func getuid(): cuint from "unistd.h"

keep process_id = getpid()
keep user_id = getuid()

show "Current Process PID:", process_id
show "Executing User UID:", user_id
```

---

## 🔗 SEE ALSO

- **[Standard Library Reference](/docs/man/stdlib-reference/)**: Pre-packaged Compound wrappers around system libraries.
- **[Shell & Subshell Integration](/docs/man/shell-powershell/)**: Subprocess CLI execution alternatives.
