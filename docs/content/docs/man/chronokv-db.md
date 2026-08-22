---
title: "ChronoKV Database Architecture"
date: 2026-08-21
draft: false
section: "man"
---

# MAN PAGE: ChronoKV Embedded & Distributed Storage Engine (`chronokv`)

> **Implementation Files**: `chronokv/storage.hg`, `chronokv/server.hg`, `chronokv/raft.hg`, `chronokv/bench.hg`  
> **Engine Architecture**: Production LSM-Tree (Log-Structured Merge-tree) with MemTable, SSTables, WAL, and Raft Consensus Protocol

---

## 📖 OVERVIEW & ARCHITECTURE

**ChronoKV** is high-performance, embedded key-value and distributed consensus storage engine written in Compound (`.hg`). It combines an **LSM-Tree write-path architecture** with a **Raft distributed consensus state machine** for high-throughput write performance, crash recovery, and multi-node linearizable consistency.

```
┌────────────────────────────────────────────────────────┐
│               ChronoKV Client / API                    │
└───────────────────────────┬────────────────────────────┘
                            │
            storage_put()   │   storage_get()
                            ▼
┌────────────────────────────────────────────────────────┐
│                   MemTable (RAM)                       │
│    - Hash Table key-value cache (Table[string, string])│
│    - Threshold limit: 500 entries (memThreshold)       │
└───────────┬────────────────────────────────────────────┘
            │ (Flush when MemTable >= memThreshold)
            ▼
┌────────────────────────────────────────────────────────┐
│            SSTable Disk Storage Engine                 │
│  - /tmp/chronokv_sst_1.dat                             │
│  - /tmp/chronokv_sst_2.dat                             │
│  - /tmp/chronokv_sst_N.dat                             │
│  (Scanned in reverse chronological order N -> 1)       │
└────────────────────────────────────────────────────────┘
```

---

## ⚙️ CORE MODULE COMPONENTS

### 1. Storage Engine (`chronokv/storage.hg`)
- **MemTable**: In-memory hash table buffer (`initTable[string, string]()`).
- **SSTable Flush (`storage_flush_sstable()`)**: Automatically serializes MemTable entries to sequential disk files (`/tmp/chronokv_sst_<count>.dat`) when the `memThreshold` (500 keys) is exceeded.
- **Read Path (`storage_get(key)`)**:
  1. Checks active RAM **MemTable** first for lowest latency.
  2. If missing, scans flushed **SSTables** on disk in reverse chronological order (newest SSTable file to oldest).
  3. Returns `"(nil)"` if key is not found.

### 2. Raft Distributed Consensus Engine (`chronokv/raft.hg`)
- **Node States**: `Leader`, `Follower`, `Candidate`.
- **Term Management**: Monotonic term counter `currentTerm`, leader heartbeat polling, and majority vote quorum collection.
- **Replication**: Replicates key-value operations across cluster nodes prior to committing state machine writes.

### 3. Server Interface & Benchmarks (`chronokv/server.hg`, `chronokv/bench.hg`)
- Non-blocking socket listener handling `PUT <key> <val>`, `GET <key>`, `FLUSH`, and `STATS` commands.

---

## 💡 API REFERENCE & SIGNATURES

### `storage_put(key: string, val: string)`
- **Parameters**: `key` (string), `val` (string).
- **Return Value**: None.
- **Description**: Inserts or updates key in active RAM MemTable. Triggers automatic disk SSTable flush if MemTable size exceeds `memThreshold`.

### `storage_get(key: string): string`
- **Parameters**: `key` (string).
- **Return Value**: `string` value associated with key, or `"(nil)"` if non-existent.
- **Description**: Queries RAM MemTable followed by disk SSTable files in reverse order.

### `storage_flush_sstable()`
- **Parameters**: None.
- **Return Value**: None.
- **Description**: Forces immediate serialization of RAM MemTable to new SSTable disk file and clears memory buffer.

---

## ⚠️ PERFORMANCE & RECOVERY MECHANICS

> [!NOTE]
> **Write Performance**: All writes (`storage_put`) execute in $O(1)$ amortized time by inserting directly into RAM MemTable. Disk writes occur sequentially during batch SSTable flushes, maximizing disk I/O throughput.

> [!IMPORTANT]
> **Crash Recovery**: During node boot, ChronoKV scans existing SSTable files on disk to reconstruct key-value index state without data loss.

---

## 🧪 CODE EXAMPLE

### LSM-Tree Disk Recovery & Query Demo (`chronokv_demo.hg`)

```hinglish
shamil_karo tables, os, strutils

// Import ChronoKV storage engine logic
rakho memTable = initTable[string, string]()
rakho memThreshold = 500
rakho sstCount = 0

kaam storage_flush_sstable() toh
    sstCount += 1
    rakho sstFile = "/tmp/chronokv_sst_" & $sstCount & ".dat"
    rakho content = ""
    har k, v mein memTable toh
        content.add(k & "=" & v & "\n")
    khatam
    writeFile(sstFile, content)
    memTable.clear()
khatam

kaam storage_put(key: string, val: string) toh
    memTable[key] = val
    agar memTable.len >= memThreshold toh
        storage_flush_sstable()
    khatam
khatam

kaam storage_get(key: string): string toh
    agar memTable.hasKey(key) toh
        wapas memTable[key]
    khatam
    har i mein countdown(sstCount, 1) toh
        rakho sstFile = "/tmp/chronokv_sst_" & $i & ".dat"
        agar fileExists(sstFile) toh
            rakho lines = readFile(sstFile).splitLines()
            har line mein lines toh
                agar "=" in line toh
                    rakho parts = line.split("=")
                    agar parts[0] == key toh
                        wapas parts[1]
                    khatam
                khatam
            khatam
        khatam
    khatam
    wapas "(nil)"
khatam

// Test storage PUT, Flush, and Retrieval
storage_put("db_user_1001", "Narayana")
storage_flush_sstable()  // Persist to disk

dikhao "Queried Key 'db_user_1001' from SSTable Disk ->", storage_get("db_user_1001")
```

---

## 🔗 SEE ALSO

- **[Standard Library Reference](/docs/man/stdlib-reference/)**: `std/tables` and filesystem I/O modules.
- **[Structs & Object Definition](/docs/man/banao-type/)**: Data type definitions for storage records.
