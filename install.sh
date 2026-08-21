#!/usr/bin/env bash
set -e

echo "📦 Building & Installing Compound Compiler Toolchain (hg / eg)..."

# 1. Compile release binary with speed optimizations & ORC deterministic memory
nim c -d:release --mm:orc --opt:speed compound.nim

# 2. Install binaries to user local bin directory (~/bin)
mkdir -p "$HOME/bin"
cp compound "$HOME/bin/hg"
cp compound "$HOME/bin/eg"

echo "=========================================================="
echo "✅ Compound installed successfully!"
echo "   • Binary location: $HOME/bin/hg"
echo "   • Symlink location: $HOME/bin/eg"
echo "   • Run 'hg run demo.hg' or 'eg run demo_en.eg' to test."
echo "=========================================================="
