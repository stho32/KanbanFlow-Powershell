function Remove-KBFTask {
    <#
        .SYNOPSIS
        Removes a task from a kanbanflow board

        .EXAMPLE
        $tasks | Remove-KBFTask -ApiToken $apiToken

        .EXAMPLE
        Remove-KBFTask -ApiToken $apiToken -Id $id
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,

        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [Alias("Id")]
        [string]$_id
    )
    
    process {
        Invoke-KBFApi -Method "Delete" -ApiToken $ApiToken -Command "tasks/$_id"
    }
}