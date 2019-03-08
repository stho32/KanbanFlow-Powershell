Describe 'Clear-KBFBoard' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
	. $PSScriptRoot/../../credentials-for-testing.ps1

    It 'clears a board with tasks on it' {
        $column = (Get-KBFBoard -ApiToken $testBoardApiToken).columns[0].uniqueId
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!" -ColumnId $column | Out-Null
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of 1!" -ColumnId $column | Out-Null
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of 2!" -ColumnId $column | Out-Null
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of 3!" -ColumnId $column | Out-Null

        $areThereTasks = [bool]((Get-KBFTask -ApiToken $testBoardApiToken).tasks )
        $areThereTasks | Should -Be $true

        Clear-KBFBoard -ApiToken $testBoardApiToken 

        $areThereTasks = [bool]((Get-KBFTask -ApiToken $testBoardApiToken).tasks )
        $areThereTasks | Should -Be $false
    }
}