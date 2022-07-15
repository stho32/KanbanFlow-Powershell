function Get-KBFEvent {
    <#
        .SYNOPSIS
        Gets the event entries from a board
        e.g. to find out which tasks are new today
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
    
    $fromAsString = (ConvertTo-KBFDateTime $from)
    $toAsString = (ConvertTo-KBFDateTime $to)

    $parameter = New-Object PSObject
    $parameter | Add-Member NoteProperty -Name from -Value $fromAsString
    $parameter | Add-Member NoteProperty -Name to -Value $toAsString
    
    (Invoke-KBFApi -ApiToken $ApiToken -Method "Get" -Command "board/events" -Parameters $parameter).events

}