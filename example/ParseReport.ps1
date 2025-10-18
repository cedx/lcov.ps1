<#
.SYNOPSIS
	Parses a LCOV report to coverage data.
#>
using module Lcov

try {
	$coverage = Get-Content "/path/to/lcov.info" -Raw
	$report = [Report]::Parse($coverage)
	Write-Output "The coverage report contains $($report.SourceFiles.Count) source files:"
	Write-Output (ConvertTo-Json $report)
}
catch [FormatException] {
	Write-Error $_.Exception.Message
}
