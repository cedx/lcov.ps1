using module ../src/BranchCoverage.psm1

<#
.SYNOPSIS
	Tests the features of the `BranchCoverage` class.
#>
Describe "BranchCoverage" {
	Describe "ToString" {
		It "should return a format like 'BRF:<found>\nBRH:<hit>'" {
			$data = [BranchData]@{ BlockNumber = 3; BranchNumber = 2; LineNumber = 127; Taken = 1 }
			[BranchCoverage]::new().ToString() | Should -BeExactly "BRF:0`nBRH:0"
			[BranchCoverage]@{ Data = @($data); Found = 23; Hit = 11 }.ToString() | Should -BeExactly "$data`nBRF:23`nBRH:11"
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `BranchData` class.
#>
Describe "BranchData" {
	Describe "ToString" {
		It "should return a format like 'BRDA:<lineNumber>,<blockNumber>,<branchNumber>,<taken>'" {
			[BranchData]::new().ToString() | Should -BeExactly "BRDA:0,0,0,-"
			[BranchData]@{ BlockNumber = 3; BranchNumber = 2; LineNumber = 127; Taken = 1 }.ToString() | Should -BeExactly "BRDA:127,3,2,1"
		}
	}
}
