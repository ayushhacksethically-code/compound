---
title: "kaam / task / function (Functions & Subroutines)"
date: 2026-08-20
draft: false
section: "man"
---

# MAN PAGE: Functions (`kaam` / `task` / `function` / `wapas` / `give back`)

## SYNOPSIS
- **Hinglish (`hg`)**: `kaam name(args): return_type toh` ... `wapas result` ... `khatam`
- **English (`eg`)**: `task name(args): return_type do` ... `give back result` ... `done`

## DESCRIPTION
Defines reusable subroutines with arguments and optional return values.

## EXAMPLES

### Hinglish:
```hinglish
kaam jod(a: int, b: int): int toh
    wapas a + b
khatam
```

### English:
```english
task add(a: int, b: int): int do
    give back a + b
done
```
