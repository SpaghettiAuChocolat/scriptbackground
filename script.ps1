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
Start-Sleep -Seconds 5




# Pin shortcuts to the taskbar
$spath = "C:\Users\2260367\Desktop\Firefox Developer Edition.lnk"
$shell = New-Object -ComObject Shell.Application
$taskbarPath = [System.IO.Path]::Combine([Environment]::GetFolderPath('ApplicationData'), 'Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar')
$shell.Namespace($taskbarPath).Self.InvokeVerb('pindirectory', $spath)
Stop-Process -ProcessName explorer



#add ublock
new-item -ItemType Directory "C:\extensions"
Invoke-WebRequest "https://github.com/gorhill/uBlock/releases/download/1.57.2/uBlock0_1.57.2.firefox.signed.xpi" -OutFile "C:\extensions\ublock.xpi"
Start-Process "C:\Program Files\Firefox Developer Edition\firefox.exe" "C:\extensions\ublock.xpi"
