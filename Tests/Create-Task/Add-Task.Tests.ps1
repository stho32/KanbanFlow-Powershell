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
        New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket-related (number)" -ColumnId $column -Number $number -Verbose

        $number = New-Object PSObject @{ value = 999 }
        New-KBFTask -ApiToken $testBoardApiToken -Name "Just a number assigned" -ColumnId $column -Number $number
    }
    
    It 'can add a task with a responsible user' {
        $column = (Get-Board -ApiToken $testBoardApiToken).columns[0].uniqueId
        $ResponsibleUserId = (Get-KBFUser -ApiToken $testBoardApiToken)._id

        New-KBFTask -ApiToken $testBoardApiToken -Name "Ticket with responsible user assigned" -ColumnId $column -ResponsibleUserId $ResponsibleUserId
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

}