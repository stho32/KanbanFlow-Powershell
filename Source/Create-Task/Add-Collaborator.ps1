<#
.SYNOPSIS
    Add a collaborator to a card
#>
function Add-Collaborator {
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
    
    Invoke-KanbanflowApi -Method "Post" -ApiToken $ApiToken -Command "tasks/$taskId/collaborators" -Data $data

}