Describe 'Get-TimeEntries' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
	. $PSScriptRoot/../../credentials-for-testing.ps1

    # Note : These unit tests do a wrong thing as they
    #        rely on data that i manually created in the testing system
    #        and that cannot easily be recreated in another testing system

    It 'grabs all time entries within a time span' {
        $from = (Get-Date -Year 2018 -Month 5 -Day 6).Date
        $to = $from.AddDays(1).AddSeconds(-1)

        $entries = Get-TimeEntries -From $from -To $to -ApiToken $testBoardApiToken
        Write-Host ($entries | ConvertTo-Json)
    }
}