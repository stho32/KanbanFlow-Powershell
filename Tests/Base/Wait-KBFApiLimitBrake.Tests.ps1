Describe 'Wait-KBFApiLimitBrake' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
	. $PSScriptRoot/../../credentials-for-testing.ps1

    it 'simply does not throw an exception' {
		Wait-KBFApiLimitBrake
    }   
}

