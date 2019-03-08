function Get-KBFTimeEntryByTask {
    <#
        .SYNOPSIS
        Grab all time-entries from a task
    #>
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId        
    )

    Invoke-KBFApi -Method "Get" -ApiToken $ApiToken -Command "tasks/$taskId/time-entries"

}