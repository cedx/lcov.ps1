@{
	DefaultCommandPrefix = "Lcov"
	ModuleVersion = "1.0.0"
	PowerShellVersion = "7.6"

	Author = "Cédric Belin <cedx@outlook.com>"
	CompanyName = "Cedric-Belin.fr"
	Copyright = "© Cédric Belin"
	Description = "Parse and format to LCOV your code coverage reports."
	GUID = "158416ed-ea32-4bcf-ac5d-8c555ad917e5"

	AliasesToExport = @()
	CmdletsToExport = @()
	VariablesToExport = @()

	FunctionsToExport = @(
		"ConvertFrom-Info"
		"New-BranchCoverage"
		"New-BranchData"
		"New-FunctionCoverage"
		"New-FunctionData"
		"New-LineCoverage"
		"New-LineData"
		"New-Report"
		"New-SourceFile"
	)

	NestedModules = @(
		"src/Cmdlets/ConvertFrom-Info.psm1"
		"src/Cmdlets/New-BranchCoverage.psm1"
		"src/Cmdlets/New-BranchData.psm1"
		"src/Cmdlets/New-FunctionCoverage.psm1"
		"src/Cmdlets/New-FunctionData.psm1"
		"src/Cmdlets/New-LineCoverage.psm1"
		"src/Cmdlets/New-LineData.psm1"
		"src/Cmdlets/New-Report.psm1"
		"src/Cmdlets/New-SourceFile.psm1"
	)

	PrivateData = @{
		PSData = @{
			LicenseUri = "https://github.com/cedx/lcov.ps1/blob/main/License.md"
			ProjectUri = "https://github.com/cedx/lcov.ps1"
			ReleaseNotes = "https://github.com/cedx/lcov.ps1/releases"
			Tags = "coverage", "formatter", "lcov", "parser", "test", "writer"
		}
	}
}
