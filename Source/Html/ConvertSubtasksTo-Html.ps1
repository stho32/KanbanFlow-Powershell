<#
.SYNOPSIS
    Converts subtasks given by parameter into a html list.
#>
function ConvertSubTasksTo-Html {
    param (
        [Parameter(Mandatory=$true)]
        [object]$SubTasks
    )

    $result = ""

    $subtasks | ForEach-Object {
        $result += "<li>"
        if ( $_.finished -eq $true ) {
            $result += " [x] "
        } else {
            $result += " [ ] "
        }
        $result = $result + [System.Web.HttpUtility]::HtmlEncode($_.name)
        $result += "</li>"
    }

    if ($result -ne "") {
        $result = "<ul>" + $result + "</ul>"
    }

    return $result
}
