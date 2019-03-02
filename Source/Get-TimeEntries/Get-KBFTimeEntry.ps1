function Get-KBFTimeEntry {
    <#
        .SYNOPSIS
        Get all time entries that are available
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [DateTime]$From,
        [Parameter(Mandatory=$true)]
        [DateTime]$To
    )

    Process {

        $parameter = New-Object PSObject -Property @{
            from = (ConvertTo-KanbanflowDateTime $from)
            to = (ConvertTo-KanbanflowDateTime $to)
            limit = 200
        }
        
        Invoke-KanbanflowApi -ApiToken $ApiToken -Method "Get" -Command "time-entries" -Parameters $parameter

    }
}