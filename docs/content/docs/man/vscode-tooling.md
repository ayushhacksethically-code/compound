---
title: "vscode-tooling"
date: 2026-08-21
description: "Man page for Compound VS Code Extension (.vsix) and Tooling"
---

# `vscode-tooling` Manual Page

## NAME
**vscode-tooling** - Official Visual Studio Code Extension and Language Tooling for Compound (`.hg` / `.eg`).

---

## OVERVIEW FOR EVERYONE (NON-TECH & TECH)

### Non-Technical Summary:
`vscode-tooling` makes writing Compound code easy by bringing colorful syntax highlighting, auto-indentation, and bracket completion into VS Code. It automatically recognizes both Hinglish (`.hg`) and English (`.eg`) files.

### Technical Architecture:
* **TextMate Grammars**: `hinglish.tmLanguage.json` and `english.tmLanguage.json` defining token scopes for keywords (`rakho`, `keep`, `agar`, `if`), strings, booleans, and shell commands (`$`).
* **Extension Package**: Packaged as a standalone VSIX file (`vscode-compound/compound-lang-1.0.0.vsix`).

---

## SYNOPSIS
```bash
# Install VSIX Extension in VS Code
code --install-extension /home/narayanas/projects/compound/vscode-compound/compound-lang-1.0.0.vsix
```

---

## FEATURES
* **Auto Indentation**: Automatically indents after `toh`, `do`, `agar`, `kaam`, `task` and un-indents after `khatam`, `bas`, `done`, `end`.
* **String Protection**: Prevents syntax coloring errors inside quoted strings.
* **Subshell Highlighting**: Special color highlighting for direct shell command lines (`$ "docker ps"`).

---

## SEE ALSO
* [chronokv-db](../chronokv-db/)
* [shamil-import](../shamil-import/)
