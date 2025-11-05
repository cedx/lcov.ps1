<#
.SYNOPSIS
	Parses a LCOV report to coverage data.
#>
Import-Module ../Lcov.psd1
# TODO  Import-Module Lcov

try {
	#TODO $coverage = Get-Content "/path/to/lcov.info"
	$coverage = Get-Content "../res/Lcov.info" -Raw
	$report = Get-LcovReport $coverage
	Write-Output "The coverage report contains $($report.SourceFiles.Count) source files:"
	Write-Output (ConvertTo-Json $report)
}
catch [FormatException] {
	Write-Error $_.Exception.Message
}
