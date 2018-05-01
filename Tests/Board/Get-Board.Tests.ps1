Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'Get-Board' {
    $board = Get-Board -ApiToken $testBoardApiToken

    It 'grabs information about the testing board' {
        $board | Should -Not -BeNullOrEmpty
    }
    It 's testing board name should be "Kanbanflow-Powershell-Testing"' {
        $board.name | Should -BeExactly "Kanbanflow-Powershell-Testing"
    }
}