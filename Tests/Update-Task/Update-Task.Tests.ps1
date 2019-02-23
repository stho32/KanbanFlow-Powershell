Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'Update-Task' {
    It 'can change the name of a task' {
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskling!"
        Update-TaskName -ApiToken $testBoardApiToken -TaskId $task.taskId -NewTaskName "A new name for a new world"
        $updatedTask = Get-Task -ApiToken $testBoardApiToken -TaskId $task.taskId
        $updatedTask.name | Should -Be "A new name for a new world"
    }
}