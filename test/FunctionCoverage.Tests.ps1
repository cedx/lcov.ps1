using module ../src/FunctionCoverage.psm1
using module ../src/FunctionData.psm1

<#
.SYNOPSIS
	Tests the features of the `FunctionCoverage` class.
#>
Describe "FunctionCoverage" {
	Context "ToString" {
		It "should return a format like 'FNF:<found>\nFNH:<hit>'" {
			[FunctionCoverage]::new().ToString() | Should -BeExactly "FNF:0`nFNH:0"

			$data = [FunctionData]@{ ExecutionCount = 3; FunctionName = "main"; LineNumber = 127 }
			([FunctionCoverage]@{ Data = @($data); Found = 23; Hit = 11 }).ToString() | Should -BeExactly "$data`nFNF:23`nFNH:11"
		}
	}
}
