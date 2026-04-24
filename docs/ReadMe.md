# LCOV Reports for PowerShell
Parse and format [LCOV](https://github.com/linux-test-project/lcov) coverage reports,
in [PowerShell](https://learn.microsoft.com/en-us/powershell).
	
## Quick start
Install the latest version of **LCOV Reports for PowerShell**
with [PSResourceGet](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.psresourceget) package manager:

```shell
Install-PSResource Belin.Lcov
```

For detailed instructions, see the [installation guide](Installation.md).

## Usage
This library provides a set of [PowerShell](https://learn.microsoft.com/en-us/powershell) classes representing a [LCOV](https://github.com/linux-test-project/lcov) coverage report and its data.  
The `Report` class, the main one, provides the parsing and formatting features.  

This library also provides a set of cmdlets for accessing these features via [PowerShell](https://learn.microsoft.com/en-us/powershell).  
For more details, please refer to the following pages:

- [Parse coverage data from a LCOV file](LcovParsing.md)
- [Format coverage data to the LCOV format](LcovFormatting.md)
