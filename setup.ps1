<#

    This file installs needed powershell modules in case they
    are missing.

#>

Write-Host "Setting up for 'Pester' for unit test support..."
Install-Module Pester -Force -SkipPublisherCheck
