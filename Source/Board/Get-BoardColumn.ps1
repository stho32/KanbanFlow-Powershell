function Get-BoardColumn {
    <#
        .SYNOPSIS
        Grabs the unique id from a column label
        
        .EXAMPLE
        $columnTodo = Get-KanbanflowBoardColumnUniqueId -ApiToken $testBoardApiToken -Name "To-Do"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [string]$Label = "", 
        [string]$UniqueId = ""
    )

    $board = Get-Board -ApiToken $ApiToken
    $columns = $board.columns

    if ( $Label -ne "" ) {
        $columns = @($columns | Where-Object { $_.name -eq $Label })
    }

    if ( $UniqueId -ne "" ) {
        $columns = @($columns | Where-Object { $_.uniqueId -eq $UniqueId })
    }

    if ( $columns.Length -eq 0 ) { return $null }
    if ( $columns.Length -eq 1 ) { return $columns[0] }

    return $columns
}