$puzzleinput=Get-Content "/home/cru/Documents/pwsh/puzzleinput1.txt"
$puzzleinput.Count

##part 1
function Get-FuelUsage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [decimal]
        $weight
    )
    return [math]::Floor(($weight/3))-2
}
$fuelusage=$puzzleinput|ForEach-Object{
    Get-FuelUsage -weight $_
}
$totalfuelusage=0
foreach ($fuel in $fuelusage){
$totalfuelusage+=$fuel
}
write-Output "Answer Part 1"
$totalfuelusage

##part 2
function Get-CompleteFuelUsage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [decimal]
        $weight
    )
    $rocketfuel=0
    do{
    $weight=Get-FuelUsage -weight $weight
    if($weight -gt 0){
        $rocketfuel+=$weight
    }
    }while($weight -gt 0)
    return $rocketfuel
}
Get-CompleteFuelUsage -weight 100756
$fuelusage2=$puzzleinput|ForEach-Object{
    Get-CompleteFuelUsage -weight $_
}
$totalfuelusage2=0
foreach ($fuel2 in $fuelusage2){
$totalfuelusage2+=$fuel2
}
write-Output "Answer Part 2"
$totalfuelusage2