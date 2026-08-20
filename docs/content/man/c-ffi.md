---
title: "c_ka_kaam / c_func (C Language FFI Integration)"
date: 2026-08-20
draft: false
section: "man"
---

# MAN PAGE: C Language Integration (`c_ka_kaam` / `c_func`)

## SYNOPSIS
- **Hinglish (`hg`)**: `c_ka_kaam fnSignature from "header.h"`
- **English (`eg`)**: `c_func fnSignature from "header.h"`

## DESCRIPTION
Directly imports and calls functions from standard C libraries (`stdio.h`, `stdlib.h`, `math.h`) or custom compiled C code without writing glue logic.

## EXAMPLES

### Hinglish:
```hinglish
c_ka_kaam puts(s: cstring): cint from "stdio.h"
puts("Namaste C Ecosystem!")
```
