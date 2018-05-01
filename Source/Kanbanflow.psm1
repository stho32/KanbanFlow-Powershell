<#
    KANBANFLOW POWERSHELL MODULE

    This module implements about 95% of the kanbanflow api in an easily 
    consumable way so you can fill your kanbanboards with magic.

    Tested with powershell 5 and powershell core.
#>


<#
.SYNOPSIS
    Create a base64 auth header for Kanbanflow authentication

.DESCRIPTION
    Kanbanflow recommends using base64 encoded authentication 
    that is embedded within the header of requests.

    This function takes in an ApiToken and generates a PSCustomObject
    which can be passed as Header to Invoke-RestMethod.

.EXAMPLE
    $headers = New-KanbanflowAuthHeader -ApiToken "..."
#>
function New-KanbanflowAuthHeader {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    $credentials = "apiToken:" + $ApiToken
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($credentials))

    return @{Authorization=("Basic " + $base64AuthInfo)}
}


<#
.SYNOPSIS
    Issues a get command to the kanbanflow api
.DESCRIPTION
    The Kanbanflow API accepts two command types: GET and POST.
    This function encapsulates everything that is needed for a 
    valid get request.
#>
function KanbanflowApi-GetCommand {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$UrlCommandPart,
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    $authentication = New-KanbanflowAuthHeader -ApiToken $ApiToken
    Invoke-RestMethod -Method Get -Headers $authentication `
        -Uri https://kanbanflow.com/api/v1/$UrlCommandPart
}

<# 
.SYNOPSIS
    Issues a POST request to the Kanbanflow API
.DESCRIPTION
    The Kanbanflow API accepts 2 types of commands: 
    GET and POST.

    This function gives you a simple to use framework to 
    use it.
#>
function KanbanflowApi-PostCommand {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$UrlCommandPart,
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [psobject]$data = $null
    )

    $authentication = New-KanbanflowAuthHeader -ApiToken $ApiToken

    if ($data -eq $null) {
        $data = New-Object PSObject
    }

    $asJson = $data | ConvertTo-Json -Compress

    Invoke-RestMethod -Method Post `
        -Headers $authentication `
        -ContentType "application/json" `
        -Uri https://kanbanflow.com/api/v1/$UrlCommandPart `
        -Body $asJson
}

<#
.Synopsis
    Get Kanbanflow Board
.DESCRIPTION
    Gets all information for a kanbanflow board which means 
    that you get color and structure information but you do 
    not get the task info. 
.EXAMPLE
    Get-KFBoard
#>
function Get-Board {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    KanbanflowApi-GetCommand -ApiToken $ApiToken -UrlCommandPart "board"
}

<#
.SYNOPSIS
    Get all Tasks from a kanban board
.DESCRIPTION
    Gets all tasks for a kanbanflow board the 
    kanbanflow way. So each column is an object
    which in turn contains an array of tasks.

    If you want the tasks in a flat array without
    column information use "Get-TasksFlat" instead.
.EXAMPLE
    Get-Tasks
#>
function Get-Tasks {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )
    
    KanbanflowApi-GetCommand -ApiToken $ApiToken -UrlCommandPart "tasks"
}

<#
.Synopsis
    Get all Tasks from a kanban board - but not nested within 
    columns
.DESCRIPTION
    Gets all tasks for a kanbanflow board
    
    Requesting the api directly would give you a structure where 
    every column is a seperate nested array. 

    With this function you basically say what columns you want to "select" and all tasks
    that are contained in those are collected and passed to you as an array.
    Which is much better suited for analysis.
.EXAMPLE
    Get-TasksFlat -ApiToken "..." -Columns "To-Do","Doing"
#>
function Get-TasksFlat {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string[]]$Columns
    )

    $result = @()
    $tasks = Get-Tasks $ApiToken
    $tasks | 
        Where-Object columnName -in $Columns | 
        Select-Object tasks | % {
            if ($_.tasks -ne $null) {
                $_.tasks | ForEach-Object {
                    $result += ,$_
                }
            } 
        }
    
    return @( $result )
}

<#
.Synopsis
    Update the name of a task

.DESCRIPTION
    Update a task name on a kanban board by taskId
    
.EXAMPLE
    Update-Task -ApiToken "..." -TaskId "..." -NewTaskName "New task name"
#>
function Update-TaskName {
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

    KanbanflowApi-PostCommand -ApiToken $ApiToken -TaskId $TaskId -data $data
}


<#
.Synopsis
    Get Kanbanflow Board
.DESCRIPTION
    Gets all information for a kanbanflow board which means 
    that you get color and structure information but you do 
    not get the task info. 
.EXAMPLE
    Get-KanbanflowBoard -ApiToken $boardApiToken
#>
function Get-KanbanflowBoard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    $authentication = New-KanbanflowAuthHeader -ApiToken $ApiToken
    Invoke-RestMethod -Method Get -Headers $authentication `
        -Uri https://kanbanflow.com/api/v1/board
}

<#
.SYNOPSIS
    Add a task to a Kanbanflow board
#>
function Add-KanbanflowTask {
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

    Invoke-RestMethod -Method Post `
        -Headers $authentication `
        -ContentType "application/json" `
        -Uri https://kanbanflow.com/api/v1/tasks `
        -Body $asJson

}

<#
.SYNOPSIS
    Grabs information about all columns from a kanban board
.EXAMPLE
    $columns = Get-KanbanflowBoardColumns -ApiToken $testBoardApiToken
#>
function Get-KanbanflowBoardColumns {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )

    $board = Get-KanbanflowBoard -ApiToken $ApiToken

    return $board.columns
}

<#
.SYNOPSIS
    Grabs the unique id from a column label
.EXAMPLE
    $columnTodo = Get-KanbanflowBoardColumnUniqueId -ApiToken $testBoardApiToken -Name "To-Do"
#>
function Get-KanbanflowBoardColumnUniqueId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$Label
    )

    $board = Get-KanbanflowBoard -ApiToken $ApiToken

    $columnUniqueId = ($board.columns | Where-Object { $_.name -eq $Label }).uniqueId 

    return $columnUniqueId
}

<#
.SYNOPSIS

#>
 

# Exports for the module
Export-ModuleMember -Function New-KanbanflowAuthHeader
Export-ModuleMember -Function Get-KanbanflowBoard
Export-ModuleMember -Function Get-KanbanflowBoardColumns
Export-ModuleMember -Function Get-KanbanflowBoardColumnUniqueId

Export-ModuleMember -Function Add-KanbanflowTask

# Old stuff
Export-ModuleMember -Function Get-Board
Export-ModuleMember -Function Get-Tasks
Export-ModuleMember -Function Get-TasksFlat
Export-ModuleMember -Function Update-TaskName
