function Invoke-KBFApi {
    <#
        .SYNOPSIS
        Sends a HTTP Request to the Kanbanflow API 

        .DESCRIPTION
        The Kanbanflow API accepts the following HTTP Methods: GET, POST and DELETE.
        This function encapsulates everything that is needed for a valid request.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [ValidateSet("Get","Post", "Delete")] 
        [Parameter(Mandatory=$true)]
        [string]$Method,
        [Parameter(Mandatory=$true)]
        [string]$Command,
        [psobject]$Data = $null,
        [psobject]$Parameters = $null
    )

    Process {
		Wait-KBFApiLimitBrake
        $authentication = New-KBFAuthHeader -ApiToken $ApiToken

        if ( [bool]$Data ) {
            $Data = Clear-KBFParameterObject $Data

            Write-Verbose ($Data | ConvertTo-Json)
        }

        if ( [bool]$Parameters ) {
            $Parameters = Clear-KBFParameterObject $Parameters

            Write-Verbose ($Parameters | ConvertTo-Json)
        }


        if ( $Method -eq "Get" ) {
            $url = "https://kanbanflow.com/api/v1/$Command" 
            
            if ($null -ne $Parameters) {
                $ParametersEncoded = ConvertTo-UrlParameters $Parameters -StartWithQuestionmark 
                $url = $url + $ParametersEncoded
            }

            $result = Invoke-RestMethod `
						-Method Get `
						-Headers $authentication `
						-Uri $url
			
			if ([bool]$result) {
				Write-Verbose ($result | ConvertTo-Json)
			}
			$result
        }

        if ( $Method -eq "Post" ) {
            if ($null -eq $Data) {
                throw "You have invoked a post command but did not pass any data! Please add -Data <PSObject> to add a data load to the command."
            }

            $asJson = $Data | ConvertTo-Json -Compress
            
            Invoke-RestMethod -Method Post `
                -Headers $authentication `
                -ContentType "application/json" `
                -Uri https://kanbanflow.com/api/v1/$Command `
                -Body $asJson  
        }

        if ( $Method -eq "Delete" ) {
            $result = Invoke-RestMethod -Method Delete `
                                        -Headers $authentication `
                                        -Uri https://kanbanflow.com/api/v1/$Command
            
            # in case nothing special happens, we avoid a newline that is returned
            if ([bool]$result) {
                $result
            }
        }
    }
}