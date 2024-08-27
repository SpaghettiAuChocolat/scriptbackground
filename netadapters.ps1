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
