<#
    KANBANFLOW POWERSHELL MODULE

    This module implements about 95% of the kanbanflow api in an easily 
    consumable way so you can fill your kanbanboards with magic.

    Tested with powershell 5 and powershell core.
#>

<# Basement for all commands #>
. $PSScriptRoot/Base/New-KanbanflowAuthHeader.ps1
. $PSScriptRoot/Base/ConvertTo-UrlParameters.ps1
. $PSScriptRoot/Base/Add-MemberIfNotEmpty.ps1
. $PSScriptRoot/Base/Invoke-KanbanflowApi.ps1
. $PSScriptRoot/Base/ConvertTo-KanbanflowDateTime.ps1

Export-ModuleMember -Function New-KanbanflowAuthHeader
Export-ModuleMember -Function Invoke-KanbanflowApi
Export-ModuleMember -Function ConvertTo-KanbanflowDateTime

<# Board related commands #>
. $PSScriptRoot/Board/Get-Board.ps1
. $PSScriptRoot/Board/Get-BoardColumn.ps1

Export-ModuleMember -Function Get-Board
Export-ModuleMember -Function Get-BoardColumn

<# Getting Tasks  #>
. $PSScriptRoot/Get-Task/Get-Task.ps1
. $PSScriptRoot/Get-Task/Get-TaskByNumber.ps1
. $PSScriptRoot/Get-Task/Get-Comments.ps1
. $PSScriptRoot/Get-Task/Get-SubTasks.ps1

Export-ModuleMember -Function Get-Task
Export-ModuleMember -Function Get-TaskByNumber
Export-ModuleMember -Function Get-Comments
Export-ModuleMember -Function Get-SubTasks

<# Getting time entries #>
. $PSScriptRoot/Get-TimeEntries/Get-TimeEntries.ps1

Export-ModuleMember -Function Get-TimeEntries

<# Adding Tasks #>
. $PSScriptRoot/Create-Task/Add-Task.ps1

Export-ModuleMember -Function Add-Task
 
<# Updating Tasks #>
. $PSScriptRoot/Update-Task/Update-Task.ps1

Export-ModuleMember -Function Update-TaskName

<# Events #>
. $PSScriptRoot/Events/Get-Events.ps1
. $PSScriptRoot/Events/Get-NewTasks.ps1

Export-ModuleMember -Function Get-Events
Export-ModuleMember -Function Get-NewTasks

<# Analysis #>
. $PSScriptRoot/Analysis/Get-DayOverview.ps1
. $PSScriptRoot/Analysis/Get-TimeUsageOverview.ps1
. $PSScriptRoot/Analysis/Get-TimeUsageTable.ps1

Export-ModuleMember -Function Get-DayOverview
Export-ModuleMember -Function Get-TimeUsageOverview
Export-ModuleMember -Function Get-TimeUsageTable

<# Conversion (to HTML) #>
. $PSScriptRoot/Html/ConvertSubtasksTo-Html.ps1

Export-ModuleMember -Function ConvertSubTasksTo-Html

# Exports for the module
Export-ModuleMember -Function Get-KanbanflowBoard
Export-ModuleMember -Function Get-KanbanflowBoardColumns
Export-ModuleMember -Function Get-KanbanflowBoardColumnUniqueId

Export-ModuleMember -Function Add-KanbanflowTask

