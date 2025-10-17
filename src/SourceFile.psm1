using namespace System.Collections.Generic
using module ./BranchCoverage.psm1
using module ./FunctionCoverage.psm1
using module ./LineCoverage.psm1
using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides the coverage data of a source file.
#>
class SourceFile {

	<#
	.SYNOPSIS
		The branch coverage.
	#>
	[BranchCoverage] $Branches

	<#
	.SYNOPSIS
		The function coverage.
	#>
	[FunctionCoverage] $Functions

	<#
	.SYNOPSIS
		The line coverage.
	#>
	[LineCoverage] $Lines

	<#
	.SYNOPSIS
		The path to the source file.
	#>
	[string] $Path

	<#
	.SYNOPSIS
		Creates a new source file.
	.PARAMETER $path
		The path to the source file.
	#>
	SourceFile([string] $path) {
		$this.Path = $path
	}

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$output = [List[string]] @("$([Tokens]::SourceFile):$($this.Path)")
		if ($this.Functions) { $output.Add($this.Functions) }
		if ($this.Branches) { $output.Add($this.Branches) }
		if ($this.Lines) { $output.Add($this.Lines) }
		$output.Add([Tokens]::EndOfRecord)
		return $output -join "`n"
	}
}
