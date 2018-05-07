# KanbanFlow-Powershell
A powershell interface to kanbanflow (kanbanflow.com)

**Last testing results**

```powershell
WARNING: OS Information retrieval is not possible, reports will contain only partial system data
Executing all tests in './Tests'

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/ConvertTo-KanbanflowDateTime.Tests.ps1

  Describing ConvertTo-KanbanflowDateTime
    [+] converts a matching DateTime to 2013-12-31T09:00:00Z 1.59s
    [+] converts a matching DateTime to 2013-05-04T23:59:59Z 80ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/Invoke-KanbanflowApi.Tests.ps1

  Describing Invoke-KanbanflowApi
    [+] can get the structure of a board as an example, that it can get stuff 304ms
    [+] can invoke stuff by posting commands, by for example creating a task 113ms
    [+] throws an error if you invoke a post command without a data workload 74ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/New-KanbanflowAuthHeader.Tests.ps1

  Describing New-KanbanflowAuthHeader
    [+] creates this known test auth header correctly 85ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Board/Get-Board.Tests.ps1

  Describing Get-Board
    [+] grabs information about the testing board 123ms
    [+] s testing board name should be "Kanbanflow-Powershell-Testing" 26ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Board/Get-BoardColumn.Tests.ps1

  Describing Get-BoardColumn
    [+] grabs information about the column from the testing board by name 134ms
    [+] grabs information about the column from the testing board by uniqueId 90ms
    [+] grabs a list of all columns in case there is no filter value present 81ms
    [+] will return null if it cannot find a matching column 69ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Create-Task/Add-Task.Tests.ps1

  Describing Add-Task
    [+] can add a task with a name 120ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Get-Task/Get-Task.Tests.ps1

  Describing Get-Task
    [+] can read a tasks data from the board by id 180ms
    [+] can read a bunch of tasks from the board 181ms
    [+] can read a bunch of tasks from the board and convert them into a flat structure 201ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Get-TimeEntries/Get-TimeEntries.Tests.ps1

  Describing Get-TimeEntries

    [+] grabs all time entries within a time span 130ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Update-Task/Update-Task.Tests.ps1

  Describing Update-Task
    [+] can change the name of a task 242ms
Tests completed in 3.84s
Tests Passed: 18, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0 

Code coverage report:
Covered 82,81 % of 128 analyzed Commands in 15 Files.
Missed commands:

File                           Function             Line Command               
----                           --------             ---- -------               
Base/Invoke-KanbanflowApi.ps1  Invoke-KanbanflowApi   57 if ( $Method -eq "D...
Base/Invoke-KanbanflowApi.ps1  Invoke-KanbanflowApi   59 Invoke-RestMethod -...
Create-Task/Add-SubTask.ps1    Add-SubTask            16 $data = New-Object ...
Create-Task/Add-SubTask.ps1    Add-SubTask            17 $data                 
Create-Task/Add-SubTask.ps1    Add-SubTask            17 Add-Member NoteProp...
Create-Task/Add-SubTask.ps1    Add-SubTask            18 $data                 
Create-Task/Add-SubTask.ps1    Add-SubTask            18 Add-Member NoteProp...
Create-Task/Add-SubTask.ps1    Add-SubTask            20 Invoke-KanbanflowAp...
Delete-Task/Delete-SubTask.ps1 Delete-SubTask         17 $PsCmdlet.Parameter...
Delete-Task/Delete-SubTask.ps1 Delete-SubTask         20 $encodedByName = [S...
Delete-Task/Delete-SubTask.ps1 Delete-SubTask         21 Invoke-KanbanflowAp...
Delete-Task/Delete-SubTask.ps1 Delete-SubTask         24 Invoke-KanbanflowAp...
Get-Task/Get-SubTasks.ps1      Get-SubTasks           13 Invoke-KanbanflowAp...
Update-Task/Update-SubTask.ps1 Update-SubTask         20 $data = New-Object ...
Update-Task/Update-SubTask.ps1 Update-SubTask         21 $data                 
Update-Task/Update-SubTask.ps1 Update-SubTask         21 Add-Member NoteProp...
Update-Task/Update-SubTask.ps1 Update-SubTask         22 $data                 
Update-Task/Update-SubTask.ps1 Update-SubTask         22 Add-Member NoteProp...
Update-Task/Update-SubTask.ps1 Update-SubTask         24 $PsCmdlet.Parameter...
Update-Task/Update-SubTask.ps1 Update-SubTask         27 $encodedByName = [S...
Update-Task/Update-SubTask.ps1 Update-SubTask         28 Invoke-KanbanflowAp...
Update-Task/Update-SubTask.ps1 Update-SubTask         31 Invoke-KanbanflowAp...



```
