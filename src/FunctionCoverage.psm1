using namespace System.Collections.Generic
using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides the coverage data of functions.
#>
class FunctionCoverage {

	<#
	.SYNOPSIS
		The coverage data.
	#>
	[FunctionData[]] $Data = @()

	<#
	.SYNOPSIS
		The number of functions found.
	#>
	[int] $Found = 0

	<#
	.SYNOPSIS
		The number of functions hit.
	#>
	[int] $Hit = 0

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$lines = [List[string]] [string[]] $this.Data.ForEach("ToString", $true)
		$lines.AddRange([string[]] $this.Data.ForEach("ToString", $false))
		$lines.Add("$([Tokens]::FunctionsFound):$($this.Found)")
		$lines.Add("$([Tokens]::FunctionsHit):$($this.Hit)")
		return $lines -join "`n"
	}
}

<#
.SYNOPSIS
	Provides details for function coverage.
#>
class FunctionData {

	<#
	.SYNOPSIS
		The execution count.
	#>
	[int] $ExecutionCount = 0

	<#
	.SYNOPSIS
		The function name.
	#>
	[string] $FunctionName = [string]::Empty

	<#
	.SYNOPSIS
		The line number of the function start.
	#>
	[int] $LineNumber = 0

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		return $this.ToString($false)
	}

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.PARAMETER $asDefinition
		Whether to return the function definition instead of its data.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString([bool] $asDefinition) {
		$token = $asDefinition ? [Tokens]::FunctionName : [Tokens]::FunctionData
		$count = $asDefinition ? $this.LineNumber : $this.ExecutionCount
		return "${token}:$count,$($this.FunctionName)"
	}
}
