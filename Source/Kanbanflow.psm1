<#
    KANBANFLOW POWERSHELL MODULE

    This module implements about 95% of the kanbanflow api in an easily 
    consumable way so you can fill your kanbanboards with magic.

    Tested with powershell 5 and powershell core.
#>
$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Web

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
. $PSScriptRoot/Board/Clear-KBFBoard.ps1
. $PSScriptRoot/Board/Get-KBFUser.ps1

Export-ModuleMember -Function Get-Board
Export-ModuleMember -Function Get-BoardColumn
Export-ModuleMember -Function Clear-KBFBoard
Export-ModuleMember -Function Get-KBFUser

<# Getting Tasks  #>
. $PSScriptRoot/Get-Task/Get-Attachments.ps1
. $PSScriptRoot/Get-Task/Get-Collaborators.ps1
. $PSScriptRoot/Get-Task/Get-Comments.ps1
. $PSScriptRoot/Get-Task/Get-Dates.ps1
. $PSScriptRoot/Get-Task/Get-Labels.ps1
. $PSScriptRoot/Get-Task/Get-ManualTimeEntries.ps1
. $PSScriptRoot/Get-Task/Get-SubTasks.ps1
. $PSScriptRoot/Get-Task/Get-Task.ps1
. $PSScriptRoot/Get-Task/Get-TaskByNumber.ps1
. $PSScriptRoot/Get-Task/Get-TimeEntries.ps1

Export-ModuleMember -Function Get-Attachments
Export-ModuleMember -Function Get-Collaborators
Export-ModuleMember -Function Get-Comments
Export-ModuleMember -Function Get-Dates
Export-ModuleMember -Function Get-Labels
Export-ModuleMember -Function Get-ManualTimeEntries
Export-ModuleMember -Function Get-SubTasks
Export-ModuleMember -Function Get-Task
Export-ModuleMember -Function Get-TaskByNumber
Export-ModuleMember -Function Get-TimeEntries

<# Getting time entries #>
. $PSScriptRoot/Get-TimeEntries/Get-TimeEntries.ps1

Export-ModuleMember -Function Get-TimeEntries

<# Adding Tasks #>
. $PSScriptRoot/Create-Task/Add-Collaborator.ps1
. $PSScriptRoot/Create-Task/Add-Comment.ps1
. $PSScriptRoot/Create-Task/Add-Date.ps1
. $PSScriptRoot/Create-Task/Add-Label.ps1
. $PSScriptRoot/Create-Task/Add-SubTask.ps1
. $PSScriptRoot/Create-Task/New-KBFTask.ps1

Export-ModuleMember -Function Add-Collaborator
Export-ModuleMember -Function Add-Comment
Export-ModuleMember -Function Add-Date
Export-ModuleMember -Function Add-Label
Export-ModuleMember -Function Add-SubTask
Export-ModuleMember -Function New-KBFTask
 
<# Updating Tasks #>
. $PSScriptRoot/Update-Task/Update-Task.ps1

Export-ModuleMember -Function Update-TaskName

<# Removing Tasks #>
. $PSScriptRoot/Delete-Task/Remove-KBFTask.ps1

Export-ModuleMember -Function Remove-KBFTask

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
. $PSScriptRoot/Html/Convert-KanbanflowSubtasksToHtml.ps1

Export-ModuleMember -Function Convert-KanbanflowSubtasksToHtml

# Exports for the module
Export-ModuleMember -Function Get-KanbanflowBoard
Export-ModuleMember -Function Get-KanbanflowBoardColumns
Export-ModuleMember -Function Get-KanbanflowBoardColumnUniqueId

Export-ModuleMember -Function Add-KanbanflowTask

