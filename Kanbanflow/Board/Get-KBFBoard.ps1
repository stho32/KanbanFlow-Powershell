function Get-KBFBoard {
    <#
        .SYNOPSIS
        Get Kanbanflow Board
        
        .DESCRIPTION
        Gets all information for a kanbanflow board which means 
        that you get color and structure information but you do 
        not get the task info. 
        
        .EXAMPLE
        Get-Board -ApiToken $ApiToken
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

	Process {
	    Invoke-KBFApi -ApiToken $ApiToken -Method "Get" -Command "board"
	}
}


