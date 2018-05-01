<#
    KANBANFLOW POWERSHELL MODULE

    This module implements about 95% of the kanbanflow api in an easily 
    consumable way so you can fill your kanbanboards with magic.

    Tested with powershell 5 and powershell core.
#>

<# Basement for all commands #>
. $PSScriptRoot/Base/New-KanbanflowAuthHeader.ps1
. $PSScriptRoot/Base/Invoke-GetKanbanflowApi.ps1
. $PSScriptRoot/Base/Invoke-PostKanbanflowApi.ps1

<# Board related commands #>
. $PSScriptRoot/Board/Get-Board.ps1

<# Task related commands #>
. $PSScriptRoot/Get-Task/Get-Task.ps1
. $PSScriptRoot/Get-Task/Get-Tasks.ps1
. $PSScriptRoot/Get-Task/Get-TasksFlat.ps1
 

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
