# ============================================================================
# Compound Language (.eg / .hg) - Windows PowerShell Installer
# Usage: irm https://compound-lang.org/install.ps1 | iex
# ============================================================================
$ErrorActionPreference = 'Stop'

$CompoundHome = Join-Path $HOME ".compound"
$BinDir = Join-Path $CompoundHome "bin"
$StdlibDir = Join-Path $CompoundHome "stdlib"
$CacheDir = Join-Path $CompoundHome "cache"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "🚀 Compound Programming Language Toolchain Installer (Windows)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path $BinDir | Out-Null
New-Item -ItemType Directory -Force -Path $StdlibDir | Out-Null
New-Item -ItemType Directory -Force -Path $CacheDir | Out-Null

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

if (Test-Path "$ScriptDir\compound.exe") {
    Copy-Item -Force "$ScriptDir\compound.exe" "$BinDir\compound.exe"
    Copy-Item -Force "$ScriptDir\compound.exe" "$BinDir\hg.exe"
    Copy-Item -Force "$ScriptDir\compound.exe" "$BinDir\eg.exe"
}

# Update User PATH
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($UserPath -notlike "*$BinDir*") {
    Write-Host "⚙️ Adding $BinDir to User PATH..." -ForegroundColor Yellow
    [Environment]::SetEnvironmentVariable("Path", "$UserPath;$BinDir", "User")
}

Write-Host "==========================================================" -ForegroundColor Green
Write-Host "✅ Compound installed successfully on Windows!" -ForegroundColor Green
Write-Host "   • Environment Root: $CompoundHome"
Write-Host "   • Binary Location:  $BinDir\compound.exe"
Write-Host "==========================================================" -ForegroundColor Green
