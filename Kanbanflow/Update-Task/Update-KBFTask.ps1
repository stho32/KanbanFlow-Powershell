function Update-KBFTask {
    <#
        .SYNOPSIS
        Updates the name of a task by id

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

    Invoke-KBFApi -Method "Post" -ApiToken $ApiToken -Command "tasks/$TaskId" -data $data
}