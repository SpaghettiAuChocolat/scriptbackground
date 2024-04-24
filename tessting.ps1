
# Pin shortcuts to the taskbar
$spath = "C:\Users\2260367\Desktop\Firefox Developer Edition.lnk"
$shell = New-Object -ComObject Shell.Application
$taskbarPath = [System.IO.Path]::Combine([Environment]::GetFolderPath('ApplicationData'), 'Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar')
$shell.Namespace($taskbarPath).Self.InvokeVerb('pindirectory', $spath)
Stop-Process -ProcessName explorer