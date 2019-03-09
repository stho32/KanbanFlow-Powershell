function Get-KBFDayOverview {
    <#
        .SYNOPSIS
        Grabs all time entries, groups them as report

        .DESCRIPTION
        Sometimes you have to report what your day was like.
        No problem if you used the kanbanflow timer features.
		
		.EXAMPLE
		Get-KBFDayOverview -ApiToken $board -Day ((Get-Date).Date) 
    #>    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiToken,
        [Parameter(Mandatory = $true)]
        [DateTime]$Day
    )

    Process {
        $from    = ($Day).Date
        $to      = $from.AddDays(1).AddSeconds(-1)

        $entries = Get-KBFTimeEntry -From $from -To $to -ApiToken $ApiToken
		<# Normally we would have a big amount of api calls to get all the task
		   information we need. Instead we read all tasks of the board to be
		   faster. 
		   This will work for now. Obviously this will become more and more problematic
		   the longer a board lives and the more tasks it contains.
		#>
        $tasks   = Get-KBFTask -ApiToken $ApiToken -Flat

        <# 
            We enrich the time entries with task information.
			This way it is much easier to interpret.
        #>
        foreach ($entry in $entries) {
            $task = ($tasks | Where-Object {$_._id -eq $entry.taskId})
			Write-Debug "task and entry chosen"
            $fromDateTime = $entry.startTimeStamp | ConvertTo-DateTime
            $tillDateTime = $entry.endTimeStamp   | ConvertTo-DateTime

            $durationInMinutes = [Math]::Round(($tillDateTime - $fromDateTime).TotalMinutes, 0)

            $entry | Add-Member NoteProperty -Name taskName -Value $task.name
            $entry | Add-Member NoteProperty -Name durationInMinutes -Value $durationInMinutes
            $entry | Add-Member NoteProperty -Name color -Value $task.color
            $entry | Add-Member NoteProperty -Name number -Value $task.number.value
            $entry | Add-Member NoteProperty -Name status -Value $task.columnName
            $entry | Add-Member NoteProperty -Name id -Value $task._id 
        }
		
		Write-Debug "shortly before the final output"
		$entries
    }
}
