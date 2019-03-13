Describe "Get-KBFDayOverview" {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Kanbanflow
	. $PSScriptRoot/../../credentials-for-testing.ps1
	
	Context "when called" {
		InModuleScope Kanbanflow {
			Mock Get-KBFTask {
				'
				[
					{
						"_id":  "vyq7g4M9",
						"name":  "First task",
						"description":  "",
						"color":  "yellow",
						"columnId":  "tgGDUJmo1W72",
						"totalSecondsSpent":  0,
						"totalSecondsEstimate":  0,
						"columnName":  "Doing"
					},
					{
						"_id":  "vysQ17jX",
						"name":  "Second task",
						"description":  "",
						"color":  "yellow",
						"columnId":  "tgGDUJmo1W72",
						"totalSecondsSpent":  0,
						"totalSecondsEstimate":  0,
						"columnName":  "Doing"
					}
				]			
				' | ConvertFrom-Json
			}
			
			Mock Get-KBFTimeEntry {
				$result = '
				{
					"value":  [
								  {
									  "entryId":  "0bF10Q1",
									  "type":  "manual",
									  "userId":  "4ecd308d3b358db148dfe5f1a8af5d60",
									  "taskId":  "vyq7g4M9",
									  "startTimestamp":  "2019-03-02T08:00:00.000Z",
									  "endTimestamp":  "2019-03-02T10:09:00.000Z"
								  },
								  {
									  "entryId":  "0bF10Q2",
									  "type":  "manual",
									  "userId":  "4ecd308d3b358db148dfe5f1a8af5d60",
									  "taskId":  "vyq7g4M9",
									  "startTimestamp":  "2019-03-02T11:00:00.000Z",
									  "endTimestamp":  "2019-03-02T11:11:00.000Z"
								  },
								  {
									  "entryId":  "0bF10Q3",
									  "type":  "manual",
									  "userId":  "4ecd308d3b358db148dfe5f1a8af5d60",
									  "taskId":  "vysQ17jX",
									  "startTimestamp":  "2019-03-02T09:00:00.000Z",
									  "endTimestamp":  "2019-03-02T10:00:00.000Z"
								  }
							  ],							  
					"Count":  1
				}
				' | ConvertFrom-Json
				
				$result.value
			}
			
			It 'creates an overview of all the time spent on the board at that day' {
				$day = (Get-Date).Date.AddDays(-1)
				$result = Get-KBFDayOverview -ApiToken "Hello world" -Day $day
				
				$result[0].entryId | Should -Be "0bF10Q1"
				$result[0].taskName | Should -Be "First Task"
				$result[0].durationInMinutes | Should -Be 129
				
				$result[1].entryId | Should -Be "0bF10Q2"
				$result[1].taskName | Should -Be "First Task"
				$result[1].durationInMinutes | Should -Be 11

				$result[2].entryId | Should -Be "0bF10Q3"
				$result[2].taskName | Should -Be "Second task"
				$result[2].durationInMinutes | Should -Be 60
			}
		}
	}
}