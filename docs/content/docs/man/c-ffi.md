---
title: "C Language FFI Integration (c_ka_kaam / c_func)"
date: 2026-08-21
weight: 1
draft: false
---

# MAN PAGE: C Language FFI Integration (`c_ka_kaam` / `c_func`)

## SYNOPSIS
- **Hinglish (`.hg`)**: `c_ka_kaam <fn_signature> [from "<header.h>"]`
- **English (`.eg`)**: `c_func <fn_signature> [from "<header.h>"]`

---

## DESCRIPTION

The Foreign Function Interface (FFI) engine in Compound enables zero-cost binding to standard C libraries (`libc`, `libm`, POSIX headers) as well as custom compiled C static/shared libraries. 

Because Compound compiles directly down to C source code, foreign C declarations transpile directly into `{.importc, header: ...}` Nim procedure annotations with zero runtime overhead or glue code.

---

## C ABI TYPE MAP

| C Type | Compound / Nim Type | Description |
| :--- | :--- | :--- |
| `int` | `cint` | C-compatible standard integer |
| `double` / `float` | `cdouble` / `cfloat` | C double/single-precision float |
| `char*` / `const char*` | `cstring` | Null-terminated C string pointer |
| `size_t` | `csize_t` | Architecture-native memory size type |
| `void*` / `int64_t*` | `ptr void` / `ptr int64` | Raw memory pointer |
| `uint32_t` / `uint64_t` | `uint32` / `uint64` | Fixed-width unsigned integer |

---

## HEADER IMPORT GRAMMAR

To bind a function from a system or local C header file, append `from "header_name.h"` or `from "<sys/header.h>"`:

### 1. Standard C Library Functions

#### Hinglish (`.hg`)
```hinglish
c_ka_kaam sin(x: cdouble): cdouble from "math.h"
c_ka_kaam cos(x: cdouble): cdouble from "math.h"
c_ka_kaam printf(fmt: cstring, val: cdouble): cint from "stdio.h"
c_ka_kaam malloc(size: csize_t): ptr void from "stdlib.h"
c_ka_kaam free(p: ptr void) from "stdlib.h"

rakho angle = 3.14159 / 2.0
rakho result = sin(angle)
printf("Sin result: %.4f\n", result)
```

#### English (`.eg`)
```english
c_func sin(x: cdouble): cdouble from "math.h"
c_func cos(x: cdouble): cdouble from "math.h"
c_func printf(fmt: cstring, val: cdouble): cint from "stdio.h"
c_func malloc(size: csize_t): ptr void from "stdlib.h"
c_func free(p: ptr void) from "stdlib.h"

keep angle = 3.14159 / 2.0
keep result = sin(angle)
printf("Sin result: %.4f\n", result)
```

---

## POINTER ARITHMETIC & RAW MEMORY INTEROP

Compound supports dereferencing and manipulating C pointers directly:

```hinglish
// Allocate 8 bytes on the C heap
rakho raw_ptr = cast[ptr int64](malloc(cast[csize_t](8)))

// Write value into dereferenced pointer location
raw_ptr[] = 999999999_i64
dikhao "Stored memory value:", raw_ptr[]

// Free memory allocation
free(cast[ptr void](raw_ptr))
```
