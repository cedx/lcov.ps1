"Publishing the package..."
$version = (Import-PowerShellDataFile "Lcov.psd1").ModuleVersion
git tag "v$version"
git push origin "v$version"
