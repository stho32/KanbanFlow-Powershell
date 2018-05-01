<#

    Execute all unit tests

#>

$filesToCover = Get-ChildItem .\Source\Base -File -Recurse -Include *.ps1
Invoke-Pester -Path "./Tests" -CodeCoverage $filesToCover