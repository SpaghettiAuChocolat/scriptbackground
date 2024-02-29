Invoke-WebRequest 'https://staticdelivery.nexusmods.com/mods/1704/images/thumbnails/97119/97119-1690678389-1521239676.jpeg' -OutFile "$Env:TEMP\skeleton.jpg"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name EnableTransparency -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name Wallpaper -Value $ENV:TEMP"\skeleton.jpg" -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name WallpaperStyle -Value 2 -force
New-ItemProperty -path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name LockScreenImage -Value $ENV:TEMP"\skeleton.jpg" -force
Stop-Process -ProcessName explorer
