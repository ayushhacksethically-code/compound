---
title: "koshish_karo / try (Error Handling)"
date: 2026-08-20
draft: false
section: "man"
---

# MAN PAGE: Error Handling (`koshish_karo` / `try` / `galti_pakdo` / `catch` / `aakhir_mein` / `finally`)

## SYNOPSIS
- **Hinglish (`hg`)**:
  ```hinglish
  koshish_karo toh
      // dangerous code
  galti_pakdo toh
      // handle error
  aakhir_mein toh
      // cleanup code
  khatam
  ```

- **English (`eg`)**:
  ```english
  try do
      // dangerous code
  catch do
      // handle error
  finally do
      // cleanup code
  done
  ```

## DESCRIPTION
Handles exceptions gracefully without crashing the application.

## EXAMPLES

### Hinglish:
```hinglish
koshish_karo toh
    dikhao 10 / 0
galti_pakdo toh
    dikhao "Zero se divide nahi kar sakte!"
aakhir_mein toh
    dikhao "Hamesha chalega"
khatam
```
