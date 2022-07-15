function Get-KBFCollaborator {
    <#
        .SYNOPSIS
        Gets all collaborators from a task by id
    #>
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId        
    )

    Invoke-KBFApi -Method "Get" -ApiToken $ApiToken -Command "tasks/$taskId/collaborators"

}
