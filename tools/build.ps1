[CmdletBinding()]
param(
    [ValidateSet("exe","msix","both")]
    [string]$Target = "both",
    [ValidateSet("foss","freemium")]
    [string]$Freedom = "foss",
    [string]$CertificatePath,
    [string]$CertificatePasswd,
    [switch]$SkipFlutterSetup,
    [switch]$ContinueOnFail,
    [string]$BuildDir = "package"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Run-Step {
    param(
        [string]$Name,
        [scriptblock]$Action
    )
    try {
        & $Action
        Write-Host -Foreground green "$Name succeeded."
    } catch {
        Write-Host -Foreground red "$Name failed: $($_.Exception.Message)"
        if (-not $ContinueOnFail) { exit 1 }
    }
}

if (-not $SkipFlutterSetup) {
    Write-Host "Preparing Flutter toolchain..."
    & .flutter/bin/flutter config --no-analytics | Out-Host
    & .flutter/bin/flutter doctor | Out-Host
    & .flutter/bin/flutter clean  | Out-Host
    & .flutter/bin/flutter pub get | Out-Host
}

$flutterFlags   = @("build","windows","--release")
if ($Freedom -eq "foss") { $flutterFlags += "-t"; $flutterFlags += "lib/main_foss.dart"}
if ($Freedom -eq "freemium") { $flutterFlags += "-t"; $flutterFlags += "lib/main_freemium.dart"}

New-Item -ItemType Directory -Path $BuildDir -Force | Out-Null

if ($Target -in @("exe","both")) {
    Run-Step "Building EXE" {
        & .flutter/bin/flutter @flutterFlags
    }

    $runnerDir = Join-Path $PSScriptRoot "../build/windows/x64/runner/Release"
    if (-not (Test-Path $runnerDir)) {
        throw "Runner directory `"$runnerDir`" not found!"
    }
    $exeDest = Join-Path $BuildDir $Freedom
    $zipDir = Join-Path $runnerDir "windows.zip"
    Compress-Archive $runnerDir $zipDir -Force
    Copy-Item $zipDir -Force -Destination $exeDest
    Write-Host "EXE copied to $exeDest"
}

if ($Target -in @("msix","both")) {
    $msixFlags = @("--install-certificate","false")

    if ($CertificatePath) {
        $msixFlags += "-c"
        $msixFlags += $CertificatePath
    }
    if ($CertificatePasswd) {
        $msixFlags += "-p"
        $msixFlags += $CertificatePasswd
    }

    Run-Step "Building MSIX" {
        & .flutter/bin/dart run msix:create --build-windows false $msixFlags | Out-Host
    }

    $msixFile = Get-ChildItem -Path (Join-Path $PSScriptRoot "../build/windows/x64/runner/Release") -Filter *.msix -Recurse |
                Sort-Object LastWriteTime -Descending |
                Select-Object -First 1
    if (-not $msixFile) { throw "MSIX file not found." }

    $msixDest = Join-Path $BuildDir $Freedom
    New-Item -ItemType Directory -Force -Path $msixDest | Out-Null
    Copy-Item $msixFile.FullName -Destination $msixDest -Force
    Write-Host "MSIX copied to $msixDest"
}

Write-Host "All builds completed. Packages are in: ${BuildDir}"
