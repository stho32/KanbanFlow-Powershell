Describe 'Update-KBFTask' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Kanbanflow
	. $PSScriptRoot/../../credentials-for-testing.ps1

    It 'can change the name of a task' {
        $column = (Get-KBFBoard -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!" -ColumnId $column
        Update-KBFTask -ApiToken $testBoardApiToken -TaskId $task.taskId -NewTaskName "A new name for a new world"
        $updatedTask = Get-KBFTask -ApiToken $testBoardApiToken -TaskId $task.taskId
        $updatedTask.name | Should -Be "A new name for a new world"
    }
}