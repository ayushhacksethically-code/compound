---
title: "agar / if (Conditionals & Branching)"
date: 2026-08-20
draft: false
section: "man"
---

# MAN PAGE: Conditionals (`agar` / `if` / `varna` / `otherwise`)

## SYNOPSIS
- **Hinglish (`hg`)**:
  ```hinglish
  agar condition toh
      // code
  varna agar condition toh
      // code
  varna
      // code
  khatam
  ```

- **English (`eg`)**:
  ```english
  if condition do
      // code
  otherwise if condition do
      // code
  otherwise
      // code
  done
  ```

## DESCRIPTION
Executes blocks conditionally. Blocks are closed using `khatam` / `bas` in Hinglish or `done` / `end` in English.

## EXAMPLES

### Hinglish:
```hinglish
agar umar bada hai 18 se toh
    dikhao "Adult"
varna
    dikhao "Minor"
khatam
```
