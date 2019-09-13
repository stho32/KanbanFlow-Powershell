function Clear-KBFParameterObject {
    <#
        .SYNOPSIS
        We need to make sure that empty properties are cleaned of a parameter object before using it to send web requests
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [psobject]$Data
    )
    
    process {
        $result = New-Object -TypeName psobject

        # Remove empty properties from data
        $Data.PSObject.Properties | ForEach-Object {
            if ( -not([bool]$_.Value) ) {
                return
            }

            $result | Add-Member -MemberType NoteProperty -Value $_.Value -Name $_.Name
        }

        $result
    }
}