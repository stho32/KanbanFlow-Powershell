Describe 'Get-KBFBoard' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Kanbanflow
	. $PSScriptRoot/../../credentials-for-testing.ps1
    $board = Get-KBFBoard -ApiToken $testBoardApiToken

    It 'grabs information about the testing board' {
        $board | Should -Not -BeNullOrEmpty
    }
    
    It 's testing board name should be "Kanbanflow-Powershell-Testing"' {
        $board.name | Should -BeExactly "Kanbanflow-Powershell-Testing"
    }
}