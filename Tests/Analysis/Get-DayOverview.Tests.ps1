Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe "Get-DayOverview" {
    It 'XYZ NOTEST creates an overview of all the things that happend on the boards with timings' {
        $day = (Get-Date).Date.AddDays(-1)
        Get-DayOverview -ApiToken $testBoardApiToken -Day $day
    }
}