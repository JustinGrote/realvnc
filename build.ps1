param(
	$Destination = $(Join-Path $PSScriptRoot 'dist')
)

nswag run $PSScriptRoot/RealVnc.nswag
$outDir = New-Item -ItemType Directory -Force $Destination

try {
	$binDir = (Join-Path $outDir 'bin')
	Push-Location $PSScriptRoot/RealVnc.Client
	dotnet publish -o $binDir
} finally {
	Pop-Location
}

Copy-Item $PSScriptRoot/RealVnc.psd1, $PSScriptRoot/RealVnc.psm1 -Destination $outDir

Write-Host -Fore Green "Module Build Complete and available in $outDir"