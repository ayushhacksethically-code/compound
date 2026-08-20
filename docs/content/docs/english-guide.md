---
title: "English Syntax Guide (eg)"
date: 2026-08-20
draft: false
---

# English (`eg`) Language Guide

Plain English allows non-technical users to write clean code without complex syntax rules.

## Example Program

```english
lang="en"

create name = "Aman"
show "Welcome,", name

create counter = 1
repeat while counter is less than or equal to 3 do
    show "Current Step:", counter
    counter += 1
done

task add_numbers(a: int, b: int): int do
    give back a + b
done

create total = add_numbers(50, 100)
show "Total:", total
```
