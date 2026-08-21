# 🚀 50 Real-World Project Ideas for Compound (`hg` / `eg`)

This catalog showcases **50 real-world project ideas** categorized into 5 core domains, specifically designed to leverage Compound's unique strengths: **C-level compilation speed**, **direct shell pipeline automation**, **deterministic ORC memory management**, and **dual Hinglish/English syntax ergonomics**.

---

## 🛠️ I. DevOps, Cloud & Infrastructure Automation (1–10)

1. **Container Life-Cycle Cleaner:** Periodically audits running/stopped Docker containers via `$ "docker ps -a"` and purges untagged dangling images with zero memory buildup.
2. **Linux Daemon Watchdog:** Background monitor that checks `systemctl` service statuses and restarts unresponsive processes with backoff alerts.
3. **Log Stream Rotator & Gzip Archiver:** High-speed log parser that monitors `/var/log`, splits files on size boundaries, and compresses them via native C zlib/gzip bindings.
4. **Git Workspace Synchronizer:** Scans directories for untracked changes across multiple repos and runs batch pull/fetch routines.
5. **Static Site Deployer:** Watches a markdown folder, renders static HTML via native templates, and deploys to remote servers over SSH/rsync.
6. **Zero-Downtime Blue-Green Deployment Orchestrator:** Swaps Nginx reverse proxy symlinks and triggers reload commands upon successful health-check responses.
7. **Automated SSL Certificate Renewal Agent:** Checks domain certificate expiration dates via OpenSSL commands and automates Let's Encrypt renewal cycles.
8. **Multi-Server SSH Command Dispatcher:** Uses async non-blocking sockets to execute diagnostic commands concurrently across an array of remote nodes.
9. **Firewall Rule Synthesizer:** Reads declarative configuration files and applies generated `iptables`/`nftables` rulesets with automatic validation.
10. **Environment Parity Verifier:** Audits production server dependencies (package versions, kernel parameters, env vars) against a staging baseline.

---

## 💻 II. Systems Programming & OS Utilities (11–20)

11. **Live CLI Task Manager (`htop` clone):** Parses `/proc` filesystems directly into native structs to display real-time CPU, RAM, and process trees.
12. **Fast File Content Searcher (`grep`/`ripgrep` clone):** Multi-threaded keyword search utility scanning gigabytes of text using memory-mapped buffers.
13. **Disk Space Analyzer (`du` clone):** Recursive directory tree scanner that calculates folder sizes and highlights large storage hogs.
14. **Process File-Handle Auditor:** Inspects open sockets and file descriptors per PID via `/proc/[pid]/fd` mappings.
15. **System Hardware Profiler:** Extracts CPU topology, RAM channels, and PCI/USB devices via `lshw`/`sysfs` into clean JSON/text formats.
16. **High-Speed File Deduplicator:** Computes chunked SHA-256 hashes of files across drives to identify and hard-link duplicate files.
17. **Serial Port Terminal Reader:** Binds POSIX termios C headers to read and log telemetry streams from connected microcontrollers (e.g., Arduino/ESP32).
18. **Custom Cron/Task Scheduler Daemon:** Standalone, lightweight cron alternative parsing crontab syntax with millisecond execution precision.
19. **Linux Cgroup Resource Limiter:** Configures and monitors memory/CPU limits for child processes using Linux cgroups v2.
20. **Virtual Memory Page Inspector:** Inspects process virtual memory mappings using `/proc/[pid]/maps` and native pointer inspection.

---

## 🌐 III. Networking, APIs & Microservices (21–30)

