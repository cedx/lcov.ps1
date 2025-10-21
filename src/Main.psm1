import module ../BranchCoverage.psm1
import module ../FunctionCoverage.psm1
import module ../LineCoverage.psm1
import module ../Report.psm1
import module ../SourceFile.psm1

<#
.SYNOPSIS
	Creates a new branch coverage.
.PARAMETER Data
	The coverage data.
.PARAMETER Found
	The number of branches found.
.PARAMETER Hit
	The number of branches hit.
.INPUTS
	None.
.OUTPUTS
	The newly created branch coverage.
#>
function New-BranchCoverage {
	[CmdletBinding()]
	param (
		[ValidateNotNull()] [BranchData[]] $Data = @(),
		[ValidateRange("NonNegative")] [int] $Found = 0,
		[ValidateRange("NonNegative")] [int] $Hit = 0
	)

	end {
		[BranchCoverage]@{ Data = $Data; Found = $Found; Hit = $Hit }
	}
}

<#
.SYNOPSIS
	Creates new branch data.
.PARAMETER LineNumber
	The line number.
.PARAMETER BlockNumber
	The block number.
.PARAMETER BranchNumber
	The branch number.
.PARAMETER Taken
	A number indicating how often this branch was taken.
.INPUTS
	None.
.OUTPUTS
	The newly created branch data.
#>
function New-BranchData {
	[CmdletBinding()]
	param (
		[ValidateRange("NonNegative")] [int] $LineNumber = 0,
		[ValidateRange("NonNegative")] [int] $BlockNumber = 0,
		[ValidateRange("NonNegative")] [int] $BranchNumber = 0,
		[ValidateRange("NonNegative")] [int] $Taken = 0
	)

	end {
		[BranchData]@{ LineNumber = $LineNumber; BlockNumber = $BlockNumber; BranchNumber = $BranchNumber; Taken = $Taken }
	}
}

<#
.SYNOPSIS
	Creates a new function coverage.
.PARAMETER Data
	The coverage data.
.PARAMETER Found
	The number of functions found.
.PARAMETER Hit
	The number of functions hit.
.INPUTS
	None.
.OUTPUTS
	The newly created function coverage.
#>
function New-FunctionCoverage {
	[CmdletBinding()]
	param (
		[ValidateNotNull()] [FunctionData[]] $Data = @(),
		[ValidateRange("NonNegative")] [int] $Found = 0,
		[ValidateRange("NonNegative")] [int] $Hit = 0
	)

	end {
		[FunctionCoverage]@{ Data = $Data; Found = $Found; Hit = $Hit }
	}
}

<#
.SYNOPSIS
	Creates new function data.
.PARAMETER FunctionName
	The function name.
.PARAMETER LineNumber
	The line number of the function start.
.PARAMETER ExecutionCount
	The execution count.
.INPUTS
	A string that contains a function name.
.OUTPUTS
	The newly created function data.
#>
function New-FunctionData {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position = 0, ValueFromPipeline)] [ValidateNotNullOrWhiteSpace()] [string] $FunctionName,
		[ValidateRange("NonNegative")] [int] $LineNumber = 0,
		[ValidateRange("NonNegative")] [int] $ExecutionCount = 0
	)

	end {
		[FunctionData]@{ FunctionName = $FunctionName; LineNumber = $LineNumber; ExecutionCount = $ExecutionCount }
	}
}

<#
.SYNOPSIS
	Creates a new line coverage.
.PARAMETER Data
	The coverage data.
.PARAMETER Found
	The number of lines found.
.PARAMETER Hit
	The number of lines hit.
.INPUTS
	None.
.OUTPUTS
	The newly created line coverage.
#>
function New-LineCoverage {
	[CmdletBinding()]
	param (
		[ValidateNotNull()] [LineData[]] $Data = @(),
		[ValidateRange("NonNegative")] [int] $Found = 0,
		[ValidateRange("NonNegative")] [int] $Hit = 0
	)

	end {
		[LineCoverage]@{ Data = $Data; Found = $Found; Hit = $Hit }
	}
}

