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
        [Parameter(ParameterSetName="MultiTask")]
        [string]$columnName = "",
        [Parameter(ParameterSetName="MultiTask")]
        [string]$columnIndex = "",
        [Parameter(ParameterSetName="MultiTask")]
        [string]$startTaskId = "",
        [Parameter(ParameterSetName="MultiTask")]
        [string]$startGroupingDate = "",
        [Parameter(ParameterSetName="MultiTask")]
        [string]$limit = "",
        [Parameter(ParameterSetName="MultiTask")]
        [string]$order = "",
        [Parameter(ParameterSetName="MultiTask")]
        [switch]$Flat = $false
    )

	Process {
		# The command is used to request only one task
		if ( $PSCmdlet.ParameterSetName -eq "SingleTask" ) {
			Invoke-KBFApi -ApiToken $ApiToken -Method "Get" -Command "tasks/$TaskId"
			return
		}

		if ( $PSCmdlet.ParameterSetName -eq "MultiTask" ) {
			$urlParameters = New-Object -TypeName PSObject -Property @{
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