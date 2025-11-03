<#
.SYNOPSIS
	Formats coverage data as LCOV report.
#>
Import-Module ../Lcov.psd1

$lineData = @(
	New-LcovLineData -LineNumber 6 -ExecutionCount 2 -Checksum "PF4Rz2r7RTliO9u6bZ7h6g"
	New-LcovLineData -LineNumber 7 -ExecutionCount 2 -Checksum "yGMB6FhEEAd8OyASe3Ni1w"
)

$sourceFile = [SourceFile]::new("/home/cedx/lcov.ps1/fixture.psd1")
$sourceFile.Functions = [FunctionCoverage]@{ Found = 1; Hit = 1 }
$sourceFile.Lines = [LineCoverage]@{ Found = 2; Hit = 2; Data = $lineData }

$report = New-LcovReport -TestName "Example" -SourceFiles @($sourceFile)
ConvertTo-Json $report
