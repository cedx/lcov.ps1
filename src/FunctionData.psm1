using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides details for function coverage.
#>
[NoRunspaceAffinity()]
class FunctionData {

	<#
	.SYNOPSIS
		The execution count.
	#>
	[ValidateRange("NonNegative")]
	[int] $ExecutionCount

	<#
	.SYNOPSIS
		The function name.
	#>
	[ValidateNotNull()]
	[string] $FunctionName = ""

	<#
	.SYNOPSIS
		The line number of the function start.
	#>
	[ValidateRange("NonNegative")]
	[int] $LineNumber

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
	.PARAMETER AsDefinition
		Whether to return the function definition instead of its data.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString([bool] $AsDefinition) {
		$token = $AsDefinition ? [Tokens]::FunctionName : [Tokens]::FunctionData
		$count = $AsDefinition ? $this.LineNumber : $this.ExecutionCount
		return "${token}:$count,$($this.FunctionName)"
	}
}
