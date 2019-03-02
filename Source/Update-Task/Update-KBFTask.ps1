function Update-KBFTask {
    <#
        .SYNOPSIS
        Update the name of a task

        .DESCRIPTION
        Update a task name on a kanban board by taskId
        
        .EXAMPLE
        Update-Task -ApiToken "..." -TaskId "..." -NewTaskName "New task name"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$TaskId,
        [Parameter(Mandatory=$true)]
        [string]$NewTaskName
    )

    $data = New-Object psobject
    $data | Add-Member NoteProperty -Name "name" -Value $NewTaskName

    Invoke-KanbanflowApi -Method "Post" -ApiToken $ApiToken -Command "tasks/$TaskId" -data $data
}