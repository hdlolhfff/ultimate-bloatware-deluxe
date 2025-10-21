<#
.SYNOPSIS
    Ultimate Bloatware Deluxe Installer (winget + Chocolatey)
.DESCRIPTION
    Installs the largest possible collection of apps for a fully bloated Windows VM.
    Modular sections can be installed individually or all at once.
.NOTES
    Requires: PowerShell running as Administrator, winget and Chocolatey installed.
    Run in a VM/disposable environment. May take a while to complete.
#>

# --- Prompt user for choice ---
Write-Host "Welcome to Ultimate Bloatware Deluxe Installer!" -ForegroundColor Cyan
Write-Host "Choose installation mode:" -ForegroundColor Yellow
Write-Host "1. Streaming & Media"
Write-Host "2. Social Media"
Write-Host "3. Utilities & Productivity"
Write-Host "4. Antivirus / Security Trials"
Write-Host "5. OEM / Vendor Tools"
Write-Host "6. Install Everything"
$choice = Read-Host "Enter the number of your choice"

# --- Define app lists (winget / Chocolatey) ---

# Streaming & Media
$streamingWinget = @(
    "Spotify.Spotify",
    "Microsoft.ZuneMusic",
    "Netflix.Netflix",
    "Disney.DisneyPlus"
)
$streamingChoco = @(
    "vlc",
    "audacity",
    "mpv"
)

# Social Media
$socialWinget = @(
    "TikTok.TikTok",
    "Instagram.Instagram",
    "Facebook.Facebook",
    "Twitter.Twitter",
    "Microsoft.MicrosoftTeams"
)
$socialChoco = @(
    "slack",
    "discord"
)

# Utilities & Productivity
$utilityWinget = @(
    "Notepad++.Notepad++",
    "Zoom.Zoom",
    "Google.Chrome",
    "Mozilla.Firefox"
)
$utilityChoco = @(
    "7zip",
    "git",
    "python",
    "paint.net",
    "handbrake"
)

# Antivirus / Security Trials
$securityWinget = @(
    "McAfee.Livesafe",
    "Norton.NortonSecurity"
)
$securityChoco = @(
    "malwarebytes",
    "avastfree"
)

# OEM / Vendor Tools
$oemWinget = @(
    "Dell.DellSupportAssist",
    "HP.HPSupportAssistant",
    "Lenovo.LenovoVantage",
    "Asus.ArmouryCrate"
)
$oemChoco = @()  # Most OEM tools are winget only

# --- Helper functions ---
function Install-WingetApps {
    param ([array]$apps)
    foreach ($app in $apps) {
        Write-Host "Installing $app via winget..." -ForegroundColor Green
        winget install --id=$app --accept-source-agreements --accept-package-agreements -h
    }
}

function Install-ChocoApps {
    param ([array]$apps)
    foreach ($app in $apps) {
        Write-Host "Installing $app via Chocolatey..." -ForegroundColor Green
        choco install $app -y
    }
}

# --- Installation logic ---
switch ($choice) {
    "1" { Install-WingetApps $streamingWinget; Install-ChocoApps $streamingChoco }
    "2" { Install-WingetApps $socialWinget; Install-ChocoApps $socialChoco }
    "3" { Install-WingetApps $utilityWinget; Install-ChocoApps $utilityChoco }
    "4" { Install-WingetApps $securityWinget; Install-ChocoApps $securityChoco }
    "5" { Install-WingetApps $oemWinget; Install-ChocoApps $oemChoco }
    "6" {
        Install-WingetApps $streamingWinget; Install-ChocoApps $streamingChoco
        Install-WingetApps $socialWinget; Install-ChocoApps $socialChoco
        Install-WingetApps $utilityWinget; Install-ChocoApps $utilityChoco
        Install-WingetApps $securityWinget; Install-ChocoApps $securityChoco
        Install-WingetApps $oemWinget; Install-ChocoApps $oemChoco
    }
    default { Write-Host "Invalid choice, exiting..." -ForegroundColor Red }
}

Write-Host "`nAll selected apps installation attempted. Reboot recommended!" -ForegroundColor Cyan
