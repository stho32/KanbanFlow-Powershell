# KanbanFlow-Powershell
A powershell interface to kanbanflow (kanbanflow.com)

**Currently rewriting using Pester**

```powershell

WARNING: OS Information retrieval is not possible, reports will contain only partial system data
Executing all tests in './Tests'

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/Invoke-KanbanflowApi.Tests.ps1

  Describing Invoke-KanbanflowApi
    [+] can get the structure of a board as an example, that it can get stuff 1.46s
    [+] can invoke stuff by posting commands, by for example creating a task 212ms
    [+] throws an error if you invoke a post command without a data workload 86ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Base/New-KanbanflowAuthHeader.Tests.ps1

  Describing New-KanbanflowAuthHeader
    [+] creates this known test auth header correctly 124ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Board/Get-Board.Tests.ps1

  Describing Get-Board
    [+] grabs information about the testing board 146ms
    [+] s testing board name should be "Kanbanflow-Powershell-Testing" 28ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Board/Get-BoardColumn.Tests.ps1

  Describing Get-BoardColumn
    [+] grabs information about the column from the testing board by name 156ms
    [+] grabs information about the column from the testing board by uniqueId 96ms
    [+] grabs a list of all columns in case there is no filter value present 87ms
    [+] will return null if it cannot find a matching column 77ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Create-Task/Add-Task.Tests.ps1

  Describing Add-Task
    [+] can add a task with a name 165ms

Executing script /Users/shoff/Documents/Projekte/KanbanFlow-Powershell/Tests/Get-Task/Get-Task.Tests.ps1

  Describing Get-Task
    [+] can read a tasks data from the board by id 215ms
Tests completed in 2.86s
Tests Passed: 12, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0 

Code coverage report:
Covered 68,97 % of 58 analyzed Commands in 9 Files.
Missed commands:

File                        Function        Line Command                                                                                                                                                            
----                        --------        ---- -------                                                                                                                                                            
Get-Task/Get-Tasks.ps1      Get-Tasks         28 $urlParameters = New-Object psobject                                                                                                                               
Get-Task/Get-Tasks.ps1      Get-Tasks         31 KanbanflowApi-GetCommand -ApiToken $ApiToken -Method "Get" -Command "tasks"                                                                                        
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     26 $result = @()                                                                                                                                                      
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     27 $tasks = Get-Tasks $ApiToken                                                                                                                                       
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     28 $tasks                                                                                                                                                             
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     29 Where-Object columnName -in $Columns                                                                                                                               
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     30 Select-Object tasks                                                                                                                                                
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     30 % {...                                                                                                                                                             
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     31 if ($_.tasks -ne $null) {...                                                                                                                                       
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     32 $_.tasks                                                                                                                                                           
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     32 ForEach-Object {...                                                                                                                                                
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     33 $result += ,$_                                                                                                                                                     
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     38 return @( $result )                                                                                                                                                
Get-Task/Get-TasksFlat.ps1  Get-TasksFlat     38 $result                                                                                                                                                            
Update-Task/Update-Task.ps1 Update-TaskName   22 $data = New-Object psobject                                                                                                                                        
Update-Task/Update-Task.ps1 Update-TaskName   23 $data                                                                                                                                                              
Update-Task/Update-Task.ps1 Update-TaskName   23 Add-Member NoteProperty -Name "name" -Value $NewTaskName                                                                                                           
Update-Task/Update-Task.ps1 Update-TaskName   25 KanbanflowApi-PostCommand -ApiToken $ApiToken -TaskId $TaskId -data $data                                                                                          


```