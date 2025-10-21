<#
.SYNOPSIS
    Ultimate Bloatware Deluxe + Chaos Mode
.DESCRIPTION
    Installs a huge variety of apps via winget + Chocolatey, then launches them all.
    Modular sections available, or install everything.
.NOTES
    Requires Administrator, winget, Chocolatey installed.
    Run in a VM/disposable environment.
#>

# --- Prompt user for choice ---
Write-Host "Welcome to Ultimate Bloatware Deluxe + Chaos Mode!" -ForegroundColor Cyan
Write-Host "Choose installation mode:" -ForegroundColor Yellow
Write-Host "1. Streaming & Media"
Write-Host "2. Social Media"
Write-Host "3. Utilities & Productivity"
Write-Host "4. Antivirus / Security Trials"
Write-Host "5. OEM / Vendor Tools"
Write-Host "6. Install Everything"
$choice = Read-Host "Enter the number of your choice"

# --- Define app lists ---
$streamingWinget = @("Spotify.Spotify","Microsoft.ZuneMusic","Netflix.Netflix","Disney.DisneyPlus")
$streamingChoco = @("vlc","audacity","mpv")
$socialWinget = @("TikTok.TikTok","Instagram.Instagram","Facebook.Facebook","Twitter.Twitter","Microsoft.MicrosoftTeams")
$socialChoco = @("slack","discord")
$utilityWinget = @("Notepad++.Notepad++","Zoom.Zoom","Google.Chrome","Mozilla.Firefox")
$utilityChoco = @("7zip","git","python","paint.net","handbrake")
$securityWinget = @("McAfee.Livesafe","Norton.NortonSecurity")
$securityChoco = @("malwarebytes","avastfree")
$oemWinget = @("Dell.DellSupportAssist","HP.HPSupportAssistant","Lenovo.LenovoVantage","Asus.ArmouryCrate")
$oemChoco = @()

# --- Helper functions ---
function Install-WingetApps { param([array]$apps) foreach($app in $apps){ Write-Host "Installing $app via winget..." -ForegroundColor Green; winget install --id=$app --accept-source-agreements --accept-package-agreements -h } }
function Install-ChocoApps { param([array]$apps) foreach($app in $apps){ Write-Host "Installing $app via Chocolatey..." -ForegroundColor Green; choco install $app -y } }

function Launch-Apps {
    param([array]$apps)
    foreach($app in $apps){
        try{
            Write-Host "Launching $app..." -ForegroundColor Yellow
            Start-Process $app -ErrorAction SilentlyContinue
        } catch {
            Write-Host "Could not launch $app via Start-Process. Might need to open manually." -ForegroundColor Red
        }
    }
}

# --- Installation logic ---
$wingetSelection=@()
$chocoSelection=@()

switch($choice){
    "1" { $wingetSelection=$streamingWinget; $chocoSelection=$streamingChoco }
    "2" { $wingetSelection=$socialWinget; $chocoSelection=$socialChoco }
    "3" { $wingetSelection=$utilityWinget; $chocoSelection=$utilityChoco }
    "4" { $wingetSelection=$securityWinget; $chocoSelection=$securityChoco }
    "5" { $wingetSelection=$oemWinget; $chocoSelection=$oemChoco }
    "6" { 
        $wingetSelection=$streamingWinget + $socialWinget + $utilityWinget + $securityWinget + $oemWinget
        $chocoSelection=$streamingChoco + $socialChoco + $utilityChoco + $securityChoco + $oemChoco
    }
    default { Write-Host "Invalid choice, exiting..." -ForegroundColor Red; exit }
}

# --- Install apps ---
Install-WingetApps $wingetSelection
Install-ChocoApps $chocoSelection

# --- Launch apps for chaos ---
Write-Host "`nLaunching all installed apps for MAXIMUM CHAOS!" -ForegroundColor Cyan
Launch-Apps $wingetSelection
Launch-Apps $chocoSelection

Write-Host "`nAll selected apps installed and launched. Reboot recommended!" -ForegroundColor Cyan
