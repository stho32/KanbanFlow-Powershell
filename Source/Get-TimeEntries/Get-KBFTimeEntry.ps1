function Get-KBFTimeEntry {
    <#
        .SYNOPSIS
        Get all time entries that are available
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [DateTime]$From,
        [Parameter(Mandatory=$true)]
        [DateTime]$To
    )

    Process {
        $parameter = New-Object PSObject -Property @{
            from  = $from | ConvertTo-KBFDateTime
            to    = $to   | ConvertTo-KBFDateTime
            limit = 2000
        }
        
        $result = Invoke-KBFApi -ApiToken $ApiToken -Method "Get" -Command "time-entries" -Parameters $parameter
		$result.value
    }
}