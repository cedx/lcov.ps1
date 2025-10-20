using namespace System.Collections.Generic
using module ./BranchCoverage.psm1
using module ./FunctionCoverage.psm1
using module ./LineCoverage.psm1
using module ./SourceFile.psm1
using module ./Tokens.psm1

<#
.SYNOPSIS
	Represents a trace file, that is a coverage report.
#>
class Report {

	<#
	.SYNOPSIS
		The source file list.
	#>
	[ValidateNotNull()] [SourceFile[]] $SourceFiles

	<#
	.SYNOPSIS
		The test name.
	#>
	[string] $TestName

	<#
	.SYNOPSIS
		Creates a new report.
	.PARAMETER $testName
		The test name.
	#>
	Report([string] $testName) {
		$this.TestName = $testName
		$this.SourceFiles = @()
	}

	<#
	.SYNOPSIS
		Creates a new report.
	.PARAMETER $testName
		The test name.
	.PARAMETER $sourceFiles
		The source file list.
	#>
	Report([string] $testName, [SourceFile[]] $sourceFiles) {
		$this.TestName = $testName
		$this.SourceFiles = $sourceFiles
	}

	<#
	.SYNOPSIS
		Parses the specified coverage data in LCOV format.
	.PARAMETER $coverage
		The coverage data.
	.OUTPUTS
		The resulting coverage report.
	#>
	static [Report] Parse([string] $coverage) {
		$offset = 0
		$report = [Report]::new("")
		$sourceFile = [SourceFile]::new("")

		foreach ($line in $coverage -split "\r?\n") {
			$offset++
			if ([string]::IsNullOrWhiteSpace($line)) { continue }

			$parts = $line.Trim() -split ":"
			if (($parts.Count -lt 2) -and ($parts[0] -ne [Tokens]::EndOfRecord)) { throw [FormatException] "Invalid token format at line $offset." }

			$data = ($parts[1..($parts.Count - 1)] -join ":") -split ","
			$token = $parts[0]

			switch ($token) {
				([Tokens]::TestName) {
					if (-not $report.TestName) { $report.TestName = $data[0] }
					break
				}
				([Tokens]::BranchData) {
					if ($data.Count -lt 4) { throw [FormatException] "Invalid branch data at line #{offset}." }
					if ($sourceFile.Branches) {
						$sourceFile.Branches.Data += [BranchData]@{
							BlockNumber = $data[1]
							BranchNumber = $data[2]
							LineNumber = $data[0]
							Taken = $data[3] -eq "-" ? 0 : $data[3]
						}
					}
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
					if ($data.Count -lt 2) { throw [FormatException] "Invalid function data at line $offset." }
					if ($sourceFile.Functions) {
						$items = $sourceFile.Functions.Data.Where{ $_.FunctionName -eq $data[1] }
						$items.ForEach{ $_.ExecutionCount = $data[0] }
					}
					break
				}
				([Tokens]::FunctionName) {
					if ($data.Count -lt 2) { throw [FormatException] "Invalid function name at line $offset." }
					if ($sourceFile.Functions) {
						$sourceFile.Functions.Data += [FunctionData]@{
							FunctionName = $data[1]
							LineNumber = $data[0]
						}
					}
					break
				}
				([Tokens]::FunctionsFound) {
					if ($sourceFile.Functions) { $sourceFile.Functions.Found = $data[0] }
					break
				}
				([Tokens]::FunctionsHit) {
					if ($sourceFile.Functions) { $sourceFile.Functions.Hit = $data[0] }
					break
				}
				([Tokens]::LineData) {
					if ($data.Count -lt 2) { throw [FormatException] "Invalid line data at line $offset." }
					if ($sourceFile.Lines) {
						$sourceFile.Lines.Data += [LineData]@{
							Checksum = $data.Count -ge 3 ? $data[2] : ""
							ExecutionCount = $data[1]
							LineNumber = $data[0]
						}
					}
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
					$report.SourceFiles += $sourceFile
					break
				}
				default {
					throw [FormatException] "Unknown token ""$token"" at line $offset."
				}
			}
		}

		if (-not $report.SourceFiles) { throw [FormatException] "The coverage data is empty or invalid." }
		return $report
	}

	<#
	.SYNOPSIS
		Parses the specified coverage data in LCOV format.
	.PARAMETER $coverage
		The coverage data.
	.OUTPUTS
		The resulting coverage report, or `$null` if a parsing error occurred.
	#>
	static [Report] TryParse([string] $coverage) {
		try { return [Report]::Parse($coverage) }
		catch { return $null }
	}

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$output = [List[string]]::new()
		if ($this.TestName) { $output.Add("$([Tokens]::TestName):$($this.TestName)") }
		$output.AddRange([string[]] $this.SourceFiles.ForEach("ToString"))
		return $output -join "`n"
	}
}
