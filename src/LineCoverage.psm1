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
	[LineData[]] $Data = @()

	<#
	.SYNOPSIS
		The number of lines found.
	#>
	[int] $Found = 0

	<#
	.SYNOPSIS
		The number of lines hit.
	#>
	[int] $Hit = 0

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$lines = $this.Data.ForEach("ToString")
		$lines += "$([Tokens]::LinesFound):$($this.Found)"
		$lines += "$([Tokens]::LinesHit):$($this.Hit)"
		return $lines -join "`n"
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
	[string] $Checksum = [string]::Empty

	<#
	.SYNOPSIS
		The execution count.
	#>
	[int] $ExecutionCount = 0

	<#
	.SYNOPSIS
		The line number.
	#>
	[int] $LineNumber = 0

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
