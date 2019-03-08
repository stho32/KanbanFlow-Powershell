Describe 'Get-KBFUser' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
	. $PSScriptRoot/../../credentials-for-testing.ps1

    $users = Get-KBFUser -ApiToken $testBoardApiToken

    It 'grabs information about the users of the testing board' {
        $users | Should -Not -BeNullOrEmpty
    }
    
    It 'has found your user name (adapt test to your name)' {
        # I know. I know. Not a perfect unit test. 
        # Enter your name here to make sure the test is working for you.
        $users.fullName | Should -BeExactly "Stefan Hoffmann"
    }
}