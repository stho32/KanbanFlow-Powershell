<#
.SYNOPSIS
    Create a base64 auth header for Kanbanflow authentication

.DESCRIPTION
    Kanbanflow recommends using base64 encoded authentication 
    that is embedded within the header of requests.

    This function takes in an ApiToken and generates a PSCustomObject
    which can be passed as Header to Invoke-RestMethod.

.EXAMPLE
    $headers = New-KanbanflowAuthHeader -ApiToken "..."
#>
function New-KanbanflowAuthHeader {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    $credentials = "apiToken:" + $ApiToken
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($credentials))

    return @{Authorization=("Basic " + $base64AuthInfo)}
}