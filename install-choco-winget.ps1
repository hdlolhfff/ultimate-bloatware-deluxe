<#
.SYNOPSIS
    Install Chocolatey and Winget if not present
.DESCRIPTION
    Checks for Chocolatey and Winget, installs them if missing.
    Designed to be run as Administrator.
.NOTES
    Run PowerShell as Administrator
#>

# --- Function to check if a command exists ---
function Command-Exists {
    param([string]$cmd)
    $null -ne (Get-Command $cmd -ErrorAction SilentlyContinue)
}

# --- Chocolatey Installation ---
if (-not (Command-Exists "choco")) {
    Write-Host "Chocolatey not found. Installing..." -ForegroundColor Cyan
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "Chocolatey installation complete." -ForegroundColor Green
} else {
    Write-Host "Chocolatey is already installed." -ForegroundColor Green
}

# --- Winget Installation ---
if (-not (Command-Exists "winget")) {
    Write-Host "Winget not found. Installing App Installer from Microsoft Store..." -ForegroundColor Cyan
    # Install via Microsoft Store link (App Installer)
    $storeLink = "ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1"
    Start-Process $storeLink
    Write-Host "Please complete the App Installer installation from the Microsoft Store." -ForegroundColor Yellow
} else {
    Write-Host "Winget is already installed." -ForegroundColor Green
}

Write-Host "`nChocolatey and Winget setup check complete!" -ForegroundColor Cyan
