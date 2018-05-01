# KanbanFlow-Powershell
A powershell interface to kanbanflow (kanbanflow.com)

**Currently rewriting using Pester**

```powershell

Executing all tests in './Tests'

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/Invoke-KanbanflowApi.Tests.ps1

  Describing Invoke-KanbanflowApi
    [+] can get the structure of a board as an example, that it can get stuff 1.02s
    [+] can invoke stuff by posting commands, by for example creating a task 175ms
    [+] throws an error if you invoke a post command without a data workload 102ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/New-KanbanflowAuthHeader.Tests.ps1

  Describing New-KanbanflowAuthHeader
    [+] creates this known test auth header correctly 108ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Board/Get-Board.Tests.ps1

  Describing Get-Board
    [+] grabs information about the testing board 123ms
    [+] s testing board name should be "Kanbanflow-Powershell-Testing" 27ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Board/Get-BoardColumn.Tests.ps1

  Describing Get-BoardColumn
    [+] grabs information about the column from the testing board by name 137ms
    [+] grabs information about the column from the testing board by uniqueId 82ms
    [+] grabs a list of all columns in case there is no filter value present 78ms
    [+] will return null if it cannot find a matching column 71ms
Tests completed in 1.92s
Tests Passed: 10, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0 

Code coverage report:
Covered 100,00 % of 18 analyzed Commands in 2 Files.
[1]+  Done                    clear

```