using module ./Cmdlets.psm1

if ($Release) { & "$PSScriptRoot/Default.ps1" }
else {
	"The ""-Release"" switch must be set!"
	exit 1
}

"Publishing the package..."
$module = Import-PowerShellDataFile Lcov.psd1
$version = $module.ModuleVersion
New-GitTag "v$version"
# Publish-NuGetPackage -NoBuild

$output = "var/PSModule"
New-Item $output/bin, $output/src -ItemType Directory | Out-Null
Copy-Item Lcov.psd1 $output/Belin.Lcov.psd1
Copy-Item *.md $output
Copy-Item src/Cmdlets $output/src -Recurse
$module.RequiredAssemblies | Copy-Item -Destination $output/bin

$output = "var/PSGallery"
New-Item $output -ItemType Directory | Out-Null
Compress-PSResource var/PSModule $output
Get-Item "$output/*.nupkg" | ForEach-Object { Publish-PSResource -ApiKey $Env:PSGALLERY_API_KEY -NupkgPath $_ -Repository PSGallery }
