Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'Get-Task' {
    It 'can read a tasks data from the board by id' {
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!"
        $taskFromBoard = Get-Task -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskFromBoard | Should -Not -BeNullOrEmpty
        $taskFromBoard.name | Should -Be "Hello world of Taskoboard!"
    }

    It 'can read a bunch of tasks from the board' {
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboardolings!"
        $tasksFromBoard = Get-Task -columnName "To-do" -ApiToken $testBoardApiToken
        $tasksFromBoard | Should -Not -BeNullOrEmpty
        #Write-Host ($tasksFromBoard | ConvertTo-Json)
    }

    It 'can read a bunch of tasks from the board and convert them into a flat structure' {
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskoboardolings!"
        $tasksFromBoard = Get-Task -columnName "To-do" -ApiToken $testBoardApiToken -Flat
        $tasksFromBoard | Should -Not -BeNullOrEmpty
        #Write-Host ($tasksFromBoard | ConvertTo-Json)
    }
}