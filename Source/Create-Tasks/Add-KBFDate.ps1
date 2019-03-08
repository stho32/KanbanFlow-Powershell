function Add-KBFDate {
    <#
        .SYNOPSIS
        Create a Date
    #>
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId,
        [Parameter(Mandatory=$true)]
        [DateTime]$dueTimestamp,
        [Parameter(Mandatory=$true)]
        [string]$targetColumnId,
        [string]$status = "active"
    )

    $data = New-Object PSObject
    $data | Add-Member NoteProperty -Name dueTimestamp -Value $dueTimestamp
    $data | Add-Member NoteProperty -Name targetColumnId -Value $targetColumnId
    $data | Add-Member NoteProperty -Name status -Value $status
    
    Invoke-KBFApi -Method "Post" -ApiToken $ApiToken -Command "tasks/$taskId/dates" -Data $data

}