[CmdletBinding()]
param(
    [ValidateSet('exe','msix','both')]
    [string]$Target = 'both',
    [ValidateSet('foss','freemium')]
    [string]$Freedom = 'foss',
    [switch]$Debug,
    [switch]$Verbose,
    [switch]$SkipFlutterSetup,
    [switch]$ContinueOnFail,
    [string]$BuildDir = 'packages'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Info   { param([string]$m) Write-Host $m -ForegroundColor Green }
function Write-Warn   { param([string]$m) Write-Host $m -ForegroundColor Yellow }
function Write-Err    { param([string]$m) Write-Host $m -ForegroundColor Red }

function Run-Step {
    param(
        [string]$Name,
        [scriptblock]$Action
    )
    try {
        & $Action
        Write-Info "$Name succeeded."
    } catch {
        Write-Err "$Name failed: $($_.Exception.Message)"
        if (-not $ContinueOnFail) { exit 1 }
    }
}

if (-not $SkipFlutterSetup) {
    Write-Info "Preparing Flutter toolchain…"
    & .flutter/bin/flutter.bat config --no-analytics | Out-Host
    & .flutter/bin/flutter.bat doctor | Out-Host
    & .flutter/bin/flutter.bat clean  | Out-Host
    & .flutter/bin/flutter.bat pub get | Out-Host
}

$configuration  = $Debug ? 'debug' : 'release'
$flutterFlags   = @('build','windows', "--$configuration")
if ($Verbose) { $flutterFlags += '--verbose' }
if ($Freedom -eq "foss") { $flutterFlags += '-t lib/main_foss.dart'}
if ($Freedom -eq "freemium") { $flutterFlags += '-t lib/main_freemium.dart'}

# Ensure destination directory
$BuildDir = Resolve-Path $BuildDir
New-Item -ItemType Directory -Path $BuildDir -Force | Out-Null

# ---------- EXE ----------
if ($Target -in @('exe','both')) {
    Run-Step 'Building EXE' {
        & .flutter/bin/flutter.bat @flutterFlags
    }

    $runnerDir = Join-Path $PSScriptRoot "build/windows/runner/$([CultureInfo]::CurrentCulture.TextInfo.ToTitleCase($configuration))"
    if (-not (Test-Path $runnerDir)) {
        throw "Runner directory '$runnerDir' not found!"
    }
    $exeDest = Join-Path $BuildDir "exe-$configuration"
    Copy-Item $runnerDir -Recurse -Force -Destination $exeDest
    Write-Info "EXE copied to $exeDest"
}

# ---------- MSIX ----------
if ($Target -in @('msix','both')) {
    Run-Step 'Building MSIX' {
        if (-not (Get-Command msix -ErrorAction SilentlyContinue)) {
            Write-Warn "msix tool not found – installing…"
            & dart pub global activate msix | Out-Host
            $env:PATH += ";.flutter\.pub-cache\bin"
        }
        & .flutter/bin/dart.bat run msix:create | Out-Host
    }

    $msixFile = Get-ChildItem -Path (Join-Path $PSScriptRoot 'build') -Filter *.msix -Recurse |
                Sort-Object LastWriteTime -Descending |
                Select-Object -First 1
    if (-not $msixFile) { throw "MSIX file not found." }

    $msixDest = Join-Path $BuildDir "msix-$configuration"
    New-Item -ItemType Directory -Force -Path $msixDest | Out-Null
    Copy-Item $msixFile.FullName -Destination $msixDest -Force
    Write-Info "MSIX copied to $msixDest"
}

Write-Info "All builds completed. Packages are in: $BuildDir"
