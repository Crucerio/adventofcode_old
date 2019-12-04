function Copy-Object {
    param($DeepCopyObject)
    $memStream = new-object IO.MemoryStream
    $formatter = new-object Runtime.Serialization.Formatters.Binary.BinaryFormatter
    $formatter.Serialize($memStream,$DeepCopyObject)
    $memStream.Position=0
    $formatter.Deserialize($memStream)
}

$puzzle3 = Get-Content -Path ./puzzleinput3.txt -Encoding utf8
#$puzzle3 = "R75,D30,R83,U83,L12,D49,R71,U7,L72
#U62,R66,U55,R34,D71,R55,D58,R83"
#$puzzle3 = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
#U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
$puzzle3split = $puzzle3 -split "`n"

$CableDirections0 = $puzzle3split[0] -split "," | ForEach-Object {
    [PSCustomObject]@{
        Direction = $_[0]
        Distance  = $_.substring(1)
    }
}
$CableDirections1 = $puzzle3split[1] -split "," | ForEach-Object {
    [PSCustomObject]@{
        Direction = $_[0]
        Distance  = $_.substring(1)
    }
}
$currentPosition = [PSCustomObject]@{
    x = 0
    y = 0
}

write-output "Starte Koordinatenliste 0"
$CableCoordinates0=New-Object System.Collections.ArrayList 
foreach ($Cd0 in $CableDirections0) {
    switch ($Cd0.Direction) {
        "R" { 
            while ($Cd0.Distance -gt 0) {
                $currentPosition.x=$currentPosition.x+1
                $CableCoordinates0.add([PSCustomObject]@{
                    x = $currentPosition.x
                    y = $currentPosition.y
                })|Out-Null
                $Cd0.Distance = $Cd0.Distance - 1
            } 
        }
        "L" { 
            while ($Cd0.Distance -gt 0) {
                $currentPosition.x=$currentPosition.x-1
                $CableCoordinates0.add([PSCustomObject]@{
                    x = $currentPosition.x
                    y = $currentPosition.y
                })|Out-Null
                $Cd0.Distance = $Cd0.Distance - 1
            } 
        }
        "U" { 
            while ($Cd0.Distance -gt 0) {
                $currentPosition.y=$currentPosition.y+1
                $CableCoordinates0.add([PSCustomObject]@{
                    x = $currentPosition.x
                    y = $currentPosition.y
                })|Out-Null
                $Cd0.Distance = $Cd0.Distance - 1
            } 
        }
        "D" { 
            while ($Cd0.Distance -gt 0) {
                $currentPosition.y=$currentPosition.y-1
                $CableCoordinates0.add([PSCustomObject]@{
                    x = $currentPosition.x
                    y = $currentPosition.y
                })|Out-Null
                $Cd0.Distance = $Cd0.Distance - 1
            } 
        }
    }
}

$currentPosition = [PSCustomObject]@{
    x = 0
    y = 0
}
write-output "Starte Koordinatenliste 1"
$CableCoordinates1=New-Object System.Collections.ArrayList 
foreach ($Cd1 in $CableDirections1) {
    switch ($Cd1.Direction) {
        "R" { 
            while ($Cd1.Distance -gt 0) {
                $currentPosition.x=$currentPosition.x+1
                $CableCoordinates1.Add([PSCustomObject]@{
                    x = $currentPosition.x
                    y = $currentPosition.y
                })|Out-Null
                $Cd1.Distance = $Cd1.Distance - 1
            } 
        }
        "L" { 
            while ($Cd1.Distance -gt 0) {
                $currentPosition.x=$currentPosition.x-1
                $CableCoordinates1.Add([PSCustomObject]@{
                    x = $currentPosition.x
                    y = $currentPosition.y
                })|Out-Null
                $Cd1.Distance = $Cd1.Distance - 1
            }
        }
        "U" { 
            while ($Cd1.Distance -gt 0) {
                $currentPosition.y=$currentPosition.y+1
                $CableCoordinates1.Add([PSCustomObject]@{
                    x = $currentPosition.x
                    y = $currentPosition.y
                })|Out-Null
                $Cd1.Distance = $Cd1.Distance - 1
            } 
        }
        "D" { 
            while ($Cd1.Distance -gt 0) {
                $currentPosition.y=$currentPosition.y-1
                $CableCoordinates1.Add([PSCustomObject]@{
                    x = $currentPosition.x
                    y = $currentPosition.y
                })|Out-Null
                $Cd1.Distance = $Cd1.Distance - 1
            } 
        }
    }
}

[array]$points0=foreach ($CableCoordinate0 in $CableCoordinates0){
    "$($CableCoordinate0.x),$($CableCoordinate0.y)"
}
[array]$points1=foreach ($CableCoordinate1 in $CableCoordinates1){
    "$($CableCoordinate1.x),$($CableCoordinate1.y)"
}
$lowestcross=3012342345
foreach ($point0 in $points0) {
    if($points1.Contains($point0)){
        $point0
        $xy=$point0 -split ","
        $Distance = [Math]::Abs($xy[0])+[Math]::Abs($xy[1])
        $lowestcross=[Math]::Min($lowestcross,$Distance)
    }
}
$lowestcross