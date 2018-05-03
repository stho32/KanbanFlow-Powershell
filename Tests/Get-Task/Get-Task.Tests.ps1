Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'Get-Task' {
    It 'can read a tasks data from the board by id' {
        $task = Add-Task -ApiToken $testBoardApiToken -Name "Hello world of Taskoboard!"
        $taskFromBoard = Get-Task -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskFromBoard | Should -Not -BeNullOrEmpty
        $taskFromBoard.name | Should -Be "Hello world of Taskoboard!"
    }
}