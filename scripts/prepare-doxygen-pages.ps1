[CmdletBinding()]
param(
    [string]$DoxygenHtmlDirectory,
    [string]$OutputDirectory,
    [string]$WarningReportPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))

function Copy-DirectoryContent {
    param(
        [Parameter(Mandatory = $true)][string]$SourceDirectory,
        [Parameter(Mandatory = $true)][string]$DestinationDirectory
    )

    New-Item -ItemType Directory -Force -Path $DestinationDirectory | Out-Null
    Get-ChildItem -LiteralPath $SourceDirectory -Force | ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $DestinationDirectory -Recurse -Force
    }
}

function Get-ReleaseVersion {
    # TC4x README uses a tab separator: "iLLD Release version<TAB>V2.7.0"
    $readmePath = Join-Path $repoRoot "README.md"
    if (Test-Path -LiteralPath $readmePath) {
        $versionMatch = Select-String -LiteralPath $readmePath -Pattern "iLLD Release version\s+(\S+)" | Select-Object -First 1
        if ($versionMatch) {
            return $versionMatch.Matches[0].Groups[1].Value
        }
    }

    # Fall back to IfxLldVersion.h
    $headerPath = Join-Path $repoRoot "src/Libraries/IfxLldVersion.h"
    if (Test-Path -LiteralPath $headerPath) {
        $major = (Select-String -LiteralPath $headerPath -Pattern "IFX_LLD_VERSION_MAJOR\s+(\d+)" | Select-Object -First 1).Matches[0].Groups[1].Value
        $minor = (Select-String -LiteralPath $headerPath -Pattern "IFX_LLD_VERSION_MINOR\s+(\d+)" | Select-Object -First 1).Matches[0].Groups[1].Value
        $patch = (Select-String -LiteralPath $headerPath -Pattern "IFX_LLD_VERSION_PATCH\s+(\d+)" | Select-Object -First 1).Matches[0].Groups[1].Value
        return "V$major.$minor.$patch"
    }

    return "V2.7.0"
}

function Get-VersionSlug {
    param([Parameter(Mandatory = $true)][string]$Version)

    $slug = $Version.ToLowerInvariant() -replace "[^a-z0-9.-]+", "-"
    return $slug.Trim("-".ToCharArray())
}

function Write-VersionManifest {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Version,
        [Parameter(Mandatory = $true)][string]$VersionSlug,
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$RelativePrefix
    )

    $manifest = [ordered]@{
        current = $Version
        versions = @(
            [ordered]@{
                label = "Latest"
                version = "latest"
                path = "$($RelativePrefix)latest/"
            },
            [ordered]@{
                label = $Version
                version = $Version
                path = "$($RelativePrefix)$VersionSlug/"
            }
        )
    }

    $manifest | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $Path -Encoding utf8
}

if (-not $DoxygenHtmlDirectory) {
    $DoxygenHtmlDirectory = Join-Path $repoRoot "build/doxygen/html"
}

if (-not $OutputDirectory) {
    $OutputDirectory = Join-Path $repoRoot "build/pages"
}

if (-not $WarningReportPath) {
    $WarningReportPath = Join-Path $repoRoot "doc/doxygen-warnings-report.md"
}

if (-not (Test-Path -LiteralPath (Join-Path $DoxygenHtmlDirectory "index.html"))) {
    throw "Doxygen HTML index not found under $DoxygenHtmlDirectory"
}

if (Test-Path -LiteralPath $OutputDirectory) {
    Remove-Item -LiteralPath $OutputDirectory -Recurse -Force
}

$version = Get-ReleaseVersion
$versionSlug = Get-VersionSlug $version
$latestDirectory = Join-Path $OutputDirectory "latest"
$versionDirectory = Join-Path $OutputDirectory $versionSlug

Copy-DirectoryContent -SourceDirectory $DoxygenHtmlDirectory -DestinationDirectory $latestDirectory
Copy-DirectoryContent -SourceDirectory $DoxygenHtmlDirectory -DestinationDirectory $versionDirectory

Write-VersionManifest -Path (Join-Path $latestDirectory "versions.json") -Version $version -VersionSlug $versionSlug -RelativePrefix "../"
Write-VersionManifest -Path (Join-Path $versionDirectory "versions.json") -Version $version -VersionSlug $versionSlug -RelativePrefix "../"
Write-VersionManifest -Path (Join-Path $OutputDirectory "versions.json") -Version $version -VersionSlug $versionSlug -RelativePrefix ""

if (Test-Path -LiteralPath $WarningReportPath) {
    Copy-Item -LiteralPath $WarningReportPath -Destination (Join-Path $OutputDirectory "doxygen-warnings-report.md") -Force
}

$indexHtml = @"
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="refresh" content="0; url=latest/">
  <title>iLLD_TC4x Documentation</title>
  <link rel="canonical" href="latest/">
</head>
<body>
  <p><a href="latest/">Open the latest iLLD_TC4x documentation.</a></p>
</body>
</html>
"@

Set-Content -LiteralPath (Join-Path $OutputDirectory "index.html") -Value $indexHtml -Encoding utf8
New-Item -ItemType File -Force -Path (Join-Path $OutputDirectory ".nojekyll") | Out-Null

Write-Host "Prepared GitHub Pages artifact at $OutputDirectory"
Write-Host "Latest documentation: $latestDirectory"
Write-Host "Versioned documentation: $versionDirectory"
