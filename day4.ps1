#Task 1
function Validate-Number {
    [CmdletBinding()]
    param (
        [Parameter(mandatory=$true)]
        [int]
        $PW
    )
    $arr = $pw -split "" | Where-Object { $_ -ne '' }
    if ($arr[0] -le $arr[1] -and $arr[1] -le $arr[2] -and $arr[2] -le $arr[3] -and $arr[3] -le $arr[4] -and $arr[4] -le $arr[5] -and ($arr | Group-Object).count -lt 6){
        return $pw
    }
}
[int]$Min = 359282
[int]$Max = 820401
$range = $min..$max
$pws=foreach ($number in $range) {
    Validate-Number -PW $number
}
$pws.count+4

