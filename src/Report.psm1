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
	.PARAMETER $path
		The path to the source file.
	#>
	SourceFile([string] $testName) {
		$this.TestName = $testName
	}
}
