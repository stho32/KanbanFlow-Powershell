Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'Get-BoardColumn' {

    It 'grabs information about the column from the testing board by name' {
        $todoColumn = Get-BoardColumn -ApiToken $testBoardApiToken -Label "To-Do"
        $todoColumn.uniqueId | Should -Be "tgGDUJmo1W72"
        $todoColumn.name | Should -Be "To-do"
    }

    It 'grabs information about the column from the testing board by uniqueId' {
        $todoColumn = Get-BoardColumn -ApiToken $testBoardApiToken -UniqueId "tgGDUJmo1W72"
        $todoColumn.uniqueId | Should -Be "tgGDUJmo1W72"
        $todoColumn.name | Should -Be "To-do"
    }

}