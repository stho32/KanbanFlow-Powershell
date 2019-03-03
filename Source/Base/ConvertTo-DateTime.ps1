function ConvertTo-DateTime {
	<#
		.SYNOPSIS
		Converts a string into a datetime
		
		.DESCRIPTION
		If the InputObject is a string, it'll be converted into a DateTime. 
		But if it is a DateTime, it wont be touched. It just will be passed through.
		
		This is needed to make this library compatible for Powershell 5.
		Powershell 6 automatically recognizes DateTimes and converts them from the
		kanbanflow format into normal DateTimes. But Powershell 5 does not. 
		
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
