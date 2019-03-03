function ConvertTo-DateTime {
	<#
		.SYNOPSIS
		Converts a string into a datetime
		
		.DESCRIPTION
		If the InputObject is a string, it'll be converted into a DateTime. 
		But if it is a DateTime, it wont be touched. It just will be passed through.
		
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
			return [DateTime]::Parse($InputObject)
		}
		$InputObject
	}
}
