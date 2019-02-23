function Get-Dates {
    <#
        .SYNOPSIS
        Grab all dates from a task
    #>
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId        
    )

    Invoke-KanbanflowApi -Method "Get" -ApiToken $ApiToken -Command "tasks/$taskId/dates"

}
