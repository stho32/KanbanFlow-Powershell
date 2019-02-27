function ConvertTo-DateTime {
	<#
		.SYNOPSIS
		Converts a string into a datetime
		
		.EXAMPLE
		"2019-02-28T00:00:00Z" | ConvertTo-DateTime
	#>
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[PSObject]$InputObject
	)
	
	Process {
		if ( $InputObject.GetType().Name -eq "String" ) {
			[DateTime]::Parse($fromDateTime)
		}
	}
}
