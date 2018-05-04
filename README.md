# KanbanFlow-Powershell
A powershell interface to kanbanflow (kanbanflow.com)

**Currently rewriting using Pester**

```powershell
[H[2JWARNING: OS Information retrieval is not possible, reports will contain only partial system data
Executing all tests in './Tests'

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/Invoke-KanbanflowApi.Tests.ps1

  Describing Invoke-KanbanflowApi
    [+] can get the structure of a board as an example, that it can get stuff 1.56s
    [+] can invoke stuff by posting commands, by for example creating a task 167ms
    [+] throws an error if you invoke a post command without a data workload 82ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/New-KanbanflowAuthHeader.Tests.ps1

  Describing New-KanbanflowAuthHeader
    [+] creates this known test auth header correctly 118ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Board/Get-Board.Tests.ps1

  Describing Get-Board
    [+] grabs information about the testing board 141ms
    [+] s testing board name should be "Kanbanflow-Powershell-Testing" 27ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Board/Get-BoardColumn.Tests.ps1

  Describing Get-BoardColumn
    [+] grabs information about the column from the testing board by name 133ms
    [+] grabs information about the column from the testing board by uniqueId 85ms
    [+] grabs a list of all columns in case there is no filter value present 77ms
    [+] will return null if it cannot find a matching column 69ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Create-Task/Add-Task.Tests.ps1

  Describing Add-Task
    [+] can add a task with a name 136ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Get-Task/Get-Task.Tests.ps1

  Describing Get-Task
    [+] can read a tasks data from the board by id 188ms
    [+] can read a bunch of tasks from the board 337ms
    [+] can read a bunch of tasks from the board and convert them into a flat structure 337ms
Tests completed in 3.46s
Tests Passed: 14, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0 

Code coverage report:
Covered 94,51 % of 91 analyzed Commands in 9 Files.
Missed commands:

File                             Function                Line Command          
----                             --------                ---- -------          
Base/ConvertTo-UrlParameters.ps1 ConvertTo-UrlParameters   26 $result += "&"   
Update-Task/Update-Task.ps1      Update-TaskName           22 $data = New-Ob...
Update-Task/Update-Task.ps1      Update-TaskName           23 $data            
Update-Task/Update-Task.ps1      Update-TaskName           23 Add-Member Not...
Update-Task/Update-Task.ps1      Update-TaskName           25 KanbanflowApi-...

```