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
	[ValidateNotNull()] [FunctionData[]] $Data = @()

	<#
	.SYNOPSIS
		The number of functions found.
	#>
	[ValidateRange("NonNegative")] [int] $Found = 0

	<#
	.SYNOPSIS
		The number of functions hit.
	#>
	[ValidateRange("NonNegative")] [int] $Hit = 0

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$output = [List[string]] [string[]] $this.Data.ForEach("ToString", $true)
		$output.AddRange([string[]] $this.Data.ForEach("ToString", $false))
		$output.Add("$([Tokens]::FunctionsFound):$($this.Found)")
		$output.Add("$([Tokens]::FunctionsHit):$($this.Hit)")
		return $output -join "`n"
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
	[ValidateRange("NonNegative")] [int] $ExecutionCount = 0

	<#
	.SYNOPSIS
		The function name.
	#>
	[string] $FunctionName = ""

	<#
	.SYNOPSIS
		The line number of the function start.
	#>
	[ValidateRange("NonNegative")] [int] $LineNumber = 0

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
