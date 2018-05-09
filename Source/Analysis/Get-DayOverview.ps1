<#
.SYNOPSIS
    Grabs all time entries, groups them as report
.DESCRIPTION
    Sometimes you have to report what your day was like.
    No problem if you used the kanbanflow timer features.
#>
function Get-DayOverview {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [DateTime]$Day
    )

    $from = ($Day).Date
    $to = $from.AddDays(1).AddSeconds(-1)
    $entries = Get-TimeEntries -From $from -To $to -ApiToken $ApiToken
    $tasks = Get-Task -ApiToken $ApiToken -Flat
    #Write-Output ($tasks | ConvertTo-Json)    

    foreach ($entry in $entries) {
        $taskName = ($tasks | Where-Object _id -eq $entry.taskId).name
        $fromDateTime = $entry.startTimeStamp
        $tillDateTime = $entry.endTimeStamp
        $durationInMinutes = [Math]::Round(($tillDateTime - $fromDateTime).TotalMinutes,0)

        $entry | Add-Member NoteProperty -Name taskName -Value $taskName
        $entry | Add-Member NoteProperty -Name durationInMinutes -Value $durationInMinutes
    }

    $entries | Group-Object userId | ForEach-Object {
        Write-Output "User:" $_.name -ForegroundColor "White"
        $totalP = 0.0
        $userTasks = $_.group | Group-Object taskName
        $userTasks | ForEach-Object {
            $totalMinutes = ($_.group | Measure-Object durationInMinutes -Sum).Sum
            $pomodoros = [Math]::Round( $totalMinutes / 25, 1 )
            $totalP += $pomodoros
            Write-Output ("  - " + $_.name + " (" + $totalMinutes + " min, " + $pomodoros + " P)") -ForegroundColor "Green"
        }

        Write-Output "=" $totalP "P" -ForegroundColor "White"
        Write-Output ""
        #Write-Output ($_.group | Group-Object taskName | ConvertTo-Json) 
    }
    

}
