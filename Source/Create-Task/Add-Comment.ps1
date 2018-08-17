<#
.SYNOPSIS
    Add a collaborator to a card
#>
function Add-Comment {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId,
        [Parameter(Mandatory=$true)]
        [string]$text,
        [Parameter(Mandatory=$true)]
        [string]$authorUserId,
        [string]$createdTimestamp = $null
    )

    $data = New-Object PSObject
    $data | Add-Member NoteProperty -Name text -Value $text
    $data | Add-Member NoteProperty -Name authorUserId -Value $authorUserId
    $data | Add-Member NoteProperty -Name createdTimestamp -Value $createdTimestamp
    
    Invoke-KanbanflowApi -Method "Post" -ApiToken $ApiToken -Command "tasks/$taskId/comments" -Data $data

}