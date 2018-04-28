<#

    This file installs needed powershell modules in case they
    are missing.

#>

Write-Host "Checking for 'Pester' for unit test support..."
if (!(Get-Module -ListAvailable -Name Pester)) {
    Install-Module -Name Pester -Force -SkipPublisherCheck
}
Write-Host "Checking if 'Pester' is available in the newest version..."
Update-Module -Name Pester