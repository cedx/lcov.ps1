using module ./Cmdlets.psm1
& "$PSScriptRoot/Default.ps1"

"Publishing the package..."
$module = Import-PowerShellDataFile Lcov.psd1
$version = $module.ModuleVersion
New-GitTag "v$version"
Publish-PSGalleryModule
