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
    
    $authentication = New-KanbanflowAuthHeader -ApiToken $ApiToken

    $data = New-Object PSObject
    $data | Add-Member NoteProperty -Name columnIndex -Value 0
    
    if ($Name -ne $null) {
        $data | Add-Member NoteProperty -Name name -Value $Name
    }

    $asJson = $data | ConvertTo-Json -Compress

    Write-Host ($authentication | ConvertTo-Json)
    Write-Host $asJson

    Invoke-RestMethod -Method Post `
        -Headers $authentication `
        -ContentType "application/json" `
        -Uri https://kanbanflow.com/api/v1/tasks `
        -Body $asJson

}