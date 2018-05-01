<#
.SYNOPSIS
    Issues a get command to the kanbanflow api
.DESCRIPTION
    The Kanbanflow API accepts two command types: GET and POST.
    This function encapsulates everything that is needed for a 
    valid get request.
#>
function Invoke-KanbanflowApi {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [ValidateSet("Get","Post")] 
        [Parameter(Mandatory=$true)]
        [string]$Method,
        [Parameter(Mandatory=$true)]
        [string]$Command,
        [psobject]$Data = $null
    )

    $authentication = New-KanbanflowAuthHeader -ApiToken $ApiToken

    if ( $Method -eq "Get" ) {
        Invoke-RestMethod `
            -Method Get `
            -Headers $authentication `
            -Uri https://kanbanflow.com/api/v1/$Command

        return
    }

    if ( $Method -eq "Post" ) {
        if ($Data -eq $null) {
            throw "You have invoked a post command but did not pass any data! Please add -Data <PSObject> to add a data load to the command."
        }

        $asJson = $Data | ConvertTo-Json -Compress
        
        Invoke-RestMethod -Method Post `
            -Headers $authentication `
            -ContentType "application/json" `
            -Uri https://kanbanflow.com/api/v1/$Command `
            -Body $asJson  

        return
    }
}