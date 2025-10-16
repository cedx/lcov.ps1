using module ../src/LineCoverage.psm1

<#
.SYNOPSIS
	Tests the features of the `LineCoverage` class.
#>
Describe "LineCoverage" {
	Describe "ToString" {
		It "should return a format like 'LF:<found>\nLH:<hit>'" {
			$data = [LineData]@{ ExecutionCount = 3; LineNumber = 127 }
			[LineCoverage]::new().ToString() | Should -BeExactly "LF:0`nLH:0"
			[LineCoverage]@{ Data = @($data); Found = 23; Hit = 11 }.ToString() | Should -BeExactly "$data`nLF:23`nLH:11"
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `LineData` class.
#>
Describe "LineData" {
	Describe "ToString" {
		It "should return a format like 'DA:<lineNumber>,<executionCount>[,<checksum>]'" {
			[LineData]::new().ToString() | Should -BeExactly "DA:0,0"
			$data = [LineData]@{ Checksum = "ed076287532e86365e841e92bfc50d8c"; ExecutionCount = 3; LineNumber = 127 }
			$data.ToString() | Should -BeExactly "DA:127,3,ed076287532e86365e841e92bfc50d8c"
		}
	}
}
