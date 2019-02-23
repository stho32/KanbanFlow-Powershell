
function Get-TimeEntries {
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
    
    $fromAsString = (ConvertTo-KanbanflowDateTime $from)
    $toAsString = (ConvertTo-KanbanflowDateTime $to)

    $parameter = New-Object PSObject
    $parameter | Add-Member NoteProperty -Name from -Value $fromAsString
    $parameter | Add-Member NoteProperty -Name to -Value $toAsString
    $parameter | Add-Member NoteProperty -Name limit -Value 200
    
    Invoke-KanbanflowApi -ApiToken $ApiToken -Method "Get" -Command "time-entries" -Parameters $parameter

}