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
	[BranchData[]] $Data = @()

	<#
	.SYNOPSIS
		The number of branches found.
	#>
	[int] $Found = 0

	<#
	.SYNOPSIS
		The number of branches hit.
	#>
	[int] $Hit = 0

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		# $lines = [List[string]]::new($this.Data.Length + 2) # TODO ???? [List[string]] $this.Data.Length + 2
		# TODO ??? [List[string]]::new($this.Data)

		$lines = $this.Data.ForEach("ToString")
		$lines += "$([Tokens]::BranchesFound):$($this.Found)"
		$lines += "$([Tokens]::BranchesHit):$($this.Hit)"
		return $lines -join "`n"
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
	[int] $BlockNumber = 0

	<#
	.SYNOPSIS
		The branch number.
	#>
	[int] $BranchNumber = 0

	<#
	.SYNOPSIS
		The line number.
	#>
	[int] $LineNumber = 0

	<#
	.SYNOPSIS
		A number indicating how often this branch was taken.
	#>
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
