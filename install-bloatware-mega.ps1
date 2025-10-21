<#
.SYNOPSIS
    Ultimate Bloatware Mega Deluxe v2
.DESCRIPTION
    Installs 70+ apps via winget + Chocolatey and launches them for full Chaos Mode.
    Modular sections or Install Everything option.
.NOTES
    Run PowerShell as Administrator. Recommended in a VM/disposable environment.
#>

# --- Prompt user for choice ---
Write-Host "Welcome to Ultimate Bloatware Mega Deluxe v2!" -ForegroundColor Cyan
Write-Host "Choose installation mode:" -ForegroundColor Yellow
Write-Host "1. Streaming & Media"
Write-Host "2. Social Media"
Write-Host "3. Utilities & Productivity"
Write-Host "4. Antivirus / Security Trials"
Write-Host "5. OEM / Vendor Tools"
Write-Host "6. Fun / Chaos Apps"
Write-Host "7. Install Everything"
$choice = Read-Host "Enter the number of your choice"

# --- Define app lists ---

# Streaming & Media (15)
$streamingWinget = @("Spotify.Spotify","Netflix.Netflix","Disney.DisneyPlus","Hulu.Hulu","Amazon.PrimeVideo",
                      "Microsoft.ZuneMusic","iTunes.AppleMusic","Plex.Plex","Kodi.Kodi")
$streamingChoco = @("vlc","mpv","audacity","handbrake","potplayer")

# Social Media & Communication (12)
$socialWinget = @("Facebook.Facebook","Instagram.Instagram","TikTok.TikTok","Twitter.Twitter",
                  "Microsoft.MicrosoftTeams","Zoom.Zoom","Skype.Skype")
$socialChoco = @("discord","slack","telegram","signal","whatsapp")

# Utilities & Productivity (20)
$utilityWinget = @("Google.Chrome","Mozilla.Firefox","Microsoft.Edge","Brave.Brave","Opera.Opera",
                   "Notepad++.Notepad++","VSCode.VisualStudioCode","OBSProject.OBSStudio","LibreOffice.LibreOffice")
$utilityChoco = @("7zip","winrar","git","python","nodejs","paint.net","gimp","blender","flux","everything")

# Antivirus / Security Trials (8)
$securityWinget = @("McAfee.Livesafe","Norton.NortonSecurity")
$securityChoco = @("avastfree","avgfree","malwarebytes","bitdefender","kaspersky","sophos-home")

# OEM / Vendor Tools (8)
$oemWinget = @("Dell.DellSupportAssist","HP.HPSupportAssistant","Lenovo.LenovoVantage","Asus.ArmouryCrate",
               "Acer.AcerCareCenter","MSI.DragonCenter","Razer.RazerSynapse","Gigabyte.AppCenter")
$oemChoco = @() # Mostly winget

# Fun / Chaos Apps (10)
$funWinget = @("Microsoft.Minesweeper","Microsoft.SolitaireCollection","Microsoft.CandyCrushSaga",
               "Microsoft.Mahjong","WallpaperEngine.WallpaperEngine")
$funChoco = @("desktop-goose","clippy","shimeji-ee","rainmeter","fences")

# --- Helper functions ---
function Install-WingetApps { param([array]$apps) foreach($app in $apps){ Write-Host "Installing $app via winget..." -ForegroundColor Green; winget install --id=$app --accept-source-agreements --accept-package-agreements -h } }
function Install-ChocoApps { param([array]$apps) foreach($app in $apps){ Write-Host "Installing $app via Chocolatey..." -ForegroundColor Green; choco install $app -y } }
function Launch-Apps { param([array]$apps) foreach($app in $apps){ try{ Write-Host "Launching $app..." -ForegroundColor Yellow; Start-Process $app -ErrorAction SilentlyContinue } catch { Write-Host "Could not launch $app via Start-Process." -ForegroundColor Red } } }

# --- Installation logic ---
$wingetSelection=@()
$chocoSelection=@()

switch($choice){
    "1" { $wingetSelection=$streamingWinget; $chocoSelection=$streamingChoco }
    "2" { $wingetSelection=$socialWinget; $chocoSelection=$socialChoco }
    "3" { $wingetSelection=$utilityWinget; $chocoSelection=$utilityChoco }
    "4" { $wingetSelection=$securityWinget; $chocoSelection=$securityChoco }
    "5" { $wingetSelection=$oemWinget; $chocoSelection=$oemChoco }
    "6" { $wingetSelection=$funWinget; $chocoSelection=$funChoco }
    "7" { 
        $wingetSelection=$streamingWinget + $socialWinget + $utilityWinget + $securityWinget + $oemWinget + $funWinget
        $chocoSelection=$streamingChoco + $socialChoco + $utilityChoco + $securityChoco + $oemChoco + $funChoco
    }
    default { Write-Host "Invalid choice, exiting..." -ForegroundColor Red; exit }
}

# --- Install apps ---
Install-WingetApps $wingetSelection
Install-ChocoApps $chocoSelection

# --- Chaos Mode: Launch all installed apps ---
Write-Host "`nLaunching all installed apps for MAXIMUM CHAOS!" -ForegroundColor Cyan
Launch-Apps $wingetSelection
Launch-Apps $chocoSelection

Write-Host "`nAll selected apps installed and launched. Reboot recommended!" -ForegroundColor Cyan
