<#
.SYNOPSIS
    Adds a new member to a pscustom object in case it is not empty
.DESCRIPTION
    Sometimes we need to add a lot of options to a data or 
    url-parameter object to perform a call. But a big load of these
    parameters are optional. Since I do not like to repeat myself,
    this function takes care of that handling.
#>
function Add-MemberIfNotEmpty {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [psobject]$Data,
        [Parameter(Mandatory=$true)]
        [string]$PropertyName,
        [string]$PropertyValue = ""
    )

    if ( $PropertyValue -ne "" ) {
        $Data | Add-Member NoteProperty -Name $PropertyName -Value $PropertyValue
    }
}