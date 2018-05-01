<#

    Execute all unit tests

#>

$filesToCover = Get-ChildItem .\Source -File -Recurse -Include *.ps1
Invoke-Pester -Path "./Tests" -CodeCoverage $filesToCover