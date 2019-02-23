function New-KBFTask {
    <#
        .SYNOPSIS
        Creates a new on a Kanbanflow board

        .EXAMPLE
        New-KBFTask -Name "Hello world" -ColumnId $todoColumn -ApiToken $apiToken
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$Name,
        [Parameter(Mandatory=$true)]
        [string]$ColumnId,
        [string]$SwimlaneId,
        [ValidateSet("yellow", "white", "red", "green", "blue", "purple", "orange", "cyan", "brown", "magenta")]
        [string]$Color,
        [string]$Description,
        [KanbanflowTaskNumber]$Number,
        [string]$ResponsibleUserId,
        [int]$TotalSecondsEstimate,
        [float]$PointsEstimate,
        [PSObject[]]$Dates,
        [PSObject[]]$SubTasks,
        [PSObject[]]$Labels,
        [PSObject[]]$Collaborators
    )
    
    Process {
        $data = New-Object PSObject -Property @{
            name = $Name
            columnId = $ColumnId
            swimlaneId = $SwimlaneId
            color = $Color
            description = $Description
            number = $number
            responsibleUserId = $responsibleUserId
            totalSecondsEstimate = $TotalSecondsEstimate
            pointsEstimate = $PointsEstimate
            dates = $Dates
            subTasks = $SubTasks
            labels = $Labels
            collaborators = $Collaborators
        }
        
        Invoke-KanbanflowApi -ApiToken $ApiToken -Method "Post" -Command "tasks" -Data $data
    }
}