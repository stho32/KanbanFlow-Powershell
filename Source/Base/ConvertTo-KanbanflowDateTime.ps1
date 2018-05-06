<#
.SYNOPSIS
    Converts a datetime to the date format of the Kanbanflow API
.DESCRIPTION
    Konvertiert ein Datetime z.B. in:
    2013-12-31T09:00:00Z
#>

function ConvertTo-KanbanflowDateTime {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [DateTime]$DateTime
    )

    $result = $DateTime.ToString("yyyy-MM-ddTHH:mm:ssZ")
    return $result;
}