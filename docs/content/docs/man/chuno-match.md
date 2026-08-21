---
title: "chuno / match / switch (Pattern Matching)"
date: 2026-08-20
draft: false
section: "man"
---

# MAN PAGE: Pattern Matching (`chuno` / `match` / `switch` / `jab` / `case`)

## SYNOPSIS
- **Hinglish (`hg`)**:
  ```hinglish
  chuno variable toh
      jab value1 toh
          // code
      jab value2 toh
          // code
      varna toh
          // default code
  khatam
  ```

- **English (`eg`)**:
  ```english
  match variable do
      case value1 do
          // code
      case value2 do
          // code
      otherwise do
          // default code
  done
  ```

## DESCRIPTION
Multi-way branching syntax based on variable values.

## EXAMPLES

### Hinglish:
```hinglish
rakho din = 1
chuno din toh
    jab 1 toh
        dikhao "Somvaar"
    varna toh
        dikhao "Koyi aur din"
khatam
```
