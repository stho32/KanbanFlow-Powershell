# KanbanFlow-Powershell
A powershell interface to kanbanflow (kanbanflow.com)

**Last testing results**

```powershell
WARNING: OS Information retrieval is not possible, reports will contain only partial system data
Executing all tests in './Tests'

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/ConvertTo-KanbanflowDateTime.Tests.ps1

  Describing ConvertTo-KanbanflowDateTime
    [+] converts a matching DateTime to 2013-12-31T09:00:00Z 1.5s
    [+] converts a matching DateTime to 2013-05-04T23:59:59Z 82ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/Invoke-KanbanflowApi.Tests.ps1

  Describing Invoke-KanbanflowApi
    [+] can get the structure of a board as an example, that it can get stuff 411ms
    [+] can invoke stuff by posting commands, by for example creating a task 139ms
    [+] throws an error if you invoke a post command without a data workload 83ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/New-KanbanflowAuthHeader.Tests.ps1

  Describing New-KanbanflowAuthHeader
    [+] creates this known test auth header correctly 93ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Board/Get-Board.Tests.ps1

  Describing Get-Board
    [+] grabs information about the testing board 136ms
    [+] s testing board name should be "Kanbanflow-Powershell-Testing" 25ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Board/Get-BoardColumn.Tests.ps1

  Describing Get-BoardColumn
    [+] grabs information about the column from the testing board by name 183ms
    [+] grabs information about the column from the testing board by uniqueId 117ms
    [+] grabs a list of all columns in case there is no filter value present 103ms
    [+] will return null if it cannot find a matching column 93ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Create-Task/Add-Task.Tests.ps1

  Describing Add-Task
    [+] can add a task with a name 158ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Get-Task/Get-Task.Tests.ps1

  Describing Get-Task
    [+] can read a tasks data from the board by id 251ms
    [+] can read a bunch of tasks from the board 243ms
    [+] can read a bunch of tasks from the board and convert them into a flat structure 251ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Get-TimeEntries/Get-TimeEntries.Tests.ps1

  Describing Get-TimeEntries

    [+] grabs all time entries within a time span 159ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Update-Task/Update-Task.Tests.ps1

  Describing Update-Task
    [+] can change the name of a task 379ms
Tests completed in 4.41s
Tests Passed: 18, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0 

Code coverage report:
Covered 100,00 % of 106 analyzed Commands in 11 Files.

```
