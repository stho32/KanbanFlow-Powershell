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
        [DateTime]$Day,
        [ValidateSet("Text", "Html")]
        [string]$format="Text"
    )

    $from = ($Day).Date
    $to = $from.AddDays(1).AddSeconds(-1)
    $entries = Get-TimeEntries -From $from -To $to -ApiToken $ApiToken
    $tasks = Get-Task -ApiToken $ApiToken -Flat

    <# We enrich the time entries with task information that we need
       for grouping later. #>
    foreach ($entry in $entries) {
        $task = ($tasks | Where-Object _id -eq $entry.taskId)
        
        $taskName = $task.name
        $color = $task.color 
        $number = $task.number.value
        $status = $task.columnName
        $id = $task._id

        $fromDateTime = $entry.startTimeStamp
        $tillDateTime = $entry.endTimeStamp
        $durationInMinutes = [Math]::Round(($tillDateTime - $fromDateTime).TotalMinutes,0)

        $entry | Add-Member NoteProperty -Name taskName -Value $taskName
        $entry | Add-Member NoteProperty -Name durationInMinutes -Value $durationInMinutes
        $entry | Add-Member NoteProperty -Name color -Value $color
        $entry | Add-Member NoteProperty -Name number -Value $number
        $entry | Add-Member NoteProperty -Name status -Value $status 
        $entry | Add-Member NoteProperty -Name id -Value $id 

    }


    $template_lineBreak = "\n"
    $template_StartUser = "User: #username#"
    $template_StartColor = "    Color: #color#"
    $template_Task = "      - Nr. #nr#, #column# : #taskname# (#pomodoros# P)" + $template_lineBreak + "#comments#"
    $template_EndColor = "    = #sectionsP# P"
    $template_EndUser = " = #totalP# P"
    

    if ($format -eq "Html") {
        $template_lineBreak = "<br/>"
        $template_StartUser = "<strong>User: #username#</strong>" + $template_lineBreak
        $template_StartColor = "<strong>Color: #color#</strong>" + $template_lineBreak + "<ul>"
        $template_Task = "      <li><span style=`"color:#009dd3`">Nr. #nr#, #column# : <strong>#taskname#</strong> (#pomodoros# P)</span>" + $template_lineBreak + "#comments#</li>"
        $template_EndColor = "</ul>    = #sectionsP# P" + $template_lineBreak
        $template_EndUser = $template_lineBreak + $template_lineBreak +"<strong> = #totalP# P</strong>" + $template_lineBreak + $template_lineBreak
    }

    $result = [System.Text.StringBuilder]::new()
    <# Then we group by user and color (task type), finally per task
       to create a statistic about the time that went in every task type and
       task in pomodoros. #>
    $entries | Group-Object userId | ForEach-Object {
        
        [void]$result.AppendLine($template_StartUser.Replace("#username#", $_.name))
        
        $totalP = 0.0

        $userColors = $_.group | Group-Object color
        $userColors | ForEach-Object {
            
            [void]$result.AppendLine($template_StartColor.Replace("#color#", $_.name))
            
            $sectionsP = 0.0

            $userTasks = $_.group | Group-Object -Property taskName
            $userTasks | ForEach-Object {
                $totalMinutes = ($_.group | Measure-Object durationInMinutes -Sum).Sum
                $number = $_.group[0].number
                $status = $_.group[0].status
                $pomodoros = [Math]::Round( $totalMinutes / 25, 1 )
                $sectionsP += $pomodoros
                $totalP += $pomodoros
                $taskText = $template_Task
                $taskText = $taskText.Replace("#nr#", $number.ToString())
                $taskText = $taskText.Replace("#pomodoros#", $pomodoros.ToString())
                $taskText = $taskText.Replace("#taskname#", $_.name)
                $taskText = $taskText.Replace("#column#", $status)
                
                $comments = ""
                foreach ($comment in (Get-Comments -ApiToken $ApiToken -TaskId $_.group[0].id)) {
                    
                    if ($comment.createdTimestamp -gt $from -and `
                        $comment.createdTimestamp -lt $to -and `
                        $comment.authorUserId -eq $_.group[0].userId) {
                        $comments += $comment.text + $template_lineBreak + $template_lineBreak
                    }
                }
                $comments = if ($comments -eq "") { ("_" + $template_lineBreak + $template_lineBreak) } else { $comments }
                $taskText = $taskText.Replace("#comments#", $comments)

                [void]$result.AppendLine($taskText)
            }

            [void]$result.AppendLine($template_EndColor.Replace("#sectionsP#", $sectionsP.ToString()))
        }

        
        [void]$result.AppendLine($template_EndUser.Replace("#totalP#", $totalP.ToString()))
    }

    $result.ToString()
}
