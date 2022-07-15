function Get-KBFTaskByNumber {
    <#
        .SYNOPSIS
    Gets a Task by its number 
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$number
    )

    $tasks = (Get-KBFTask -ApiToken $apiToken -Flat) 
    $task = $tasks | Where-Object { $_.number.value -eq $number }

    $task
}
