using namespace System.Collections.Generic
using module ./LineData.psm1
using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides the coverage data of lines.
#>
[NoRunspaceAffinity()]
class LineCoverage {

	<#
	.SYNOPSIS
		The coverage data.
	#>
	[ValidateNotNull()]
	[IList[LineData]] $Data = @()

	<#
	.SYNOPSIS
		The number of lines found.
	#>
	[ValidateRange("NonNegative")]
	[int] $Found

	<#
	.SYNOPSIS
		The number of lines hit.
	#>
	[ValidateRange("NonNegative")]
	[int] $Hit

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		return @(
			$this.Data.ForEach{ $_.ToString() }
			"$([Tokens]::LinesFound):$($this.Found)"
			"$([Tokens]::LinesHit):$($this.Hit)"
		) -join "\n"
	}
}
