using module ../src/BranchCoverage.psm1

<#
.SYNOPSIS
	Tests the features of the `BranchCoverage` module.
#>
Describe "BranchCoverage" {
	Context "ToString" {
		It "should return a format like 'BRF:[Found]\nBRH:[Hit]'" {
			$data = [BranchData]@{ BlockNumber = 3; BranchNumber = 2; LineNumber = 127; Taken = 1 }
			[BranchCoverage]::new() | Should -BeExactly "BRF:0`nBRH:0"
			[BranchCoverage]@{ Data = @($data); Found = 23; Hit = 11 } | Should -BeExactly "$data`nBRF:23`nBRH:11"
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `BranchData` module.
#>
Describe "BranchData" {
	Context "ToString" {
		It "should return a format like 'BRDA:[LineNumber],[BlockNumber],[BranchNumber],[Taken]'" {
			[BranchData]::new() | Should -BeExactly "BRDA:0,0,0,-"
			[BranchData]@{ BlockNumber = 3; BranchNumber = 2; LineNumber = 127; Taken = 1 } | Should -BeExactly "BRDA:127,3,2,1"
		}
	}
}
