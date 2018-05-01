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
        [Parameter(ParameterSetName="ByLabel", Mandatory=$true)]
        [string]$Label, 
        [Parameter(ParameterSetName="ByUniqueId", Mandatory=$true)]
        [string]$UniqueId
    )

    $board = Get-Board -ApiToken $ApiToken

    if ( $PSCmdlet.ParameterSetName -eq "ByLabel" ) {
        $column = ($board.columns | Where-Object { $_.name -eq $Label })
    }

    if ( $PSCmdlet.ParameterSetName -eq "ByUniqueId" ) {
        $column = ($board.columns | Where-Object { $_.uniqueId -eq $UniqueId })
    }

    return $column
}