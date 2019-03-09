# Getting Board Information

```powershell
Import-Module "C:\Projekte\KanbanFlow-Powershell\Source\Kanbanflow.psm1"
$token = "<YOUR API TOKEN>"

$board = Get-KBFBoard -ApiToken $token
```

At this moment $board will contain an object with _id, name of the board and information about columns, swimlanes and colors.
