---
title: "Getting Started with Compound"
date: 2026-08-20
draft: false
---

# Compound Programming Language

**Compound** is a simple, highly expressive programming language designed for both non-technical beginners and developers. It supports two native dialect runtimes:
- **Hinglish (`hg`)**: Code naturally in Hindi + English phonetics (`rakho`, `dikhao`, `agar`, `toh`, `khatam`).
- **English (`eg`)**: Code in plain English (`create`, `show`, `if`, `do`, `done`).

Both dialects compile via **Nim** directly into **high-performance C binaries**, giving you Python-like ease of use paired with C-level execution speed!

---

## Installation & CLI Setup

The binaries `hg` and `eg` are installed in your path (`/home/narayanas/bin/`).

```bash
# Run a Hinglish file
hg run program.hg

# Compile a Hinglish file to native C binary
hg build program.hg

# View generated Nim/C glue code
hg parse program.hg
```

```bash
# Run an English file
eg run program.eg

# Compile an English file to native C binary
eg build program.eg

# View generated Nim/C glue code
eg parse program.eg
```

---

## Language Mode Headers

You can also specify the target mode inside the file header:
- `bhasha="hi"` or `lang="hi"` for Hinglish mode
- `bhasha="en"` or `lang="en"` for English mode
