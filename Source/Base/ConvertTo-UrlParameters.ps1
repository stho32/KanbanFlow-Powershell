function ConvertTo-UrlParameters {
    <#
        .SYNOPSIS
        Converts a custom object to correctly encoded url parameters
        
        .DESCRIPTION
        When I need a lot of url parameters this function helps me
        with encoding and concatenating them using ? and &.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [psobject]$Data,
        [switch]$StartWithQuestionmark
    )

    Process {
        $position = 0
        $result = ""

        $Data.PSObject.Properties | ForEach-Object {
            if ($position -eq 0) {
                $result = "&"
                if ( $StartWithQuestionmark ) {
                    $result = "?"
                }
            }
            else {
                $result += "&"
            }
            $result += $_.Name 
            $result += "="
            $result += [System.Web.HttpUtility]::UrlEncode($_.Value, [System.Text.Encoding]::UTF8)
            $position += 1
        }

        $result
    }
}