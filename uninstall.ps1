$a=Get-WmiObject -class win32_product
foreach($software in $a){
    $software.name
    if ((Read-host -Prompt "deinstallieren?[y][N]") -eq "y"){
        Write-Output "Try to remove $($software.name)"
        $software.Uninstall()
    }
}