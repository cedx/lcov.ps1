using namespace System.Collections.Generic
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
	[SourceFile[]] $SourceFiles

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
	[Report] Parse([string] $coverage) {
		return $null
	}

	<#
	.SYNOPSIS
		Parses the specified coverage data in LCOV format.
	.PARAMETER $coverage
		The coverage data.
	.OUTPUTS
		The resulting coverage report, or `$null` if a parsing error occurred.
	#>
	[Report] TryParse([string] $coverage) {
		try { return $this.Parse($coverage) }
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
		$output.AddRange($this.SourceFiles)
		return $output -join "`n"
	}
}
