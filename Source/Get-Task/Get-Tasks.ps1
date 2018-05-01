<#
.SYNOPSIS
    Get all Tasks from a kanban board
.DESCRIPTION
    Gets all tasks for a kanbanflow board the 
    kanbanflow way. So each column is an object
    which in turn contains an array of tasks.

    If you want the tasks in a flat array without
    column information use "Get-TasksFlat" instead.
.EXAMPLE
    Get-Tasks
#>
function Get-Tasks {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [string]$columnId = $null,
        [string]$columnName = $null,
        [string]$columnIndex = $null,
        [string]$startTaskId = $null,
        [string]$startGroupingDate = $null,
        [string]$limit = $null,
        [string]$order = $null
    )
    
    $urlParameters = New-Object psobject


    KanbanflowApi-GetCommand -ApiToken $ApiToken -UrlCommandPart "tasks"
}