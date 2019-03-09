function Format-KBFDayOverview {
	<#
		.SYNOPSIS
		Formats the output of Get-KBFDayOverview in a better way
		
		.EXAMPLE
		Get-KBFDayOverview -ApiToken $board -Day ((Get-Date).Date)  | Format-KBFDayOverview -Format Text
	#>
	[CmdletBinding()]
	Param(
        [ValidateSet("Text", "Html")]
        [string]$format = "Text"	
	)
	
	Process {
        $template_lineBreak = "`n"
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
            $template_EndUser = $template_lineBreak + $template_lineBreak + "<strong> = #totalP# P</strong>" + $template_lineBreak + $template_lineBreak
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
                            $comments += $comment.text.Replace("`n", $template_lineBreak) + $template_lineBreak + $template_lineBreak
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
}