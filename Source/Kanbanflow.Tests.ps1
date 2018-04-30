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

Describe 'Add-KanbanflowTask' {
    It 'creates a new task with a given name' {
        $newTask = Add-KanbanflowTask -ApiToken $testBoardApiToken `
                        -Name "A new testing task"
        $newTask | Should -Not -BeNullOrEmpty
        $newTask.taskId | Should -Not -BeNullOrEmpty
    }
}

Describe 'Get-KanbanflowBoardColumns' {
    It 'returns a list of the columns within the board' {
    }
    It 'enables all other functions to reference columns by name' {
    }
}

Describe 'Update-KanbanflowTask' {}
Describe 'Delete-KanbanflowTask' {}