21. **High-Concurrency Async HTTP Web Server:** Serves static assets and dynamic REST endpoints using non-blocking socket dispatch (`std/asyncnet`).
22. **Reverse Proxy & Layer 4 TCP Load Balancer:** Distributes inbound TCP connections across multiple upstream application servers.
23. **Fast Port Scanner (`nmap` clone):** Concurrently scans thousands of TCP/UDP ports using non-blocking asynchronous connection probes.
24. **Dynamic DNS (DDNS) Updater Daemon:** Periodically checks WAN IP changes and calls cloud DNS provider APIs to update A-records.
25. **Custom DNS Cache Server:** Listens on UDP port 53, resolves queries to upstream nameservers, and caches responses in a high-speed hash table.
26. **WebSocket Live Chat Server:** Manages persistent full-duplex socket connections to broadcast messages across connected rooms.
27. **Microservice Health Prober & Uptime Dashboard:** Asynchronously pings HTTP, TCP, and gRPC endpoints and records latency metrics.
28. **Static Binary Asset CDN:** In-memory caching reverse proxy that serves cached files with ultra-low response latency.
29. **Bandwidth & Network Interface Monitor:** Polls `/proc/net/dev` to calculate and graph real-time upload/download speeds.
30. **Simple Key-Value Store over TCP (Mini-Redis):** In-memory database supporting GET, SET, DEL, and EXPIRE commands over plain TCP sockets.

---

## 🔬 IV. Data Processing & Compilers/Tooling (31–40)

31. **Self-Hosted Markdown to HTML Converter:** Recursive-descent parser that transforms markdown formatting into clean semantic HTML markup.
32. **Custom JSON Stream Parser & Transformer:** High-throughput streaming parser processing large multi-gigabyte `.jsonl` dumps without loading everything into RAM.
33. **CSV/TSV Querying Engine:** SQL-like command-line query engine filtering, sorting, and aggregating tabular text files.
34. **Self-Hosted Compound Formatter (`hg fmt`):** Lexes `.hg` and `.eg` source files to format indentations, spacing, and keyword casing cleanly.
35. **AST Visualizer & Dependency Grapher:** Parses Compound code to generate visual Graphviz DOT diagrams of procedural calls and module imports.
36. **Docstring Generator (`hg doc`):** Extracts comments, function signatures, and struct definitions into static HTML documentation sites.
37. **Time-Series Metric Aggregator:** Collects server load samples, computes moving averages/percentiles, and writes downsampled metrics.
38. **Regular Expression / Pattern Matching Engine:** Simple NFA/DFA-based regex evaluation engine built on native pattern matching.
39. **Bytecode Virtual Machine:** A simple stack-based VM and custom instruction assembler built in pure `.hg`.
40. **Multi-Dialect Translation Tool:** Bidirectional translator converting `.hg` (Hinglish) files to `.eg` (Plain English) and vice versa.

---

## 🎮 V. Graphics, Game Dev & Scientific Computing (41–50)

41. **Raylib 2D Arcade Game (e.g., Space Invaders):** Direct C FFI binding to `raylib.h` for window handling, sprite rendering, and collision math.
42. **3D Raytracer / Path Tracer:** Multi-threaded CPU renderer computing sphere intersections, light reflections, and anti-aliased image outputs (`.ppm`).
43. **Mandelbrot & Julia Set Fractal Generator:** High-performance numeric engine generating complex-number fractal bitmaps.
44. **N-Body Gravitational Physics Simulator:** Simulates gravitational interactions between thousands of particles using vector math.
45. **Chip-8 Retro Hardware Emulator:** Emulates CPU registers, opcode execution, keypad input, and monochrome graphics for 1970s Chip-8 ROMs.
46. **Audio Waveform Synthesizer:** Direct C FFI binding to ALSA/PulseAudio to generate pure sine, square, and sawtooth tone frequencies.
47. **Cellular Automata Engine (Conway's Game of Life):** High-speed 2D grid matrix simulation rendered in terminal ANSI color blocks.
48. **Linear Algebra & Matrix Operations Library:** Fast matrix inversion, dot products, and eigenvalues calculation with direct C math bindings.
49. **Terminal ASCII Image/Video Viewer:** Decodes image/video frames via FFmpeg CLI pipes and renders color-coded ASCII representations.
50. **SQLite Database CLI Shell:** Direct binding to `sqlite3.h` providing an interactive command-line interface for running queries and viewing tables.
