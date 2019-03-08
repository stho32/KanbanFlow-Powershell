function Clear-KBFBoard {
    <#
        .SYNOPSIS
        Removes all tasks from a board

        .DESCRIPTION
        Sometimes you like a board but there are a lot of tasks on it. 
        
        .EXAMPLE
        Clear-KBFBoard -ApiToken $apiToken
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )
    
    process {
        (Get-KBFTask -ApiToken $ApiToken).Tasks | 
            Remove-KBFTask -ApiToken $ApiToken
    }
    
}