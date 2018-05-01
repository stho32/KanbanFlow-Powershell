<#
.SYNOPSIS
    Issues a get command to the kanbanflow api
.DESCRIPTION
    The Kanbanflow API accepts two command types: GET and POST.
    This function encapsulates everything that is needed for a 
    valid get request.
#>
function Invoke-GetKanbanflowApi {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$UrlCommandPart,
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    $authentication = New-KanbanflowAuthHeader -ApiToken $ApiToken
    Invoke-RestMethod -Method Get -Headers $authentication `
        -Uri https://kanbanflow.com/api/v1/$UrlCommandPart
}