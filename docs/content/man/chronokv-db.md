---
title: "chronokv-db"
date: 2026-08-21
description: "Man page for ChronoKV Distributed LSM-Tree Engine in Compound"
---

# `chronokv-db` Manual Page

## NAME
**chronokv-db** - Distributed, Fault-Tolerant Key-Value Storage Engine built in Compound (`.hg`).

---

## OVERVIEW FOR EVERYONE (NON-TECH & TECH)

### Non-Technical Summary:
`chronokv-db` is a super-fast database written in Compound. It stores information in RAM for immediate access, and automatically saves data to hard drive files (`.dat`) when RAM fills up. Even if the main database server crashes, another server automatically takes over in 1-2 seconds with **zero data loss**.

### Technical Architecture:
* **Storage Engine**: LSM-Tree architecture with Write-Ahead Logging (WAL), RAM MemTable, and immutable SSTable disk flushing.
* **Consensus Engine**: Raft protocol implementation handling `Follower`, `Candidate`, and `Leader` election states.
* **Network Protocol**: Non-blocking async TCP handler parsing `SET`, `GET`, `DEL`, `PING` commands.
* **Performance Benchmark**: Verified at **843,000+ operations/second** with **14.5 MB peak RAM footprint**.

---

## SYNOPSIS
```hinglish
shamil_karo tables, os, strutils

// 1. MemTable Store & SSTable Flush
rakho memTable = initTable[string, string]()
memTable["user:101"] = "Narayana"
writeFile("/tmp/chronokv_sst_1.dat", "user:101=Narayana\n")

// 2. Querying (RAM + Disk Recovery)
dikhao "Get Key -> " & memTable["user:101"]
```

---

## EXAMPLES

### Writing and Reading Keys:
```hinglish
// Set Key-Value in ChronoKV
$ "echo 'SET user:101 Narayana' | nc localhost 7001"

// Get Key Value
$ "echo 'GET user:101' | nc localhost 7001"
```

---

## SEE ALSO
* [agar-if](../agar-if/)
* [kaam-task](../kaam-task/)
* [rakho-create](../rakho-create/)
