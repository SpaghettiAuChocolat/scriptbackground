Invoke-WebRequest 'https://i.redd.it/vuzwv5gnh66b1.jpg' -OutFile "$Env:TEMP\skeleton.jpg"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name EnableTransparency -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name Wallpaper -Value $ENV:TEMP"\skeleton.jpg" -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name WallpaperStyle -Value 2 -force
New-ItemProperty -path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name LockScreenImage -Value $ENV:TEMP"\skeleton.jpg" -force

msiexec.exe /i \\laboratoire.collegeem.qc.ca\Stockage\usagers\Etudiants\2260367\app\firefox.msi /qn
Start-Process "C:\Program Files\Mozilla Firefox\uninstall\helper.exe" /S
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\2260367\Desktop\Firefox.lnk")
$Shortcut.TargetPath = "C:\Program Files\Firefox Developer Edition\firefox.exe"
$Shortcut.Save()

$spath = "C:\Users\2260367\Desktop\Firefox.lnk"

# Pin shortcuts to the taskbar
$shell = New-Object -ComObject Shell.Application
$taskbarPath = [System.IO.Path]::Combine([Environment]::GetFolderPath('ApplicationData'), 'Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar')

$shell.Namespace($taskbarPath).Self.InvokeVerb('pindirectory', $spath)




Stop-Process -ProcessName explorer
