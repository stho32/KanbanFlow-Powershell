function New-KBFAuthHeader {
    <#
        .SYNOPSIS
        Create a base64 auth header for Kanbanflow authentication

        .DESCRIPTION
        Kanbanflow recommends using base64 encoded authentication 
        that is embedded within the header of requests.

        This function takes in an ApiToken and generates a Hashtable
        which can be passed as Header to Invoke-RestMethod.

        .EXAMPLE
        $headers = New-KBFAuthHeader -ApiToken "..."
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )
	
	Process {
		$credentials = "apiToken:" + $ApiToken
		$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($credentials))

		@{Authorization=("Basic " + $base64AuthInfo)}
	}
}