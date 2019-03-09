function ConvertTo-KBFDateTime {
    <#
        .SYNOPSIS
        Converts a datetime to the date format of the Kanbanflow API
        .DESCRIPTION
        Converts a Datetime into the representation that kanbanflow understands, e.g.
        2013-12-31T09:00:00Z
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [DateTime]$DateTime
    )

	Process {
		$result = $DateTime.ToString("yyyy-MM-ddTHH:mm:ssZ")
		return $result;
	}
}