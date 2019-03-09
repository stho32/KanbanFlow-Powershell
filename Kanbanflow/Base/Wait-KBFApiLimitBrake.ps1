function Wait-KBFApiLimitBrake {
	<#
		.SYNOPSIS
		Waits for a small amount of time to that 
		we do not reach the api limit of the board as fast
		
		.EXAMPLE
		Wait-KBFApiLimitBrake
	#>
	[CmdletBinding()]
	Param(
	)
	
	Process {
		<#
			You can only do 1000 requests per board and hour.
			To not exceed that limit I throttle the requests. 
			If I have 1000 requests and 60 minutes i can do :
			16,67 requests per minute and 0,27 requests per second.
			
			So 4 Seconds sleep per request would never let me go pass that limit.
			Even if I would constantly throw one call after another.
			I am doing half that wait here, because I wont hammer all the time on 
			that api.
		#>
		Start-Sleep -Milliseconds 2000
	}
}