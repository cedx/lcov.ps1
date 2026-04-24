using namespace System.Collections.Generic
using module ./BranchCoverage.psm1
using module ./BranchData.psm1
using module ./FunctionCoverage.psm1
using module ./FunctionData.psm1
using module ./LineCoverage.psm1
using module ./LineData.psm1
using module ./SourceFile.psm1
using module ./Tokens.psm1

<#
.SYNOPSIS
	Represents a trace file, that is a coverage report.
#>
[NoRunspaceAffinity()]
class Report {

	<#
	.SYNOPSIS
		The source file list.
	#>
	[ValidateNotNull()]
	[IList[SourceFile]] $SourceFiles

	<#
	.SYNOPSIS
		The test name.
	#>
	[ValidateNotNull()]
	[string] $TestName

	<#
	.SYNOPSIS
		Creates a new report.
	.PARAMETER TestName
		The test name.
	#>
	Report([string] $TestName) {
		$this.TestName = $TestName
		$this.SourceFiles = @()
	}

	<#
	.SYNOPSIS
		Creates a new report.
	.PARAMETER TestName
		The test name.
	.PARAMETER SourceFiles
		The source file list.
	#>
	Report([string] $TestName, [IEnumerable[SourceFile]] $SourceFiles) {
		$this.TestName = $TestName
		$this.SourceFiles = $SourceFiles
	}

	<#
	.SYNOPSIS
		Parses the specified coverage data in LCOV format.
	.PARAMETER Coverage
		The coverage data.
	.OUTPUTS
		The resulting coverage report.
	#>
	static [Report] Parse([string] $Coverage) {
		$offset = 0
		$report = [Report] ""
		$sourceFile = [SourceFile] ""

		foreach ($line in $Coverage -split "\r?\n") {
			$offset++
			if ([string]::IsNullOrWhiteSpace($line)) { continue }

			$parts = $line.Trim() -split ":"
			if (($parts.Count -lt 2) -and ($parts[0] -ne [Tokens]::EndOfRecord)) { throw [FormatException] "Invalid token format at line #$offset." }

			$data = ($parts[1..$parts.Count] -join ":") -split ","
			$token = $parts[0]

			switch ($token) {
				([Tokens]::TestName) {
					if ([string]::IsNullOrWhiteSpace($report.TestName)) { $report.TestName = $data[0] }
					break
				}
				([Tokens]::BranchData) {
					if ($data.Count -lt 4) { throw [FormatException] "Invalid branch data at line #$offset." }
					$sourceFile.Branches?.Data.Add([BranchData]@{
						BlockNumber = $data[1]
						BranchNumber = $data[2]
						LineNumber = $data[0]
						Taken = $data[3] -eq "-" ? 0 : $data[3]
					})
					break
				}
				([Tokens]::BranchesFound) {
					if ($sourceFile.Branches) { $sourceFile.Branches.Found = $data[0] }
					break
				}
				([Tokens]::BranchesHit) {
					if ($sourceFile.Branches) { $sourceFile.Branches.Hit = $data[0] }
					break
				}
				([Tokens]::FunctionData) {
					if ($data.Count -lt 2) { throw [FormatException] "Invalid function data at line #$offset." }
					if ($sourceFile.Functions) {
						$items = $sourceFile.Functions.Data.Where{ $_.FunctionName -eq $data[1] }
						foreach ($item in $items) { $item.ExecutionCount = $data[0] }
					}
					break
				}
				([Tokens]::FunctionsFound) {
					if ($sourceFile.Functions) { $sourceFile.Functions.Found = $data[0] }
					break
				}
				([Tokens]::FunctionsHit) {
					if ($sourceFile.Functions) { $sourceFile.Functions.Hit = $data[0]}
					break
				}
				([Tokens]::FunctionName) {
					if ($data.Count -lt 2) { throw [FormatException] "Invalid function name at line #$offset." }
					$sourceFile.Functions?.Data.Add([FunctionData]@{ FunctionName = $data[1]; LineNumber = $data[0] })
					break
				}
				([Tokens]::LineData) {
					if ($data.Count -lt 2) { throw [FormatException] "Invalid line data at line #$offset." }
					$sourceFile.Lines?.Data.Add([LineData]@{
						Checksum = $data.Count -ge 3 ? $data[2] : ""
						ExecutionCount = $data[1]
						LineNumber = $data[0]
					})
					break
				}
				([Tokens]::LinesFound) {
					if ($sourceFile.Lines) { $sourceFile.Lines.Found = $data[0] }
					break
				}
				([Tokens]::LinesHit) {
					if ($sourceFile.Lines) { $sourceFile.Lines.Hit = $data[0] }
					break
				}
				([Tokens]::SourceFile) {
					$sourceFile = [SourceFile] $data[0]
					$sourceFile.Branches = [BranchCoverage]::new()
					$sourceFile.Functions = [FunctionCoverage]::new()
					$sourceFile.Lines = [LineCoverage]::new()
					break
				}
				([Tokens]::EndOfRecord) {
					$report.SourceFiles.Add($sourceFile)
					break
				}
				default {
					throw [FormatException] "Unknown token at line #$offset."
				}
			}
		}

		if (-not $report.SourceFiles.Count) { throw [FormatException] "The coverage data is empty or invalid." }
		return $report
	}

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		return @(
			$this.TestName ? @("$([Tokens]::TestName):$($this.TestName)") : @()
			$this.SourceFiles.ForEach{ $_.ToString() }
		) -join "`n"
	}
}
