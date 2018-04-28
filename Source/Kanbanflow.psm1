<#
.Synopsis
    Get Kanbanflow Board
.DESCRIPTION
    Gets all information for a kanbanflow board which means 
    that you get color and structure information but you do 
    not get the task info. 
.EXAMPLE
    Get-KFBoard
#>
function Get-Board {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    Invoke-RestMethod -Uri https://kanbanflow.com/api/v1/board?apiToken=$ApiToken
}

<#
.Synopsis
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
        [string]$ApiToken
    )
    
    Invoke-RestMethod -Uri https://kanbanflow.com/api/v1/tasks?apiToken=$ApiToken
}

<#
.Synopsis
    Get all Tasks from a kanban board - but not nested within 
    columns
.DESCRIPTION
    Gets all tasks for a kanbanflow board
    
    Requesting the api directly would give you a structure where 
    every column is a seperate nested array. 

    With this function you basically say what columns you want to "select" and all tasks
    that are contained in those are collected and passed to you as an array.
    Which is much better suited for analysis.

.EXAMPLE
    Get-TasksFlat -ApiToken "..." -Columns "To-Do","Doing"

#>
function Get-TasksFlat {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string[]]$Columns
    )

    $result = @()
    $tasks = Get-Tasks $ApiToken
    $tasks | 
        Where-Object columnName -in $Columns | 
        Select-Object tasks | % {
            if ($_.tasks -ne $null) {
                $_.tasks | ForEach-Object {
                    $result += ,$_
                }
            } 
        }
    
    return @( $result )
}

<#
.Synopsis
    Update the name of a task

.DESCRIPTION
    Update a task name on a kanban board by taskId
    
.EXAMPLE
    Update-Task -ApiToken "..." -TaskId "..." -NewTaskName "New task name"
#>
function Update-TaskName {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$TaskId,
        [Parameter(Mandatory=$true)]
        [string]$NewTaskName
    )

    $authentication = New-KanbanflowHeaderAuth -ApiToken $ApiToken

    Invoke-RestMethod -Headers $authentication `
        -Method Post -Uri https://kanbanflow.com/api/v1/tasks/$TaskId -ContentType "application/json" -Body "{ `"name`":`"$NewTaskName`"}"
}

<#
.SYNOPSIS
    Create a base64 auth header for Kanbanflow authentication

.DESCRIPTION
    Kanbanflow recommends using base64 encoded authentication 
    that is embedded within the header of requests.

    This function takes in an ApiToken and generates a PSCustomObject
    which can be passed as Header to Invoke-RestMethod.

.EXAMPLE
    $headers = New-KanbanflowAuthHeader -ApiToken "..."
#>
function New-KanbanflowAuthHeader {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    $credentials = "apiToken:" + $ApiToken
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($credentials))

    return @{Authorization=("Basic " + $base64AuthInfo)}
}

<#
.Synopsis
    Get Kanbanflow Board
.DESCRIPTION
    Gets all information for a kanbanflow board which means 
    that you get color and structure information but you do 
    not get the task info. 
.EXAMPLE
    Get-KanbanflowBoard -ApiToken $boardApiToken
#>
function Get-KanbanflowBoard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    $authentication = New-KanbanflowAuthHeader -ApiToken $ApiToken
    Invoke-RestMethod -Method Get -Headers $authentication `
        -Uri https://kanbanflow.com/api/v1/board
}

# Exports for the module
Export-ModuleMember -Function New-KanbanflowAuthHeader
Export-ModuleMember -Function Get-KanbanflowBoard
Export-ModuleMember -Function Get-Board
Export-ModuleMember -Function Get-Tasks
Export-ModuleMember -Function Get-TasksFlat
Export-ModuleMember -Function Update-TaskName
