<#
.SYNOPSIS
    Grab all attachments from a task
#>
function Get-Attachments {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId        
    )

    Invoke-KanbanflowApi -Method "Get" -ApiToken $ApiToken -Command "tasks/$taskId/attachments"

}
