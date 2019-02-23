Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'Clear-Board' {
    It 'clears a board with tasks on it' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!" -ColumnId $column | Out-Null
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of 1!" -ColumnId $column | Out-Null
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of 2!" -ColumnId $column | Out-Null
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of 3!" -ColumnId $column | Out-Null

        $areThereTasks = [bool]((Get-Task -ApiToken $testBoardApiToken).tasks )
        $areThereTasks | Should -Be $true

        Clear-KBFBoard -ApiToken $testBoardApiToken 

        $areThereTasks = [bool]((Get-Task -ApiToken $testBoardApiToken).tasks )
        $areThereTasks | Should -Be $false
    }
}