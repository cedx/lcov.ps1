using module ../src/BranchCoverage.psm1
using module ../src/FunctionCoverage.psm1
using module ../src/LineCoverage.psm1
using module ../src/SourceFile.psm1

<#
.SYNOPSIS
	Tests the features of the `SourceFile` class.
#>
Describe "SourceFile" {
	Context "ToString" {
		It "should return a format like 'SF:<Path>\nend_of_record'" {
			[SourceFile]::new("").ToString() | Should -BeExactly "SF:`nend_of_record"

			$sourceFile = [SourceFile] "/home/cedx/lcov.ps1/program.psm1"
			$sourceFile.Branches = [BranchCoverage]::new()
			$sourceFile.Functions = [FunctionCoverage]::new()
			$sourceFile.Lines = [LineCoverage]::new()
			$sourceFile.ToString() | Should -BeExactly "SF:/home/cedx/lcov.ps1/program.psm1`n$($sourceFile.Functions)`n$($sourceFile.Branches)`n$($sourceFile.Lines)`nend_of_record"
		}
	}
}
