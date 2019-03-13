Describe 'ConvertTo-KBFDateTime' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Kanbanflow
	. $PSScriptRoot/../../credentials-for-testing.ps1

    it 'converts a matching DateTime to 2013-12-31T09:00:00Z' {
        $datetime = Get-Date -Year 2013 -Month 12 -Day 31 -Hour 9 -Minute 0 -Second 0
        $asString = ConvertTo-KBFDateTime $datetime
        $asString | Should -Be "2013-12-31T09:00:00Z"
    }   

    it 'converts a matching DateTime to 2013-05-04T23:59:59Z' {
        $datetime = Get-Date -Year 2018 -Month 5 -Day 4 -Hour 23 -Minute 59 -Second 59
        $asString = ConvertTo-KBFDateTime $datetime
        $asString | Should -Be "2018-05-04T23:59:59Z"
    }  
	
	it 'can use pipeline input' {
        $datetime = Get-Date -Year 2018 -Month 5 -Day 4 -Hour 23 -Minute 59 -Second 59
        $asString = $datetime | ConvertTo-KBFDateTime 
        $asString | Should -Be "2018-05-04T23:59:59Z"
    } 
}

