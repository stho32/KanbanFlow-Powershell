Describe 'ConvertTo-DateTime' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Kanbanflow
	. $PSScriptRoot/../../credentials-for-testing.ps1

    it 'converts a string with the value of 2013-12-31T09:00:00Z to the right datetime' {
        $datetime = Get-Date -Year 2013 -Month 12 -Day 31 -Hour 10 -Minute 0 -Second 0
		$asString = "2013-12-31T09:00:00Z"
        $result   = $asString | ConvertTo-DateTime
		
        $result.Year   | Should -Be $datetime.Year
		$result.Month  | Should -Be $datetime.Month
		$result.Day    | Should -Be $datetime.Day
        $result.Hour   | Should -Be $datetime.Hour
		$result.Minute | Should -Be $datetime.Minute
		$result.Second | Should -Be $datetime.Second
    }   

    it 'does not touch the contents of an input that already is a datetime' {
		$datetime = Get-Date -Year 2018 -Month 5 -Day 4 -Hour 23 -Minute 59 -Second 59
		$result = $datetime | ConvertTo-DateTime

		$result        | Should -Be $datetime

        $result.Year   | Should -Be $datetime.Year
		$result.Month  | Should -Be $datetime.Month
		$result.Day    | Should -Be $datetime.Day
        $result.Hour   | Should -Be $datetime.Hour
		$result.Minute | Should -Be $datetime.Minute
		$result.Second | Should -Be $datetime.Second
    }  
}

