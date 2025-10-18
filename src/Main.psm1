import module ../Report.psm1

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
function ConvertFrom-Lcov {
	[CmdletBinding()] [OutputType([Report])]

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
