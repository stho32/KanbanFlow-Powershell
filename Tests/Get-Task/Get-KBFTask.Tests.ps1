Describe 'Get-KBFTask' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Kanbanflow
	. $PSScriptRoot/../../credentials-for-testing.ps1

    It 'can read a tasks data from the board by id' {
        $column = (Get-KBFBoard -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!" -ColumnId $column
        $taskFromBoard = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskFromBoard | Should -Not -BeNullOrEmpty
        $taskFromBoard.name | Should -Be "Hello world of Taskoboard!"
    }

    It 'can read tasks from a column' {
        $column = (Get-KBFBoard -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!" -ColumnId $column

        $tasksFromBoard = Get-KBFTask -columnName "To-do" -ApiToken $testBoardApiToken
        $tasksFromBoard | Should -Not -BeNullOrEmpty
        #Write-Host ($tasksFromBoard | ConvertTo-Json)
    }

    It 'can read tasks from a column' {
        $column = (Get-KBFBoard -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!" -ColumnId $column
        $tasksFromBoard = Get-KBFTask -columnName "To-do" -ApiToken $testBoardApiToken
        $tasksFromBoard | Should -Not -BeNullOrEmpty
        #Write-Host ($tasksFromBoard | ConvertTo-Json)
    }


    It 'can read a bunch of tasks from the board and convert them into a flat structure' {
        $column = (Get-KBFBoard -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!" -ColumnId $column
        $tasksFromBoard = Get-KBFTask -columnName "To-do" -ApiToken $testBoardApiToken -Flat
        $tasksFromBoard | Should -Not -BeNullOrEmpty
        #Write-Host ($tasksFromBoard | ConvertTo-Json)
    }
	
	
}