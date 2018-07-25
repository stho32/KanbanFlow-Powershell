<#
.SYNOPSIS
    Grab all labels from a task
#>
function Get-Labels {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId        
    )

    Invoke-KanbanflowApi -Method "Get" -ApiToken $ApiToken -Command "tasks/$taskId/labels"

}
