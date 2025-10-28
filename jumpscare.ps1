$base = "$env:APPDATA\winprank"
New-Item -ItemType Directory -Force -Path $base | Out-Null
$imgPath = "$base\wall.png"
$soundPath = "$base\scream.wav"
$imgUrl = "https://raw.githubusercontent.com/amir-iop/BadUSB/6aa4203cac539729c1d0905e5e95ab1eb3f9c7cd/JumpscareWallpaper.jpg"
$soundUrl = "https://github.com/amir-iop/BadUSB/raw/6aa4203cac539729c1d0905e5e95ab1eb3f9c7cd/JumpscareVoice.wav"
Invoke-WebRequest $imgUrl -OutFile $imgPath
Invoke-WebRequest $soundUrl -OutFile $soundPath
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
  [DllImport("user32.dll", CharSet = CharSet.Auto)]
  public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
[Wallpaper]::SystemParametersInfo(0x0014, 0, $imgPath, 0x01 -bor 0x02)
for ($i = 0; $i -lt 50; $i++) {
    (New-Object -ComObject WScript.Shell).SendKeys([char]175)
    Start-Sleep -Milliseconds 20
}
if (Test-Path $soundPath) {
    Add-Type -AssemblyName presentationCore
    $player = New-Object System.Media.SoundPlayer
    $player.SoundLocation = $soundPath
    $player.Load()
    $player.PlayLooping()
} else {
    Write-Host "Download Fail"
}
pause



