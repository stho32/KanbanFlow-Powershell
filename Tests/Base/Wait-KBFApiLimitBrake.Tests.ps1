Describe 'Wait-KBFApiLimitBrake' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Kanbanflow
	. $PSScriptRoot/../../credentials-for-testing.ps1

    it 'simply does not throw an exception' {
		Wait-KBFApiLimitBrake
    }   
}

