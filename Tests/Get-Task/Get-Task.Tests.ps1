Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'Get-KBFTask' {
    It 'can read a tasks data from the board by id' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!" -ColumnId $column
        $taskFromBoard = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskFromBoard | Should -Not -BeNullOrEmpty
        $taskFromBoard.name | Should -Be "Hello world of Taskoboard!"
    }

    It 'can read a bunch of tasks from the board' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!" -ColumnId $column
        $tasksFromBoard = Get-KBFTask -columnName "To-do" -ApiToken $testBoardApiToken
        $tasksFromBoard | Should -Not -BeNullOrEmpty
        #Write-Host ($tasksFromBoard | ConvertTo-Json)
    }

    It 'can read a bunch of tasks from the board and convert them into a flat structure' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!" -ColumnId $column
        $tasksFromBoard = Get-KBFTask -columnName "To-do" -ApiToken $testBoardApiToken -Flat
        $tasksFromBoard | Should -Not -BeNullOrEmpty
        #Write-Host ($tasksFromBoard | ConvertTo-Json)
    }
}