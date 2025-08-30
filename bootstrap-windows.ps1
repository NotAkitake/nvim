# ==============================
#  SETTING UP NEOVIM ENVIRONMENT
# ==============================

# Banner
Write-Host "`n===================================" -ForegroundColor Blue
Write-Host "   SETTING UP NEOVIM ENVIRONMENT   " -ForegroundColor White
Write-Host "===================================`n" -ForegroundColor Blue

# Install dependencies
$apps = @(
    "zig.zig",
    "OpenJS.NodeJS",
    "Neovim.Neovim",
    "sharkdp.fd",
    "BurntSushi.ripgrep.GNU",
    "Git.Git",
    "Jesseduffield.lazygit"
)

foreach ($app in $apps) {
    Write-Host "Installing $app ..." -ForegroundColor Cyan
    winget install --id=$app --accept-source-agreements --accept-package-agreements -e
}

# Paths
$scriptDir    = Split-Path -Parent $MyInvocation.MyCommand.Definition
$nvimSrc      = Resolve-Path (Join-Path $scriptDir "..\nvim")
$nvimDst      = Join-Path $env:LOCALAPPDATA "nvim"
$nvimDataDst  = Join-Path $env:LOCALAPPDATA "nvim-data"
$lazyPath     = Join-Path $nvimDataDst "lazy\lazy.nvim"

Write-Host "`nSource:      $nvimSrc" -ForegroundColor Yellow
Write-Host "Destination: $nvimDst" -ForegroundColor Yellow
Write-Host "Data path:   $nvimDataDst" -ForegroundColor Yellow
Write-Host "Lazy.nvim:   $lazyPath`n" -ForegroundColor Yellow

# Remove existing config if it exists
if (Test-Path $nvimDst) {
    Write-Host "Removing existing nvim directory..." -ForegroundColor Red
    Remove-Item $nvimDst -Recurse -Force
}
if (Test-Path $nvimDataDst) {
    Write-Host "Removing existing nvim-data directory..." -ForegroundColor Red
    Remove-Item $nvimDataDst -Recurse -Force
}

# Recreate nvim-data directory
Write-Host "Recreating nvim-data directory..." -ForegroundColor Green
New-Item -ItemType Directory -Path $nvimDataDst | Out-Null

# Try junction first (works without admin)
Write-Host "Creating junction..." -ForegroundColor Cyan
cmd /c mklink /J "`"$nvimDst`"" "`"$nvimSrc`""

if (-not (Test-Path $nvimDst)) {
    Write-Host "Junction failed, trying symlink..." -ForegroundColor DarkYellow
    New-Item -ItemType SymbolicLink -Path $nvimDst -Target $nvimSrc -Force | Out-Null
}

# Bootstrap lazy.nvim
Write-Host "Cloning lazy.nvim..." -ForegroundColor Cyan
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable $lazyPath

# Done
Write-Host "`nNeovim and LazyGit should now be ready for use!" -ForegroundColor Green
Write-Host "`nConsider running the .reg files inside the 'scripts' directory." -ForegroundColor Yellow
Write-Host "They will add entries to your context menus (Open/Edit with Neovim, Open with LazyGit)" -ForegroundColor Yellow
Pause
