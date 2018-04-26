# KanbanFlow-Powershell
A powershell interface to kanbanflow (kanbanflow.com)

## Example usage

```powershell
Import-Module $PSScriptRoot/../Source/Kanbanflow.psm1

$apiToken = "<Your token here>"

$tasks = Get-TasksFlat $apiToken -Columns "To-Do","Do today","In progress"
$tasks
```