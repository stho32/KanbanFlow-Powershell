<#
.SYNOPSIS
    Get a task by its ID
#>
function Get-Task {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$TaskId
    )
    
    KanbanflowApi-GetCommand -ApiToken $ApiToken -UrlCommandPart "tasks/$TaskId"
}