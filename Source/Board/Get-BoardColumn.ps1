<#
.SYNOPSIS
    Grabs the unique id from a column label
.EXAMPLE
    $columnTodo = Get-KanbanflowBoardColumnUniqueId -ApiToken $testBoardApiToken -Name "To-Do"
#>
function Get-BoardColumn {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$Label
    )

    $board = Get-KanbanflowBoard -ApiToken $ApiToken

    $columnUniqueId = ($board.columns | Where-Object { $_.name -eq $Label }).uniqueId 

    return $columnUniqueId
}