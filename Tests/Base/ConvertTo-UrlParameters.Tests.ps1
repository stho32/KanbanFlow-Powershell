Describe 'ConvertTo-UrlParameters' {
	Remove-Module Kanbanflow*; Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
	. $PSScriptRoot/../../credentials-for-testing.ps1

    it 'encodes parameter values' {
		$data = New-Object -TypeName PSObject -Property @{
			name = "Some important name"
			valueWithAmpersand = "You&better encode me"
		}
		
		$url = $data | ConvertTo-UrlParameters
 		$url | Should -Be "&valueWithAmpersand=You%26better+encode+me&name=Some+important+name"
    }   

    it 'concatenates parameters with &' {
		$data = New-Object -TypeName PSObject -Property @{
			name = "Some important name"
			valueWithAmpersand = "You&better encode me"
		}
		
		$url = $data | ConvertTo-UrlParameters
 		($url.Split("&").Count-1) | Should -Be 2
    }  
	
	it 'can optionally use ? as first character instead of &' {
		$data = New-Object -TypeName PSObject -Property @{
			name = "Some important name"
			valueWithAmpersand = "You&better encode me"
		}
		
		$url = $data | ConvertTo-UrlParameters -StartWithQuestionMark
 		($url.Split("&").Count-1) | Should -Be 1
		$url.StartsWith("?") | Should -Be $true
    } 
}