<#
.SYNOPSIS
	Creates new line data.
.PARAMETER ExecutionCount
	The execution count.
.PARAMETER LineNumber
	The line number.
.PARAMETER Checksum
	The data checksum.
.INPUTS
	None.
.OUTPUTS
	The newly created line data.
#>
function New-LineData {
	[CmdletBinding()]
	param (
		[ValidateRange("NonNegative")] [int] $LineNumber = 0,
		[ValidateRange("NonNegative")] [int] $ExecutionCount = 0,
		[string] $Checksum = ""
	)

	end {
		[LineData]@{ LineNumber = $LineNumber; ExecutionCount = $ExecutionCount; Checksum = $Checksum }
	}
}

<#
.SYNOPSIS
	Creates a new report.
.PARAMETER TestName
	The test name.
.PARAMETER SourceFiles
	The source file list.
.INPUTS
	A string that contains the name of a test.
.OUTPUTS
	The newly created report.
#>
function New-Report {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position = 0, ValueFromPipeline)] [ValidateNotNullOrWhiteSpace()] [string] $TestName,
		[ValidateNotNull()] [SourceFile[]] $SourceFiles = @()
	)

	end {
		[Report]@{ TestName = $TestName; SourceFiles = $SourceFiles }
	}
}

<#
.SYNOPSIS
	Creates a new source file.
.PARAMETER Path
	The path to the source file.
.PARAMETER Branches
	The branch coverage.
.PARAMETER Functions
	The function coverage.
.PARAMETER Lines
	The line coverage.
.INPUTS
	A string that contains a path to a source file.
.OUTPUTS
	The newly created source file.
#>
function New-SourceFile {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position = 0, ValueFromPipeline)] [ValidateNotNullOrWhiteSpace()] [string] $Path,
		[BranchCoverage] $Branches = $null,
		[FunctionCoverage] $Functions = $null,
		[LineCoverage] $Lines = $null
	)

	end {
		[SourceFile]@{ Path = $Path; Branches = $Branches; Functions = $Functions; Lines = $Lines }
	}
}











<#
TODO
#>
function ConvertEachFile {
	param(
		[Parameter(Mandatory, Position = 0)] [string[]] $paths,
		[switch] $isLiteral
	)

	foreach ($path in $paths) {
		$resolvedPath = $isLiteral ? (Resolve-Path -LiteralPath $path) : (Resolve-Path $path)

	}
}

<#
.SYNOPSIS
	Converts the contents of a string or a file to a `Report` object.
.PARAMETER Path
	The path to the LCOV file(s) to convert.
.PARAMETER LiteralPath
	The path to the LCOV file(s) to convert.
.PARAMETER InputObject
	The input object of type `System.IO.FileInfo` or `string` with LCOV content to convert.
.OUTPUTS
	Lcov.Report
#>
function ConvertFrom-Coverage {
	[CmdletBinding()]
	[OutputType([Report])]
	param (
		[ValidateNotNullOrEmpty()] [Parameter(Mandatory, ParameterSetName = "Path", Position = 0)] [string] $path,
		[ValidateNotNullOrEmpty()] [Parameter(Mandatory, ParameterSetName = "LiteralPath")] [string] $literalPath,
		[ValidateNotNullOrEmpty()] [Parameter(Mandatory, ParameterSetName = "InputObject", ValueFromPipeline)][psobject] $inputObject
	)

	process {
		switch ($PSCmdlet.ParameterSetName) {
			"InputObject" {

			}

			"LiteralPath" {
				$resolvedPaths = Resolve-Path -LiteralPath $path
				$report = [Report]::TryParse($resolvedPath)
			}

			"Path" {
				$resolvedPaths = Resolve-Path -Path $path
				$report = [Report]::TryParse($resolvedPath)
			}
		}
	}
}
