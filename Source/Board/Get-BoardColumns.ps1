<#
.SYNOPSIS
    Grabs information about all columns from a kanban board
.EXAMPLE
    $columns = Get-KanbanflowBoardColumns -ApiToken $testBoardApiToken
#>
function Get-BoardColumns {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    $board = Get-Board -ApiToken $ApiToken

    return $board.columns
}