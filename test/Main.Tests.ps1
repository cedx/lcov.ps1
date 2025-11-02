<#
.SYNOPSIS
	Tests the features of the `Main` module.
#>
Describe "Main" {
	BeforeAll {
		Import-Module ./Lcov.psd1
	}

	Context "New-BranchCoverage" {
		It "should return a format like 'BRF:[Found]\nBRH:[Hit]'" {
			$data = New-LcovBranchData -BlockNumber 3 -BranchNumber 2 -LineNumber 127 -Taken 1
			New-LcovBranchCoverage | Should -BeExactly "BRF:0`nBRH:0"
			New-LcovBranchCoverage -Data @($data) -Found 23 -Hit 11 | Should -BeExactly "$data`nBRF:23`nBRH:11"
		}
	}

	Context "New-BranchData" {
		It "should return a format like 'BRDA:[LineNumber],[BlockNumber],[BranchNumber],[Taken]'" {
			New-LcovBranchData | Should -BeExactly "BRDA:0,0,0,-"
			New-LcovBranchData -BlockNumber 3 -BranchNumber 2 -LineNumber 127 -Taken 1 | Should -BeExactly "BRDA:127,3,2,1"
		}
	}

	Context "New-FunctionCoverage" {
		It "should return a format like 'FNF:[Found]\nFNH:[Hit]'" {
			$data = New-LcovFunctionData -ExecutionCount 3 -FunctionName "main" -LineNumber 127
			New-LcovFunctionCoverage | Should -BeExactly "FNF:0`nFNH:0"
			New-LcovFunctionCoverage -Data @($data) -Found 23 -Hit 11 | Should -BeExactly "FN:127,main`nFNDA:3,main`nFNF:23`nFNH:11"
		}
	}

	Context "New-FunctionData" {
		It "should return a format like 'FN:[LineNumber],[FunctionName]' when used as definition" {
			(New-LcovFunctionData).ToString($true) | Should -BeExactly "FN:0,"
			$data = New-LcovFunctionData -ExecutionCount 3 -FunctionName "main" -LineNumber 127
			$data.ToString($true) | Should -BeExactly "FN:127,main"
		}

		It "should return a format like 'FNDA:[ExecutionCount],[FunctionName]' when used as data" {
			(New-LcovFunctionData).ToString($false) | Should -BeExactly "FNDA:0,"
			$data = New-LcovFunctionData -ExecutionCount 3 -FunctionName "main" -LineNumber 127
			$data.ToString($false) | Should -BeExactly "FNDA:3,main"
		}
	}

	Context "New-LineCoverage" {
		It "should return a format like 'LF:[Found]\nLH:[Hit]'" {
			$data = New-LcovLineData -ExecutionCount 3 -LineNumber 127
			New-LcovLineCoverage | Should -BeExactly "LF:0`nLH:0"
			New-LcovLineCoverage -Data @($data) -Found 23 -Hit 11 | Should -BeExactly "$data`nLF:23`nLH:11"
		}
	}

	Context "New-LineData" {
		It "should return a format like 'DA:[LineNumber],[ExecutionCount],[Checksum]'" {
			New-LcovLineData | Should -BeExactly "DA:0,0"
			New-LcovLineData -Checksum "ed076287532e86365e841e92bfc50d8c" -ExecutionCount 3 -LineNumber 127 | Should -BeExactly "DA:127,3,ed076287532e86365e841e92bfc50d8c"
		}
	}
}
