---
title: "dikhao / show (Console Input & Output)"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: Console I/O (`dikhao` / `show` / `pucho` / `ask`)

> **Dialects**: Hinglish (`.hg`) & English (`.eg`)  
> **Backend Transpilation**: Nim `echo` & `readLine(stdin)` ➔ C `printf` & `fgets`

---

## 📖 SYNOPSIS

### Hinglish Dialect (`.hg`)
```hinglish
// Output to stdout
dikhao expr1, expr2, expr3

// Input from stdin
rakho user_input = pucho()
```

### English Dialect (`.eg`)
```english
// Output to stdout
show expr1, expr2, expr3
print expr1, expr2, expr3

// Input from stdin
keep user_input = ask()
keep user_input = input()
```

---

## 📝 DESCRIPTION

The console I/O directives manage standard input (`stdin`) and standard output (`stdout`) operations.

- **`dikhao` / `show` / `print`**: Accepts multiple comma-separated arguments of arbitrary types (`string`, `int`, `float`, `bool`, objects), formats them with space separation, and appends a trailing newline.
- **`pucho()` / `ask()` / `input()`**: Reads a line of text from standard input (`stdin`) up to the newline character and returns it as a Compound `string`.

---

## ⚙️ SYNTAX & PARAMETERS

| Parameter | Type | Required? | Description |
| :--- | :--- | :--- | :--- |
| **`expr1, expr2, ...`** | Any printable type | Yes | One or more values to print. Objects and numbers are stringified automatically. |
| **Return Value (`pucho` / `ask`)** | `string` | N/A | Returns line string read from `stdin`. Raises `EOFError` if end-of-file is reached. |

---

## 💡 IMPLEMENTATION & PERFORMANCE NOTES

- **Varargs Stringification**: `dikhao` transpiles to Nim's `echo`, which invokes dollar-operator (`$`) stringifiers on non-string arguments prior to writing to `stdout`.
- **String Concatenation (`&`)**: String concatenation inside print expressions (`show "A" & "B"`) uses fast memory allocation without temporary string leaks.

---

## ⚠️ EDGE CASES & ERROR HANDLING

> [!WARNING]
> **Terminal EOF & Pipeline Redirection**: Calling `pucho()` or `ask()` when `stdin` is redirected from an empty file or closed stream raises an `EOFError`. Wrap interactive inputs in `koshish_karo` / `try` blocks when reading from external command pipelines.

---

## 🧪 CODE EXAMPLES

### 1. Hinglish Console I/O (`io_demo.hg`)

```hinglish
dikhao "=== Compound User Registration System ==="
dikhao "Kripya apna naam darj karein:"

// Read input line from terminal stdin
rakho naam = pucho()

dikhao "Kripya apni umar darj karein:"
rakho umar_str = pucho()
rakho umar = parseInt(umar_str)

dikhao "Dhanyavaad!", naam, "| Umra:", umar, "| Registered Status:", sahi
```

### 2. English Console I/O (`io_demo.eg`)

```english
import std/strutils

show "=== Application Configuration Shell ==="
show "Enter system hostname:"

keep host = ask()

show "Enter server port number:"
keep port_text = input()
keep port = parseInt(strip(port_text))

show "Configuring Server -> Host:", host, "Port:", port
```

---

## 🔗 SEE ALSO

- **[Standard Library Reference](/docs/man/stdlib-reference/)**: `std/strutils` string parsing utilities.
- **[Variables & Scope](/docs/man/rakho-create/)**: Storing user input values.
