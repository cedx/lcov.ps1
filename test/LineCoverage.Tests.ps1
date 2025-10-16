using module ../src/LineCoverage.psm1

<#
.SYNOPSIS
	Tests the features of the `LineCoverage` class.
#>
Describe "LineCoverage" {
	Describe "ToString" {
		It "should return a format like 'LF:[Found]\nLH:[Hit]'" {
			$data = [LineData]@{ ExecutionCount = 3; LineNumber = 127 }
			[LineCoverage]::new() | Should -BeExactly "LF:0`nLH:0"
			[LineCoverage]@{ Data = @($data); Found = 23; Hit = 11 }| Should -BeExactly "$data`nLF:23`nLH:11"
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `LineData` class.
#>
Describe "LineData" {
	Describe "ToString" {
		It "should return a format like 'DA:[LineNumber],[ExecutionCount],[Checksum]'" {
			[LineData]::new() | Should -BeExactly "DA:0,0"
			[LineData]@{ Checksum = "ed076287532e86365e841e92bfc50d8c"; ExecutionCount = 3; LineNumber = 127 } | Should -BeExactly "DA:127,3,ed076287532e86365e841e92bfc50d8c"
		}
	}
}
