using namespace System.Diagnostics.CodeAnalysis
using module ../src/Report.psm1
using module ../src/SourceFile.psm1

<#
.SYNOPSIS
	Tests the features of the `Report` module.
#>
Describe "Report" {
	BeforeAll {
		$coverage = Get-Content "res/Lcov.info" -Raw
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "")]
		$report = [Report]::Parse($coverage)
	}

	Context "Parse" {
		It "should have a test name" {
			$report.TestName | Should -BeExactly "Example"
		}

		It "should contain three source files" {
			$report.SourceFiles | Should -HaveCount 3
			$report.SourceFiles[0].Path | Should -BeExactly "/home/cedx/lcov.ps1/fixture.psd1"
			$report.SourceFiles[1].Path | Should -BeExactly "/home/cedx/lcov.ps1/func1.psm1"
			$report.SourceFiles[2].Path | Should -BeExactly "/home/cedx/lcov.ps1/func2.psm1"
		}

		It "should have detailed branch coverage" {
			$branches = $report.SourceFiles[1].Branches
			$branches.Found | Should -Be 4
			$branches.Hit | Should -Be 4
			$branches.Data | Should -HaveCount 4
			$branches.Data[0].LineNumber | Should -Be 8
		}

		It "should have detailed function coverage" {
			$functions = $report.SourceFiles[1].Functions
			$functions.Found | Should -Be 1
			$functions.Hit | Should -Be 1
			$functions.Data | Should -HaveCount 1
			$functions.Data[0].FunctionName | Should -BeExactly "func1"
		}

		It "should have detailed line coverage" {
			$lines = $report.SourceFiles[1].Lines
			$lines.Found | Should -Be 9
			$lines.Hit | Should -Be 9
			$lines.Data | Should -HaveCount 9
			$lines.Data[0].Checksum | Should -BeExactly "5kX7OTfHFcjnS98fjeVqNA"
		}

		It "should throw an error if the report is invalid or empty" -TestCases @(@{ Coverage = "ZZ" }, @{ Coverage = "TN:Example" }) {
			{ [Report]::Parse($coverage) } | Should -Throw
		}
	}

	Context "ToString" {
		It "should return a format like 'TN:[TestName]'" {
			[Report]::new("") | Should -Be ""
			$sourceFile = [SourceFile]::new("")
			[Report]::new("LcovTest", @($sourceFile)) | Should -BeExactly "TN:LcovTest`n$sourceFile"
		}
	}

	Context "TryParse" {
		It "should return a `Report` if the parsing succeeded" {
			[Report]::TryParse($coverage) | Should -BeOfType ([Report])
		}

		It "should return `$null if the parsing failed" {
			[Report]::TryParse("TN:Example") | Should -Be $null
		}
	}
}
