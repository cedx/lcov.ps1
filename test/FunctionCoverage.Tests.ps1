using module ../src/FunctionCoverage.psm1

<#
.SYNOPSIS
	Tests the features of the `FunctionCoverage` class.
#>
Describe "FunctionCoverage" {
	Describe "ToString" {
		It "should return a format like 'FNF:<found>\nFNH:<hit>'" {
			$data = [FunctionData]@{ ExecutionCount = 3; FunctionName = "main"; LineNumber = 127 }
			[FunctionCoverage]::new().ToString() | Should -BeExactly "FNF:0`nFNH:0"
			[FunctionCoverage]@{ Data = @($data); Found = 23; Hit = 11 }.ToString() | Should -BeExactly "FN:127,main`nFNDA:3,main`nFNF:23`nFNH:11"
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `FunctionData` class.
#>
Describe "FunctionData" {
	Describe "ToString" {
		It "should return a format like 'FN:<lineNumber>,<functionName>' when used as definition" {
			[FunctionData]::new().ToString($true) | Should -BeExactly "FN:0,"
			$data = [FunctionData]@{ ExecutionCount = 3; FunctionName = "main"; LineNumber = 127 }
			$data.ToString($true) | Should -BeExactly "FN:127,main"
		}

		It "should return a format like 'FNDA:<executionCount>,<functionName>' when used as data" {
			[FunctionData]::new().ToString($false) | Should -BeExactly "FNDA:0,"
			$data = [FunctionData]@{ ExecutionCount = 3; FunctionName = "main"; LineNumber = 127 }
			$data.ToString($false) | Should -BeExactly "FNDA:3,main"
		}
	}
}
