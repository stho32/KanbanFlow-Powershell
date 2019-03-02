function Get-KBFTimeUsageTable {
    <#
        .SYNOPSIS
        Creates a time usage table for a time span 
        
        .DESCRIPTION
        You get just the users as well as their time spent grouped by color
        of the task
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,
        [Parameter(Mandatory = $true)]
        [DateTime]$FromDay,
        [Parameter(Mandatory = $true)]
        [DateTime]$ToIncludingDay
    )

    $from = ($FromDay).Date
    $to = ($ToIncludingDay).Date.AddDays(1).AddSeconds(-1)

    $dayCount = [int]($to - $from).TotalDays

    $entries = Get-TimeEntries -From $from -To $to -ApiToken $ApiToken
    $tasks = Get-Task -ApiToken $ApiToken -Flat

    <# We enrich the time entries with task information that we need
       for grouping later. #>
    foreach ($entry in $entries) {
        $task = ($tasks | Where-Object _id -eq $entry.taskId)
        
        $taskName = $task.name
        $color = $task.color 
        
        <# Powershell 6 automatically converts the timestamps
            while Powershell 5 does not. #>
        $fromDateTime = $entry.startTimeStamp
        if ( $fromDateTime.GetType().Name -ne "DateTime" ) {
            $fromDateTime = [DateTime]::Parse($fromDateTime)
        }

        $tillDateTime = $entry.endTimeStamp
        if ( $tillDateTime.GetType().Name -ne "DateTime" ) {
            $tillDateTime = [DateTime]::Parse($tillDateTime)
        }
        
        $durationInMinutes = [Math]::Round(($tillDateTime - $fromDateTime).TotalMinutes, 0)

        $entry | Add-Member NoteProperty -Name taskName -Value $taskName
        $entry | Add-Member NoteProperty -Name durationInMinutes -Value $durationInMinutes
        $entry | Add-Member NoteProperty -Name color -Value $color
    }

    <# Then we group by user and color (task type), finally per task
       to create a statistic about the time that went in every task type and
       task in pomodoros. #>
    $entries | Group-Object userId | ForEach-Object {
        $user = $_.name
        $totalP = 0.0

        $userColors = $_.group | Group-Object color
        $userColors | ForEach-Object {
            $color = $_.name
            $sectionsP = 0.0

            $userTasks = $_.group | Group-Object taskName
            $userTasks | ForEach-Object {
                $totalMinutes = ($_.group | Measure-Object durationInMinutes -Sum).Sum
                $pomodoros = [Math]::Round( $totalMinutes / 25, 1 )
                $sectionsP += $pomodoros
                $totalP += $pomodoros
            }

            Write-Output "$user - $color : $sectionsP P"
        }

        Write-Output ("$user = $totalP P ( = " + [Math]::Round( $totalP / $dayCount, 1 ) + " P/day )")
        Write-Output ""
    }
}
