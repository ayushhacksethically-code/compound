---
title: "banao / type (Data Types & Structures)"
date: 2026-08-20
draft: false
section: "man"
---

# MAN PAGE: Custom Data Structures (`banao` / `type` / `object`)

## SYNOPSIS
- **Hinglish (`hg`)**:
  ```hinglish
  banao StructName = object
      field1: type1
      field2: type2
  khatam
  ```

- **English (`eg`)**:
  ```english
  type StructName = object
      field1: type1
      field2: type2
  done
  ```

## DESCRIPTION
Defines custom record/object structures with typed fields.

## EXAMPLES

### Hinglish:
```hinglish
banao User = object
    naam: string
    umar: int
khatam

rakho u = User(naam: "Rahul", umar: 20)
dikhao u.naam
```
