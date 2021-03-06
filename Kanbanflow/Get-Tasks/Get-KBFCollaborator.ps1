function Get-KBFCollaborator {
    <#
        .SYNOPSIS
        Grab all collaborators from a task
    #>
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId        
    )

    Invoke-KBFApi -Method "Get" -ApiToken $ApiToken -Command "tasks/$taskId/collaborators"

}
