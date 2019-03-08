function Remove-KBFSubTask {
    <#
        .SYNOPSIS
        Delete a subtask by name or id
    #>
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$taskId,
        [Parameter(Mandatory=$true, ParameterSetName="ByName")]
        [string]$ByName,
        [Parameter(Mandatory=$true, ParameterSetName="ByIndex")]
        [int]$ByIndex   
    )

    switch ($PsCmdlet.ParameterSetName)
    {
        "ByName"  { 
            $encodedByName = [System.Web.HttpUtility]::UrlEncode($_.name)
            Invoke-KBFApi -Method "Delete" -ApiToken $ApiToken -Command "tasks/$taskId/subtasks/by-name/$encodedByName" -Data $data
        }
        "ByIndex"  { 
            Invoke-KBFApi -Method "Delete" -ApiToken $ApiToken -Command "tasks/$taskId/subtasks/by-index/$ByIndex" -Data $data
        }
    } 
}