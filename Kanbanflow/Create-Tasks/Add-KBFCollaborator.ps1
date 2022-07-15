function Add-KBFCollaborator {
    <#
        .SYNOPSIS
        Adds a collaborator to a card
    #>
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId,
        [Parameter(Mandatory=$true)]
        [string]$userId
    )

    $data = New-Object PSObject
    $data | Add-Member NoteProperty -Name userId -Value $userId
    
    Invoke-KBFApi -Method "Post" -ApiToken $ApiToken -Command "tasks/$taskId/collaborators" -Data $data

}