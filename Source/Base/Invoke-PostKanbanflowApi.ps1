<# 
.SYNOPSIS
    Issues a POST request to the Kanbanflow API
.DESCRIPTION
    The Kanbanflow API accepts 2 types of commands: 
    GET and POST.

    This function gives you a simple to use framework to 
    use it.
#>
function Invoke-PostKanbanflowApi {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$UrlCommandPart,
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [psobject]$data = $null
    )

    $authentication = New-KanbanflowAuthHeader -ApiToken $ApiToken

    if ($data -eq $null) {
        $data = New-Object PSObject
    }

    $asJson = $data | ConvertTo-Json -Compress

    Invoke-RestMethod -Method Post `
        -Headers $authentication `
        -ContentType "application/json" `
        -Uri https://kanbanflow.com/api/v1/$UrlCommandPart `
        -Body $asJson
}