# New-KBFAuthHeader

*Create a base64 auth header for Kanbanflow authentication*

Kanbanflow recommends using base64 encoded authentication
that is embedded within the header of requests.

This function takes in an ApiToken and generates a Hashtable
which can be passed as Header to Invoke-RestMethod.

## Example Nr. 1
$headers = New-KBFAuthHeader -ApiToken "..."


<small>To get the full information type PS> `Get-Help .`</small>
