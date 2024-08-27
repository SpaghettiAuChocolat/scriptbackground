#change background
Invoke-WebRequest 'https://i.redd.it/vuzwv5gnh66b1.jpg' -OutFile "$Env:TEMP\image.jpg"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name EnableTransparency -Value 0 -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name Wallpaper -Value $ENV:TEMP"\image.jpg" -force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name WallpaperStyle -Value 2 -force
New-ItemProperty -path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name LockScreenImage -Value $ENV:TEMP"\image.jpg" -force
Stop-Process -ProcessName explorer

$adapters = Get-NetAdapter
$adapterlist = @()
foreach($adapter in $adapters){
    $status =  $adapter | Select-Object Status
    if($status.Status -eq "Up"){
        $adapterlist += $adapter
    }
}
$validint = @()
foreach($interface in $adapterlist){
    if($interface.Name.Substring(0,8) -contains "Ethernet" -and $interface.Name -notlike "*(CÉGEP)*"){
        $validint += $interface
    }
}
foreach($int in $validint){
    $ipadd = Get-NetIPAddress | Where-Object InterfaceAlias -eq $int.Name
    $ipv4 = $ipadd.IPv4Address
    if ($ipv4 -notlike "169*"){
        Disable-NetAdapter -Name $int.Name -Confirm:$false
    }
}


#changes firefox version
msiexec.exe /i \\laboratoire.collegeem.qc.ca\Stockage\usagers\Etudiants\2260367\app\search.msi /qn
msiexec.exe /i \\laboratoire.collegeem.qc.ca\Stockage\usagers\Etudiants\2260367\app\firefox.msi /qn
Start-Process "C:\Program Files\Mozilla Firefox\uninstall\helper.exe" /S
Start-Sleep -Seconds 25

#add ublock
new-item -ItemType Directory "C:\extensions"
Invoke-WebRequest "https://github.com/gorhill/uBlock/releases/download/1.57.2/uBlock0_1.57.2.firefox.signed.xpi" -OutFile "C:\extensions\ublock.xpi"
Invoke-WebRequest "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi" -OutFile "C:\extensions\bitwarden.xpi"
Start-Process "C:\Program Files\Firefox Developer Edition\firefox.exe" "C:\extensions\ublock.xpi"
Start-Process "C:\Program Files\Firefox Developer Edition\firefox.exe" "C:\extensions\bitwarden.xpi"





#kill useless processes
Stop-Process -ProcessName AgentConnectix
Stop-Process -ProcessName Greenshot
Stop-Process -ProcessName AdobeIPCBroker
Stop-Process -ProcessName WavesSvc64
Stop-Process -ProcessName WavesSysSvc64
