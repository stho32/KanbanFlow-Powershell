Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'New-KBFTask' {
    It 'can add a task with a name' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        New-KBFTask -ApiToken $testBoardApiToken -Name "Hello world of Taskling!" -ColumnId $column
    }

    It 'can add a task with a color' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        New-KBFTask -ApiToken $testBoardApiToken -Name "Yellow" -ColumnId $column -Color "yellow"
        New-KBFTask -ApiToken $testBoardApiToken -Name "White" -ColumnId $column -Color "white"
        New-KBFTask -ApiToken $testBoardApiToken -Name "red" -ColumnId $column -Color "red"
        New-KBFTask -ApiToken $testBoardApiToken -Name "green" -ColumnId $column -Color "green"
    }

    It 'can add a task with a description' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        New-KBFTask -ApiToken $testBoardApiToken -Name "Yellow" -ColumnId $column -Description "This is very important!"
        New-KBFTask -ApiToken $testBoardApiToken -Name "White" -ColumnId $column -Description "Amazing!"
    }

    It 'can add a task with a number' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId

        $number = New-Object PSObject @{ prefix = "Ticket"; value = 10432 }
        New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket-related (number)" -ColumnId $column -Number $number

        $number = New-Object PSObject @{ value = 999 }
        New-KBFTask -ApiToken $testBoardApiToken -Name "Just a number assigned" -ColumnId $column -Number $number
    }
    
    It 'can add a task with a responsible user' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $ResponsibleUserId = (Get-KBFUser -ApiToken $testBoardApiToken)._id

        New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket with responsible user assigned" -ColumnId $column -ResponsibleUserId $ResponsibleUserId
    }

    It 'can add a task with a time estimate' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId

        New-KBFTask -ApiToken $testBoardApiToken -Name "Time estimate" -ColumnId $column -TotalSecondsEstimate 7200
    }

    It 'can add a task with a points estimate' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId

        New-KBFTask -ApiToken $testBoardApiToken -Name "Points estimate" -ColumnId $column -PointsEstimate 12.4
    }

    It 'can add a task with a due date' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $targetColumn = $column = (Get-Board -ApiToken $testBoardApiToken).columns[2].uniqueId
        $dueDate = ((Get-Date).Date).AddDays(1) | ConvertTo-KanbanflowDateTime
        $dates = @(
            (New-Object PSObject @{ dueTimestamp = $dueDate; targetColumnId = $targetColumn })
        )

        New-KBFTask -ApiToken $testBoardApiToken -Name "Due date" -ColumnId $column -Dates $dates
    }

    It 'can add a task with subtasks' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId

        $subtasks = @(
            (New-Object PSObject @{ name = "Abgeschlossen"; finished = $true }),
            (New-Object PSObject @{ name = "Apfel essen" }),
            (New-Object PSObject @{ name = "Banane essen" })
        )
        New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket with subtasks" -ColumnId $column -SubTasks $subtasks
    }

    It 'can add a task with labels' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId

        $labels = @(
            (New-Object PSObject @{ name = "Pinned"; pinned = $true }),
            (New-Object PSObject @{ name = "Unpinned" }),
            (New-Object PSObject @{ name = "Banane essen" })
        )
        New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket with labels" -ColumnId $column -Labels $labels
    }

    It 'can add a task with collaborators' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $Collaborators = (Get-KBFUser -ApiToken $testBoardApiToken) | ForEach-Object {
            New-Object PSObject @{ userId = $_._id }
        }

        New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket with collaborators" -ColumnId $column -Collaborators $Collaborators
    }

}