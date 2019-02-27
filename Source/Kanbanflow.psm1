<#
    KANBANFLOW POWERSHELL MODULE

    This module implements about 95% of the kanbanflow api in an easily 
    consumable way so you can fill your kanbanboards with magic.

    Tested with powershell 5 and powershell core.
#>
$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Web

Push-Location $PSScriptRoot

Get-ChildItem -Filter "*.ps1" -Recurse | 
	ForEach-Object {
		#Write-Host "Loading $($_.Name) ..."
		. ($_.Fullname)
}

Pop-Location
