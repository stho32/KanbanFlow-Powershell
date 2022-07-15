function Add-KBFLabel {
    <#
        .SYNOPSIS
        Creates a label
    #>
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId,
        [Parameter(Mandatory=$true)]
        [string]$name,
        [switch]$pinned        
    )

    $data = New-Object PSObject
    $data | Add-Member NoteProperty -Name name -Value $name
    $data | Add-Member NoteProperty -Name pinned -Value $pinned
    
    Invoke-KBFApi -Method "Post" -ApiToken $ApiToken -Command "tasks/$taskId/labels" -Data $data

}