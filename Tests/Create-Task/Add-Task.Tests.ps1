Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'New-KBFTask' {
    It 'can add a task with a name' {
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskling!"
    }
}