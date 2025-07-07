$base = "$env:APPDATA\winprank"
New-Item -ItemType Directory -Force -Path $base | Out-Null

$soundPath = "$base\scream.wav"
$imgPath = "$base\wall.png"

$soundUrl = "https://github.com/I-Am-Jakoby/hak5-submissions/raw/main/OMG/Payloads/OMG-JumpScare/female_scream.wav"
$imgUrl = "https://github.com/I-Am-Jakoby/hak5-submissions/raw/main/OMG/Payloads/OMG-JumpScare/jumpscare.png"

Invoke-WebRequest $soundUrl -OutFile $soundPath
Invoke-WebRequest $imgUrl -OutFile $imgPath

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
  [DllImport("user32.dll", CharSet = CharSet.Auto)]
  public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
[Wallpaper]::SystemParametersInfo(0x0014, 0, $imgPath, 0x01 -bor 0x02)

Start-Sleep -Milliseconds 500

for ($i = 0; $i -lt 50; $i++) {
    (New-Object -ComObject WScript.Shell).SendKeys([char]175)
    Start-Sleep -Milliseconds 10
}

# اجرای صدا
Start-Process "wmplayer.exe" -ArgumentList "`"$soundPath`"" -WindowStyle Hidden
