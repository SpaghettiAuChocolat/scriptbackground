function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
  if ($elevated) {
        # Privil�ges administrateurs non obtenus, annulation
    }
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}
Invoke-WebRequest 'https://i.pinimg.com/originals/2c/d4/1f/2cd41f00f206636090a1061ff353accb.jpg' -OutFile "$Env:TEMP\skeleton.jpg"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name EnableTransparency -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name Wallpaper -Value $ENV:TEMP"\skeleton.jpg" -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name WallpaperStyle -Value 2 -force
New-ItemProperty -path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name LockScreenImage -Value $ENV:TEMP"\skeleton.jpg" -force
Stop-Process -ProcessName explorer
