Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'New-KanbanflowAuthHeader' {
    It 'creates this known test auth header correctly' {
        $authHeader = New-KanbanflowAuthHeader -ApiToken "abc"
        $authHeader["Authorization"] | Should -BeExactly "Basic YXBpVG9rZW46YWJj"
    }
}
