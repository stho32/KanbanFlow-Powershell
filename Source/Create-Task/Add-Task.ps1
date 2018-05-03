<#
.SYNOPSIS
    Add a task to a Kanbanflow board
#>
function Add-Task {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [string]$Name = $null
    )
    
    $data = New-Object PSObject
    $data | Add-Member NoteProperty -Name columnIndex -Value 0
    
    if ($Name -ne $null) {
        $data | Add-Member NoteProperty -Name name -Value $Name
    }

    Invoke-KanbanflowApi -ApiToken $ApiToken -Method "Post" -Command "tasks" -Data $data

}