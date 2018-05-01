Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'Invoke-KanbanflowApi' {
    
    It 'can get the structure of a board as an example, that it can get stuff' {
        $board = Invoke-KanbanflowApi -ApiToken $testBoardApiToken -Method "Get" -Command "board"
        $board.name | Should -Be "Kanbanflow-Powershell-Testing"
    }

    It 'can invoke stuff by posting commands, by for example creating a task' {
        $newTask = New-Object psobject
        $newTask | Add-Member NoteProperty -Name columnIndex -Value 0
        $newTask | Add-Member NoteProperty -Name name -Value "Hello world"
        
        $task = Invoke-KanbanflowApi -ApiToken $testBoardApiToken -Method "Post" -Command "tasks" -Data $newTask

        $task.taskId | Should -Not -BeNullOrEmpty
    }

    It 'throws an error if you invoke a post command without a data workload' {
        {
            Invoke-KanbanflowApi -ApiToken $testBoardApiToken -Method "Post" -Command "tasks"
        } | Should -Throw "You have invoked a post command but did not pass any data! Please add -Data <PSObject> to add a data load to the command."
    }

}