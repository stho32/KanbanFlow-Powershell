<#
.SYNOPSIS
    Grab all manual-time-entries from a task
#>
function Get-ManualTimeEntries {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId        
    )

    Invoke-KanbanflowApi -Method "Get" -ApiToken $ApiToken -Command "tasks/$taskId/manual-time-entries"
}