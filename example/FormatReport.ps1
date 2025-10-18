<#
.SYNOPSIS
	Formats coverage data as LCOV report.
#>
using module Lcov

$lineData = @(
	[LineData]@{ LineNumber = 6; ExecutionCount = 2; Checksum = "PF4Rz2r7RTliO9u6bZ7h6g" }
	[LineData]@{ LineNumber = 7; ExecutionCount = 2; Checksum = "yGMB6FhEEAd8OyASe3Ni1w" }
)

$sourceFile = [SourceFile]::new("/home/cedx/lcov.net/fixture.cs")
$sourceFile.Functions = [FunctionCoverage]@{ Found = 1; Hit = 1 }
$sourceFile.Lines = [LineCoverage]@{ Found = 2; Hit = 2; Data = $lineData }

$report = [Report]::new("Example", @($sourceFile))
Write-Information $report
