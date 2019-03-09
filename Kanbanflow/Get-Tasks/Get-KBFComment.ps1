function Get-KBFComment {
    <#
        .SYNOPSIS
        Get comments of a task by their task id
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$TaskId
    )

    Invoke-KBFApi -ApiToken $ApiToken -Method "Get" -Command "tasks/$TaskId/comments"
}