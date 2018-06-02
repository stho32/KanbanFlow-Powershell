<#
.SYNOPSIS
   Get Task by its number 
#>
function Get-TaskByNumber {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$number
    )

    $tasks = (Get-Task -ApiToken $apiToken -Flat) 
    $task = $tasks | Where-Object { $_.number.value -eq $number }

    $task
}
