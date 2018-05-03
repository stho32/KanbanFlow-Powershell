Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'Add-Task' {
    It 'can add a task with a name' {
        Add-Task -ApiToken $testBoardApiToken -Name "Hello world of Taskling!"
    }
}