Describe 'New-KBFTask' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
	. $PSScriptRoot/../../credentials-for-testing.ps1

    It 'can add a task with a name' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskling!" -ColumnId $column 
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.name | Should -Be "Hello world of Taskling!"
        #Write-Host $taskDetail -ForegroundColor White
    }

    It 'can add a task with a color' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Yellow" -ColumnId $column -Color "yellow"
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.color | Should -Be "yellow"

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "White" -ColumnId $column -Color "white"
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.color | Should -Be "white"

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "red" -ColumnId $column -Color "red"
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.color | Should -Be "red"

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "green" -ColumnId $column -Color "green"
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.color | Should -Be "green"
    }

    It 'can add a task with a description' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Yellow" -ColumnId $column -Description "This is very important!"
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.description | Should -Be "This is very important!"

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "White" -ColumnId $column -Description "Amazing!"
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.description | Should -Be "Amazing!"
    }

    It 'can add a task with a number' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId

        $number = New-Object PSObject @{ prefix = "Ticket"; value = 10432 }
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket-related (number)" -ColumnId $column -Number $number
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.number.value | Should -Be 10432
        $taskDetail.number.prefix | Should -Be "Ticket"

        $number = New-Object PSObject @{ value = 999 }
        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Just a number assigned" -ColumnId $column -Number $number
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.number.value | Should -Be 999
        $taskDetail.number.prefix | Should -BeNullOrEmpty
    }
    
    It 'can add a task with a responsible user' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $ResponsibleUserId = (Get-KBFUser -ApiToken $testBoardApiToken)._id

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket with responsible user assigned" -ColumnId $column -ResponsibleUserId $ResponsibleUserId
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.responsibleUserId | Should -Be $ResponsibleUserId
    }

    It 'can add a task with a time estimate' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Time estimate" -ColumnId $column -TotalSecondsEstimate 7200
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.TotalSecondsEstimate | Should -Be 7200
    }

	<#
	The api can either work with time or point estimations.
	Since I cannot switch the way the board works through the api, the test
	for the points estimate is commented out. 

    It 'can add a task with a points estimate' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Points estimate" -ColumnId $column -PointsEstimate 12.4
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken

        Write-Host $taskDetail -ForegroundColor "White"
        $taskDetail.PointsEstimate | Should -Be 12.4
    }
	#>

    It 'can add a task with a due date' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $targetColumn = (Get-Board -ApiToken $testBoardApiToken).columns[2].uniqueId
        $dueDate = ((Get-Date).Date).AddDays(1) | ConvertTo-KanbanflowDateTime
        $dates = @(
            (New-Object PSObject @{ dueTimestamp = $dueDate; targetColumnId = $targetColumn })
        )

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Due date" -ColumnId $column -Dates $dates
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
		
        $taskDetail.dates[0].dueTimestamp   | Should -Be $dueDate
        $taskDetail.dates[0].targetColumnId | Should -Be $targetColumn
    }

    It 'can add a task with subtasks' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId

        $subtasks = @(
            (New-Object PSObject @{ name = "Abgeschlossen"; finished = $true }),
            (New-Object PSObject @{ name = "Apfel essen" }),
            (New-Object PSObject @{ name = "Banane essen" })
        )

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket with subtasks" -ColumnId $column -SubTasks $subtasks
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken

        $taskDetail.subtasks[0].name | Should -Be "Abgeschlossen"
        $taskDetail.subtasks[0].finished | Should -Be $true
        $taskDetail.subtasks[1].name | Should -Be "Apfel essen"
        $taskDetail.subtasks[1].finished | Should -Be $false
        $taskDetail.subtasks[2].name | Should -Be "Banane essen"
        $taskDetail.subtasks[2].finished | Should -Be $false
    }

    It 'can add a task with labels' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId

        $labels = @(
            (New-Object PSObject @{ name = "Pinned"; pinned = $true }),
            (New-Object PSObject @{ name = "Unpinned" }),
            (New-Object PSObject @{ name = "Banane essen" })
        )

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket with labels" -ColumnId $column -Labels $labels
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.labels[0].name | Should -Be "Pinned"
        $taskDetail.labels[0].pinned | Should -Be $true
        $taskDetail.labels[1].name | Should -Be "Unpinned"
        $taskDetail.labels[1].pinned | Should -Be $false        
        $taskDetail.labels[2].name | Should -Be "Banane essen"
        $taskDetail.labels[2].pinned | Should -Be $false
    }

    It 'can add a task with collaborators' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $Collaborators = (Get-KBFUser -ApiToken $testBoardApiToken) | ForEach-Object {
            New-Object PSObject -Property @{ userId = $_._id }
        }

        $task = New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket with collaborators" -ColumnId $column -Collaborators $Collaborators
        $taskDetail = Get-KBFTask -TaskId $task.taskId -ApiToken $testBoardApiToken
        $taskDetail.collaborators[0].userId | Should -Be $Collaborators[0].userId
    }

}