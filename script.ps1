#change background
Invoke-WebRequest 'https://i.redd.it/vuzwv5gnh66b1.jpg' -OutFile "$Env:TEMP\skeleton.jpg"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name EnableTransparency -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name Wallpaper -Value $ENV:TEMP"\skeleton.jpg" -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name WallpaperStyle -Value 2 -force
New-ItemProperty -path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name LockScreenImage -Value $ENV:TEMP"\skeleton.jpg" -force

#changes firefox version
msiexec.exe /i \\laboratoire.collegeem.qc.ca\Stockage\usagers\Etudiants\2260367\app\firefox.msi /qn
Start-Process "C:\Program Files\Mozilla Firefox\uninstall\helper.exe" /S

#create desktop shortcut
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\2260367\Desktop\Firefox.lnk")
$Shortcut.TargetPath = "C:\Program Files\Firefox Developer Edition\firefox.exe"
$Shortcut.Save()



# Pin shortcuts to the taskbar
$spath = "C:\Users\2260367\Desktop\Firefox.lnk"
$shell = New-Object -ComObject Shell.Application
$taskbarPath = [System.IO.Path]::Combine([Environment]::GetFolderPath('ApplicationData'), 'Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar')
$shell.Namespace($taskbarPath).Self.InvokeVerb('pindirectory', $spath)
Stop-Process -ProcessName explorer



#add ublock
new-item -ItemType Directory "C:\extentions"
Invoke-WebRequest "https://github.com/gorhill/uBlock/releases/download/1.57.2/uBlock0_1.57.2.firefox.signed.xpi" -OutFile "C:\extentions\file.xpi"
Start-Process "C:\Program Files\Firefox Developer Edition\firefox.exe" "C:\extentions\ublock.xpi"
