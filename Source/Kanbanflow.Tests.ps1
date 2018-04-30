<#

    Tests for KanbanFlow Powershell Module

#>
Import-Module $PSScriptRoot/Kanbanflow.psm1
. $PSScriptRoot/../credentials-for-testing.ps1

Describe 'New-KanbanflowAuthHeader' {
    It 'creates this known test auth header correctly' {
        $authHeader = New-KanbanflowAuthHeader -ApiToken "abc"
        $authHeader["Authorization"] | Should -BeExactly "Basic YXBpVG9rZW46YWJj"
    }
}

Describe 'Get-KanbanflowBoard' {
    $board = Get-KanbanflowBoard -ApiToken $testBoardApiToken

    It 'grabs information about the testing board' {
        $board | Should -Not -BeNullOrEmpty
    }
    It 's testing board name should be "Kanbanflow-Powershell-Testing"' {
        $board.name | Should -BeExactly "Kanbanflow-Powershell-Testing"
    }
}


Describe 'Get-KanbanflowBoardColumns' {
    It 'returns a list of the columns within the board' {
    }
    It 'enables all other functions to reference columns by name' {
    }
}

Describe 'Get-KanbanflowTaskSubtasks' {}
Describe 'Get-KanbanflowTaskLabels' {}
Describe 'Get-KanbanflowTaskDates' {}
Describe 'Get-KanbanflowTaskCollaborators' {}
Describe 'Get-KanbanflowTaskComments' {}
Describe 'Get-KanbanflowTaskAttachments' {}
Describe 'Get-KanbanflowTaskTimeEntries' {}
Describe 'Get-KanbanflowTaskManualTimeEntries' {}

Describe 'Add-KanbanflowTask' {
    It 'creates a new task with a given name' {
        $newTask = Add-KanbanflowTask -ApiToken $testBoardApiToken `
                        -Name "A new testing task"
        $newTask | Should -Not -BeNullOrEmpty
        $newTask.taskId | Should -Not -BeNullOrEmpty
    }
}

Describe 'Add-KanbanflowTaskSubtask' {}
Describe 'Add-KanbanflowTaskLabel' {}
Describe 'Add-KanbanflowTaskDate' {}
Describe 'Add-KanbanflowTaskCollaborator' {}
Describe 'Add-KanbanflowTaskComment' {}
Describe 'Add-KanbanflowTaskAttachment' {}
Describe 'Add-KanbanflowTaskManualTimeEntry' {}

Describe 'Update-KanbanflowTask' {}
Describe 'Update-KanbanflowTaskSubtask' {}
Describe 'Update-KanbanflowTaskLabel' {}
Describe 'Update-KanbanflowTaskDate' {}
Describe 'Update-KanbanflowTaskCollaborator' {}
Describe 'Update-KanbanflowTaskComment' {}
Describe 'Update-KanbanflowTaskManualTimeEntry' {}

Describe 'Delete-KanbanflowTask' {}
Describe 'Delete-KanbanflowTaskSubtask' {}
Describe 'Delete-KanbanflowTaskLabel' {}
Describe 'Delete-KanbanflowTaskDate' {}
Describe 'Delete-KanbanflowTaskCollaborator' {}
Describe 'Delete-KanbanflowTaskComment' {}
Describe 'Delete-KanbanflowTaskAttachment' {}
Describe 'Delete-KanbanflowTaskManualTimeEntry' {}

Describe 'Get-KanbanflowStopwatchTimeEntries' {}
Describe 'Delete-KanbanflowStopwatchTimeEntries' {}
Describe 'Get-KanbanflowPomodoroTimeEntries' {}
Describe 'Delete-KanbanflowPomodoroTimeEntries' {}
Describe 'Get-KanbanflowManualTimeEntries' {}
Describe 'Delete-KanbanflowManualTimeEntries' {}

Describe 'Get-KanbanflowUsers' {}

Describe 'Get-KanbanflowBoardEvents' {}
Describe 'Get-KanbanflowTaskEvents' {}
Describe 'Get-KanbanflowTaskEvents' {}

Describe 'Get-KanbanflowBoardSnapshot' {
    It 'makes a screenshot/html snapshot of a kanbanflow board in a way that can be reviewed later' {}
}

