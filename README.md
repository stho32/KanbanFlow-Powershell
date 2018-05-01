# KanbanFlow-Powershell
A powershell interface to kanbanflow (kanbanflow.com)

**Currently rewriting using Pester**




## Get all tasks from specific columns

```powershell
Import-Module $PSScriptRoot/../Source/Kanbanflow.psm1

$apiToken = "<Your token here>"

$tasks = Get-TasksFlat $apiToken -Columns "To-Do","Do today","In progress"
$tasks
```

## Now you can perform simple statistics in an automated way
```powershell
Import-Module $PSScriptRoot/../Source/Kanbanflow.psm1

$apiToken = "<Your token here>"

$tasks = Get-TasksFlat $apiToken -Columns "To-Do","Do today","In progress","Bereit zum Review"

$greenTasks = $tasks | Where-Object color -eq "green"
#$yellowTasks = $tasks | Where-Object color -eq "yellow"

if ($tasks.length -ge 0) {
    $percentageTasksGreen = $greenTasks.length / $tasks.length
    $percentageTasksGreen = [Math]::Round($percentageTasksGreen*100, 2)
    Write-Host "$percentageTasksGreen% of active tasks belong to the primary project."

    if ( $percentageTasksGreen -lt 66 ) {
        Write-Host "Are you sure you focus on the right stuff?" -ForegroundColor Red
    } else {
        Write-Host "Looks good to me."  -ForegroundColor Green
    }
}
```

## Further Ideas
  - Add/Update 1 task on the board regularily with statistics
  - Alert boss, when assigned task count drops below X
  - Add tasks based on events in the company