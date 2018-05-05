<#

    This file installs needed powershell modules in case they
    are missing.

#>

Write-Host "Checking for 'Pester' for unit test support..."
Write-Host "To ensure we have the correct version on a cleanly installed VM on azure or google cloud we need to remove it..."
Remove-Module Pester 
Write-Host "Removing the module wont work on new VMs but on cleanly installed computers."
Write-Host "Thus we can now assume that, if we find a directory there, it has not been cleanly installed..."
if (Test-Path -Path "C:\Program Files\WindowsPowerShell\Modules\Pester" ) {
    Remove-Item -Force -Recurse -Path "C:\Program Files\WindowsPowerShell\Modules\Pester"
}
if (Test-Path -Path "C:\Program Files (x86)\WindowsPowerShell\Modules\Pester" ) {
    Remove-Item -Force -Recurse -Path "C:\Program Files (x86)\WindowsPowerShell\Modules\Pester"
}
Install-Module Pester -Force -SkipPublisherCheck
