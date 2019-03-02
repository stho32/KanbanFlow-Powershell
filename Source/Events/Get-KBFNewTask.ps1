function Get-KBFNewTask {
    <#
        .SYNOPSIS
        Using the events from a kanban board, grab me a list of all 
        tasks that have been created in a certain time range
        (The tasks can only be loaded when they still exist. If 
        they do not exist anymore, they will be omitted.)
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [DateTime]$From,
        [Parameter(Mandatory=$true)]
        [DateTime]$To
    )
    
    $events = Get-Events -ApiToken $apiToken -From $from -To $to
    $tasks = (Get-Task -ApiToken $apiToken -Flat)

    $events | ForEach-Object {
        $_.detailedEvents | ForEach-Object {
            $event = $_
            if ( $event.eventType -eq "taskCreated" ) {
                $task = $tasks | Where-Object { $_._id -eq $event.taskId }
                if ( $task -ne $null ) {
                    $task
                }
            }
        }
    }
}