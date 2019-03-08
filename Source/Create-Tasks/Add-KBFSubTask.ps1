function Add-KBFSubTask {
    <#
    .SYNOPSIS
        Create a subtask
    #>
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId,
        [Parameter(Mandatory=$true)]
        [string]$name,
        [switch]$finished        
    )

    $data = New-Object PSObject
    $data | Add-Member NoteProperty -Name name -Value $name
    $data | Add-Member NoteProperty -Name finished -Value $finished
    
    Invoke-KBFApi -Method "Post" -ApiToken $ApiToken -Command "tasks/$taskId/subtasks" -Data $data

}