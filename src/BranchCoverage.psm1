using namespace System.Collections.Generic
using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides the coverage data of branches.
#>
class BranchCoverage {

	<#
	.SYNOPSIS
		The coverage data.
	#>
	[ValidateNotNull()]
	[BranchData[]] $Data = @()

	<#
	.SYNOPSIS
		The number of branches found.
	#>
	[ValidateRange("NonNegative")]
	[int] $Found = 0

	<#
	.SYNOPSIS
		The number of branches hit.
	#>
	[ValidateRange("NonNegative")]
	[int] $Hit = 0

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$output = [List[string]] [string[]] $this.Data.ForEach("ToString")
		$output.Add("$([Tokens]::BranchesFound):$($this.Found)")
		$output.Add("$([Tokens]::BranchesHit):$($this.Hit)")
		return $output -join "`n"
	}
}

<#
.SYNOPSIS
	Provides details for branch coverage.
#>
class BranchData {

	<#
	.SYNOPSIS
		The block number.
	#>
	[ValidateRange("NonNegative")]
	[int] $BlockNumber = 0

	<#
	.SYNOPSIS
		The branch number.
	#>
	[ValidateRange("NonNegative")]
	[int] $BranchNumber = 0

	<#
	.SYNOPSIS
		The line number.
	#>
	[ValidateRange("NonNegative")]
	[int] $LineNumber = 0

	<#
	.SYNOPSIS
		A number indicating how often this branch was taken.
	#>
	[ValidateRange("NonNegative")]
	[int] $Taken = 0

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$value = "$([Tokens]::BranchData):$($this.LineNumber),$($this.BlockNumber),$($this.BranchNumber)"
		return $this.Taken -gt 0 ? "$value,$($this.Taken)" : "$value,-"
	}
}
