function Update-KBFSubTask {
    <#
        .SYNOPSIS
        Update a subtask by name or id
    #>
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId,
        [Parameter(Mandatory=$true)]
        [string]$name,
        [switch]$finished,
        [Parameter(Mandatory=$true, ParameterSetName="ByName")]
        [string]$ByName,
        [Parameter(Mandatory=$true, ParameterSetName="ByIndex")]
        [int]$ByIndex   
    )

    $data = New-Object PSObject
    $data | Add-Member NoteProperty -Name name -Value $name
    $data | Add-Member NoteProperty -Name finished -Value $finished
    
    switch ($PsCmdlet.ParameterSetName)
    {
        "ByName"  { 
            $encodedByName = [System.Web.HttpUtility]::UrlEncode($_.name)
            Invoke-KBFApi -Method "Post" -ApiToken $ApiToken -Command "tasks/$taskId/subtasks/by-name/$encodedByName" -Data $data
        }
        "ByIndex"  { 
            Invoke-KBFApi -Method "Post" -ApiToken $ApiToken -Command "tasks/$taskId/subtasks/by-index/$ByIndex" -Data $data
        }
    } 
}