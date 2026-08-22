---
title: "VS Code Tooling & IDE Extension"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: VS Code Extension & Language Tooling (`vscode-tooling`)

> **Location**: `vscode-compound/`  
> **Package Artifact**: `vscode-compound/compound-lang-1.1.0.vsix`

---

## 📖 OVERVIEW & TOOLING CAPABILITIES

The **Compound VS Code Extension** (`compound-lang`) brings syntax highlighting, execution engine integration, auto-indentation, bracket matching, code folding, and snippet completions for both **Hinglish (`.hg`)** and **English (`.eg`)** dialects in Visual Studio Code and VSCodium IDE environments.

---

## ⚙️ FEATURES & CONFIGURATION

### Language Support Matrix

| Dialect | Extension | Language Identifier | Grammar Definition |
| :--- | :--- | :--- | :--- |
| **Hinglish** | `.hg` | `hinglish` | `syntaxes/hinglish.tmLanguage.json` |
| **English** | `.eg` | `english` | `syntaxes/english.tmLanguage.json` |

### Key Features
1. **▶️ One-Click Run Button (`editor/title`)**: Adds a top-right Play icon button in VS Code editor to execute open `.hg` or `.eg` files directly in an integrated Compound terminal.
2. **🖱️ Right-Click Context Menu**: Right-click anywhere in the editor to select **"Run Compound File"** or **"Build Compound Native Binary"**.
3. **⌨️ Keyboard Shortcuts**:
   - `Ctrl+Alt+R` (`Cmd+Alt+R` on macOS): Save & Run active Compound file.
   - `Ctrl+Alt+B` (`Cmd+Alt+B` on macOS): Build native executable binary.
4. **Dual-Dialect Syntax Highlighting**: Colorizes keywords (`rakho`, `keep`, `agar`, `if`, `kaam`, `task`, `c_ka_kaam`, `c_func`), string literals, comments (`//` and `#`), and numeric literals.
5. **Auto-Closing Brackets & Indentation**: Auto-indents after block openers (`toh`, `do`, `:`) and un-indents upon typing `khatam`, `bas`, `done`, or `end`.

---

## 🛠️ INSTALLATION & SETUP GUIDE

### Installing Pre-Built `.vsix` Package

To install the VS Code extension package directly into your VS Code editor:

```bash
code --install-extension vscode-compound/compound-lang-1.1.0.vsix
```

Alternatively, in VS Code:
1. Open the Extensions View (`Ctrl+Shift+X` / `Cmd+Shift+X`).
2. Click the `...` (More Actions) menu in the top-right corner.
3. Select **Install from VSIX...**
4. Choose `/home/narayanas/projects/compound/vscode-compound/compound-lang-1.0.0.vsix`.

---

## 🔗 SEE ALSO

- **[Getting Started Guide](/docs/getting-started/)**: Setting up the Compound CLI environment.
- **[Interactive REPL Guide](/docs/getting-started/#-interactive-repl-shell-deep-dive)**: Using the interactive shell.
