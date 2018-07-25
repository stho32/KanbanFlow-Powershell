<#
.SYNOPSIS
    Grab all time-entries from a task
#>
function Get-TimeEntries {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId        
    )

    Invoke-KanbanflowApi -Method "Get" -ApiToken $ApiToken -Command "tasks/$taskId/time-entries"

}