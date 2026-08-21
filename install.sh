#!/usr/bin/env bash
# ============================================================================
# Compound Language (.eg / .hg) - One-Line Toolchain Installer
# Usage: curl -fsSL https://compound-lang.org/install.sh | bash
# ============================================================================
set -e

COMPOUND_HOME="${COMPOUND_HOME:-$HOME/.compound}"
BIN_DIR="$COMPOUND_HOME/bin"
STDLIB_DIR="$COMPOUND_HOME/stdlib"
CACHE_DIR="$COMPOUND_HOME/cache"

echo "=========================================================="
echo "🚀 Compound Programming Language Toolchain Installer"
echo "=========================================================="

mkdir -p "$BIN_DIR" "$STDLIB_DIR" "$CACHE_DIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Compile or copy release binary
if [ -f "$SCRIPT_DIR/compound.nim" ]; then
    echo "📦 Building standalone release binary..."
    nim c -d:release --mm:orc --opt:speed "$SCRIPT_DIR/compound.nim"
    cp "$SCRIPT_DIR/compound" "$BIN_DIR/compound"
elif [ -f "$SCRIPT_DIR/compound" ]; then
    cp "$SCRIPT_DIR/compound" "$BIN_DIR/compound"
fi

# Create alias symlinks for hg & eg
ln -sf "$BIN_DIR/compound" "$BIN_DIR/hg"
ln -sf "$BIN_DIR/compound" "$BIN_DIR/eg"

# 2. Copy Standard Library modules if present
if [ -d "$SCRIPT_DIR/stdlib" ]; then
    cp -r "$SCRIPT_DIR/stdlib/"* "$STDLIB_DIR/"
fi

# 3. PATH Environment Update
SHELL_PROFILE=""
if [ -n "$BASH_VERSION" ]; then
    SHELL_PROFILE="$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    SHELL_PROFILE="$HOME/.zshrc"
else
    SHELL_PROFILE="$HOME/.profile"
fi

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "⚙️ Adding $BIN_DIR to $SHELL_PROFILE..."
    echo "" >> "$SHELL_PROFILE"
    echo "# Compound Language Toolchain" >> "$SHELL_PROFILE"
    echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$SHELL_PROFILE"
fi

export PATH="$PATH:$BIN_DIR"

echo "=========================================================="
echo "✅ Compound installed successfully!"
echo "   • Environment Root: $COMPOUND_HOME"
echo "   • Binary Location:  $BIN_DIR/compound"
echo "   • Aliases:          $BIN_DIR/hg , $BIN_DIR/eg"
echo ""
echo "Quick Start:"
echo "   1. compound init my_app"
echo "   2. compound run my_app/src/main.eg"
echo "=========================================================="
