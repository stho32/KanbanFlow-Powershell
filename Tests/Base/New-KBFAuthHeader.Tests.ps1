Describe 'New-KBFAuthHeader' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Kanbanflow
	. $PSScriptRoot/../../credentials-for-testing.ps1

    It 'creates this known test auth header correctly' {
        $authHeader = New-KBFAuthHeader -ApiToken "abc"
        $authHeader["Authorization"] | Should -BeExactly "Basic YXBpVG9rZW46YWJj"
    }
}
