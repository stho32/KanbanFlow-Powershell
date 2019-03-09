function Get-KBFUser {
    <#
        .SYNOPSIS
        Grabs the list of users from the board
        
        .EXAMPLE
        Get-KBFUser -ApiToken $apiToken
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )
    
    process {
        Invoke-KBFApi -ApiToken $ApiToken -Method "Get" -Command "users"
    }
}