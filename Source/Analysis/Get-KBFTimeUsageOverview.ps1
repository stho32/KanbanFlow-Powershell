function Get-KBFTimeUsageOverview {
    <#
        .SYNOPSIS
        Creates a time usage overview for a time span 

        .DESCRIPTION
        We do a weekly reporting about our time usage.

        And that is what this is for. You can give that 
        function a time span. Do not care about the time part
        on the datetimes you pass in. The function will remove 
        the time part and make sure both days are fully included.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [DateTime]$FromDay,
        [Parameter(Mandatory=$true)]
        [DateTime]$ToIncludingDay
    )

    $from = ($FromDay).Date
    $to = ($ToIncludingDay).Date.AddDays(1).AddSeconds(-1)
    $entries = Get-TimeEntries -From $from -To $to -ApiToken $ApiToken
    $tasks = Get-Task -ApiToken $ApiToken -Flat

    <# We enrich the time entries with task information that we need
       for grouping later. #>
    foreach ($entry in $entries) {
        $task = ($tasks | Where-Object _id -eq $entry.taskId)
        
        $taskName = $task.name
        $color = $task.color 
        
        $fromDateTime = $entry.startTimeStamp
        $tillDateTime = $entry.endTimeStamp
        $durationInMinutes = [Math]::Round(($tillDateTime - $fromDateTime).TotalMinutes,0)

        $entry | Add-Member NoteProperty -Name taskName -Value $taskName
        $entry | Add-Member NoteProperty -Name durationInMinutes -Value $durationInMinutes
        $entry | Add-Member NoteProperty -Name color -Value $color
    }

    <# Then we group by user and color (task type), finally per task
       to create a statistic about the time that went in every task type and
       task in pomodoros. #>
    $entries | Group-Object userId | ForEach-Object {
        Write-Output "User: $($_.name)"
        $totalP = 0.0

        $userColors = $_.group | Group-Object color
        $userColors | ForEach-Object {
            Write-Output "    Color: $($_.name)"
            $sectionsP = 0.0

            $userTasks = $_.group | Group-Object taskName
            $userTasks | ForEach-Object {
                $totalMinutes = ($_.group | Measure-Object durationInMinutes -Sum).Sum
                $pomodoros = [Math]::Round( $totalMinutes / 25, 1 )
                $sectionsP += $pomodoros
                $totalP += $pomodoros
                Write-Output "      - $($_.name) ($pomodoros P)" 
            }

            Write-Output "    = $sectionsP P"
            Write-Output ""
        }

        Write-Output " = $totalP P"
        Write-Output ""
    }
}
