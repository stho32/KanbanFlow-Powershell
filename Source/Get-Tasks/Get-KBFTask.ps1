function Get-KBFTask {
    <#
        .SYNOPSIS
        Get a task by its ID
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true, ParameterSetName="SingleTask")]
        [string]$TaskId,
        [Parameter(ParameterSetName="MultiTask")]
        [string]$columnId = "",
        [string]$columnName = "",
        [string]$columnIndex = "",
        [string]$startTaskId = "",
        [string]$startGroupingDate = "",
        [string]$limit = "",
        [string]$order = "",
        [switch]$Flat = $false
    )

	Process {
		# The command is used to request only one task
		if ( $PSCmdlet.ParameterSetName -eq "SingleTask" ) {
			Invoke-KBFApi -ApiToken $ApiToken -Method "Get" -Command "tasks/$TaskId"
			return
		}

		if ( $PSCmdlet.ParameterSetName -eq "MultiTask" ) {
			$urlParameters = @{
				columnId = $columnId
				columnName = $columnName
				columnIndex = $columnIndex
				startTaskId = $startTaskId
				startGroupingDate = $startGroupingDate
				limit = $limit
				order = $order
			}

			$tasksInColumns = Invoke-KBFApi -ApiToken $ApiToken -Method "Get" -Command "tasks" -Parameters $urlParameters

			<#
				This will change the structure from column.tasks to
				tasks that contain the column name & id.
				This flat structure is better suited for analysis and filtering.
			#>
			if ($Flat -eq $true) {

				$result = @()

				For ($i = 0; $i -lt $tasksInColumns.Count; $i++)
				{
					$columnName  = $tasksInColumns[$i].columnName

					For ($j = 0; $j -lt $tasksInColumns[$i].tasks.Count; $j++) {
						$temp = $tasksInColumns[$i].tasks[$j]
						$temp | Add-Member NoteProperty -Name "columnName" -Value $columnName -Force
						$result +=,$temp
					}
				}
			  
				return @( $result )
			}

			return $tasksInColumns
		}
	}
}