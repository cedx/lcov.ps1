@{
	ModuleVersion = "0.1.0"
	RootModule = "src/Main.psm1"

	Author = "Cédric Belin <cedx@outlook.com>"
	CompanyName = "Cedric-Belin.fr"
	Copyright = "© Cédric Belin"
	DefaultCommandPrefix = "Lcov"
	Description = "Parse and format to LCOV your code coverage reports."
	GUID = "f51ae505-9dca-4371-8f9b-79b24617d59d"

	AliasesToExport = @()
	CmdletsToExport = @()
	VariablesToExport = @()

	FunctionsToExport = @(
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
		"src/BranchCoverage.psm1"
		"src/FunctionCoverage.psm1"
		"src/LineCoverage.psm1"
		"src/Report.psm1"
		"src/SourceFile.psm1"
		"src/Tokens.psm1"
	)

	PrivateData = @{
		PSData = @{
			LicenseUri = "https://raw.githubusercontent.com/cedx/lov.ps1/main/License.md"
			ProjectUri = "https://github.com/cedx/lov.ps1"
			ReleaseNotes = "https://github.com/cedx/lov.ps1/releases"
			Tags = "coverage", "formatter", "lcov", "parser", "test", "writer"
		}
	}
}
