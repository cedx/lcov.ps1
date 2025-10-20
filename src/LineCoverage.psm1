using namespace System.Collections.Generic
using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides the coverage data of lines.
#>
class LineCoverage {

	<#
	.SYNOPSIS
		The coverage data.
	#>
	[ValidateNotNull()] [LineData[]] $Data = @()

	<#
	.SYNOPSIS
		The number of lines found.
	#>
	[ValidateRange("NonNegative")] [int] $Found = 0

	<#
	.SYNOPSIS
		The number of lines hit.
	#>
	[ValidateRange("NonNegative")] [int] $Hit = 0

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$output = [List[string]] [string[]] $this.Data.ForEach("ToString")
		$output.Add("$([Tokens]::LinesFound):$($this.Found)")
		$output.Add("$([Tokens]::LinesHit):$($this.Hit)")
		return $output -join "`n"
	}
}

<#
.SYNOPSIS
	Provides details for line coverage.
#>
class LineData {

	<#
	.SYNOPSIS
		The data checksum.
	#>
	[string] $Checksum = ""

	<#
	.SYNOPSIS
		The execution count.
	#>
	[ValidateRange("NonNegative")] [int] $ExecutionCount = 0

	<#
	.SYNOPSIS
		The line number.
	#>
	[ValidateRange("NonNegative")] [int] $LineNumber = 0

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$value = "$([Tokens]::LineData):$($this.LineNumber),$($this.ExecutionCount)"
		return $this.Checksum ? "$value,$($this.Checksum)" : $value
	}
}
