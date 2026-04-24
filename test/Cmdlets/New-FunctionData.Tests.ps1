<#
.SYNOPSIS
	Tests the features of the `New-FunctionData` cmdlet.
#>
Describe "New-FunctionData" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Lcov.psd1"
	}

	It "should return a format like 'FN:<LineNumber>,<FunctionName>\nFNDA:<ExecutionCount>,<FunctionName>'" {
		New-LcovFunctionData -ExecutionCount 3 -FunctionName "main" -LineNumber 127 | Should -BeExactly "FN:127,main`nFNDA:3,main"
	}
}
