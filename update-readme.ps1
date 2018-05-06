<#

    Execute all unit tests

#>

$testResults = (Get-Content $PSScriptRoot/test-results.txt -Raw)
$readme = (Get-Content $PSScriptRoot/README.template.md -Raw)

$readme = $readme.Replace('$testingResults$', $testResults)
$readme | Set-Content $PSScriptRoot/README.md