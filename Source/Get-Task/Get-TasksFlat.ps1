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