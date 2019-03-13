Describe 'Remove-KBFTask' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Kanbanflow
	. $PSScriptRoot/../../credentials-for-testing.ps1

    It 'can remove a task by Id' {
        $column = (Get-KBFBoard -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "This one should be removed!" -ColumnId $column

        $taskIsThere = [bool]((Get-KBFTask -ApiToken $testBoardApiToken).tasks | Where-Object { $_._id -eq $task.taskId })
        $taskIsThere | Should -Be $true

        Remove-KBFTask -ApiToken $testBoardApiToken -Id $task.taskId

        $taskIsThere = [bool]((Get-KBFTask -ApiToken $testBoardApiToken).tasks | Where-Object { $_._id -eq $task.taskId })
        $taskIsThere | Should -Be $false
    }
}