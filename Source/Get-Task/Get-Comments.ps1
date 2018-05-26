<#
.SYNOPSIS
    Get comments of a task by their task id
#>
function Get-Comments {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$TaskId
    )

    Invoke-KanbanflowApi -ApiToken $ApiToken -Method "Get" -Command "tasks/$TaskId/comments"
}