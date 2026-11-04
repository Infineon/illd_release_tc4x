[CmdletBinding()]
param(
    [string]$ToolsDocPath,
    [string]$OutputDirectory,
    [string]$WarningLogPath,
    [string]$WarningReportPath,
    [string]$DoxygenExecutable = "doxygen",
    [switch]$Clean
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))

function ConvertTo-DoxygenPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    return ([System.IO.Path]::GetFullPath($Path) -replace "\\", "/")
}

function Join-DoxygenPathList {
    param([Parameter(Mandatory = $true)][string[]]$Paths)

    return (($Paths | ForEach-Object { ConvertTo-DoxygenPath $_ }) -join " ")
}

function ConvertTo-ReportPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        try {
            return ([System.IO.Path]::GetRelativePath($repoRoot, [System.IO.Path]::GetFullPath($Path)) -replace "\\", "/")
        }
        catch {
            return ($Path -replace "\\", "/")
        }
    }

    return ($Path -replace "\\", "/")
}

function ConvertTo-MarkdownCell {
    param([AllowNull()][string]$Text)

    if (-not $Text) {
        return ""
    }

    $cleanText = $Text -replace "`r?`n", " "
    return $cleanText.Replace("|", "\|")
}

function Get-DoxygenWarningSuggestion {
    param([Parameter(Mandatory = $true)][string]$Message)

    switch -Regex ($Message) {
        "found documented return type for .+ that does not return anything" {
            return "Remove or rewrite the return-value documentation for this void function, or change the function signature if a return value is intended."
        }
        "multiple use of section label '.+' while adding section" {
            return "Make section labels unique across the combined TC4xx documentation, for example by prefixing labels with the device or module name."
        }
        "Found non-existing group '.+' for the command '.+'" {
            return "Create the referenced Doxygen group with \defgroup or \addtogroup, or update the command to use an existing group id."
        }
        "Found unknown command '.+'" {
            return "Replace the unsupported Doxygen command with a supported command or define it as an alias in the Doxygen configuration."
        }
        "Unsupported xml/html tag .+ found" {
            return "Escape the tag-like text or replace it with supported HTML/Doxygen markup."
        }
        "Found recursive @copybrief or @copydoc relation" {
            return "Break the recursive @copybrief/@copydoc chain by pointing to a concrete documented symbol or writing the brief text directly."
        }
        "end of file while inside a group" {
            return "Add the missing group-closing command near the end of the file, usually @} or \} depending on the surrounding comment style."
        }
        "unbalanced grouping commands" {
            return "Balance Doxygen group open and close commands in this file; check nearby \defgroup, \addtogroup, @{, and @} usage."
        }
        "Refusing to add group .+ to itself" {
            return "Remove the self-referencing group membership or move the nested content into a distinct child group."
        }
        "argument '.+' of command @param is not found in the argument list" {
            return "Rename or remove the @param entry so it matches the function signature exactly."
        }
        "image file .+ is not found in IMAGE_PATH" {
            return "Add the image to doc/doxygen/common/images or update IMAGE_PATH/image references to the correct location."
        }
        "explicit link request to '.+' could not be resolved" {
            return "Correct the explicit link target, add the missing Doxygen anchor/group, or remove the link if the target is not generated."
        }
        "unable to resolve reference to '.+' for \\ref command" {
            return "Correct the \ref target, add the missing anchor/group, or include the file that defines the referenced item."
        }
        default {
            return "Inspect the nearby Doxygen comment and align the command, link target, or documented API contract with the generated symbol."
        }
    }
}

function New-DoxygenWarningReport {
    param(
        [Parameter(Mandatory = $true)][string]$LogPath,
        [Parameter(Mandatory = $true)][string]$ReportPath,
        [Parameter(Mandatory = $true)][string]$Version
    )

    $warnings = @()
    if (Test-Path -LiteralPath $LogPath) {
        foreach ($warningLine in (Get-Content -LiteralPath $LogPath)) {
            if ($warningLine -notmatch "warning:") {
                continue
            }

            if ($warningLine -match "^(?<file>.+?):(?<line>\d+):\s*(?:warning:\s*)?(?<message>.*)$") {
                $warningMessage = $Matches.message.Trim()
                $warnings += [pscustomobject]@{
                    File       = ConvertTo-ReportPath $Matches.file
                    Line       = $Matches.line
                    Message    = $warningMessage
                    Suggestion = Get-DoxygenWarningSuggestion $warningMessage
                }
            }
            else {
                $warnings += [pscustomobject]@{
                    File       = ""
                    Line       = ""
                    Message    = $warningLine.Trim()
                    Suggestion = Get-DoxygenWarningSuggestion $warningLine
                }
            }
        }
    }

    $reportLines = @(
        "# Doxygen Warning Report",
        "",
        "Generated by ``scripts/build-doxygen.ps1`` from the repository-local Doxygen configuration.",
        "",
        "- iLLD version: ``$Version``",
        "- Warning log: ``$(ConvertTo-ReportPath $LogPath)``",
        "- Total warnings: ``$($warnings.Count)``",
        "",
        "## Summary",
        ""
    )

    if ($warnings.Count -eq 0) {
        $reportLines += "No Doxygen warnings were reported."
    }
    else {
        $reportLines += "| Count | Suggested fix |"
        $reportLines += "| ---: | --- |"

        foreach ($group in ($warnings | Group-Object Suggestion | Sort-Object Count -Descending)) {
            $reportLines += "| $($group.Count) | $(ConvertTo-MarkdownCell $group.Name) |"
        }

        $reportLines += ""
        $reportLines += "## All Warnings"
        $reportLines += ""
        $reportLines += "| # | File | Line | Warning | Suggested fix |"
        $reportLines += "| ---: | --- | ---: | --- | --- |"

        $warningIndex = 0
        foreach ($warning in $warnings) {
            $warningIndex++
            $reportLines += "| $warningIndex | $(ConvertTo-MarkdownCell $warning.File) | $(ConvertTo-MarkdownCell $warning.Line) | $(ConvertTo-MarkdownCell $warning.Message) | $(ConvertTo-MarkdownCell $warning.Suggestion) |"
        }
    }

    New-Item -ItemType Directory -Force -Path ([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetFullPath($ReportPath))) | Out-Null
    Set-Content -LiteralPath $ReportPath -Value $reportLines -Encoding utf8
}

if (-not $ToolsDocPath) {
    $repoToolsDocPath = Join-Path $repoRoot "doc"

    if (Test-Path -LiteralPath (Join-Path $repoToolsDocPath "doxygen/iLLD_Aurix.cfg")) {
        $ToolsDocPath = $repoToolsDocPath
    }
    else {
        throw "Could not find repository-local Doxygen tooling at doc/doxygen/iLLD_Aurix.cfg."
    }
}

$toolsDoxygenPath = Join-Path $ToolsDocPath "doxygen"
$sharedConfigPath = Join-Path $toolsDoxygenPath "iLLD_Aurix.cfg"

if (-not (Test-Path -LiteralPath $sharedConfigPath)) {
    throw "Doxygen config not found: $sharedConfigPath"
}

if (-not $OutputDirectory) {
    $OutputDirectory = Join-Path $repoRoot "build/doxygen"
}

if (-not $WarningLogPath) {
    $WarningLogPath = Join-Path $OutputDirectory "doxygen-warnings.log"
}

if (-not $WarningReportPath) {
    $WarningReportPath = Join-Path $repoRoot "doc/doxygen-warnings-report.md"
}

# TC4x uses a flat Libraries layout: src/Libraries/{iLLD/TC4xx, Infra, Service}
$librariesPath = Join-Path $repoRoot "src/Libraries"
if (-not (Test-Path -LiteralPath $librariesPath)) {
    throw "Libraries root not found: $librariesPath"
}

$lldPath     = Join-Path $librariesPath "iLLD/TC4xx"
$infraPath   = Join-Path $librariesPath "Infra"
$servicePath = Join-Path $librariesPath "Service"

if (-not (Test-Path -LiteralPath $lldPath)) {
    throw "No iLLD source found at $lldPath"
}

# Read version from IfxLldVersion.h
$version = "V2.7.0"
$versionHeaderPath = Join-Path $librariesPath "IfxLldVersion.h"
if (Test-Path -LiteralPath $versionHeaderPath) {
    $major = (Select-String -LiteralPath $versionHeaderPath -Pattern "IFX_LLD_VERSION_MAJOR\s+(\d+)" | Select-Object -First 1).Matches[0].Groups[1].Value
    $minor = (Select-String -LiteralPath $versionHeaderPath -Pattern "IFX_LLD_VERSION_MINOR\s+(\d+)" | Select-Object -First 1).Matches[0].Groups[1].Value
    $patch = (Select-String -LiteralPath $versionHeaderPath -Pattern "IFX_LLD_VERSION_PATCH\s+(\d+)" | Select-Object -First 1).Matches[0].Groups[1].Value
    $version = "V$major.$minor.$patch"
}

if ($Clean -and (Test-Path -LiteralPath $OutputDirectory)) {
    Remove-Item -LiteralPath $OutputDirectory -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null

$lldPaths     = @($lldPath)
# @(if ...) ensures an empty array rather than $null when the path is absent
$infraPaths   = @(if (Test-Path -LiteralPath $infraPath)   { $infraPath })
$servicePaths = @(if (Test-Path -LiteralPath $servicePath) { $servicePath })

$env:CFG_PATH              = ConvertTo-DoxygenPath $toolsDoxygenPath
$env:ILLD_COMMON_FILES     = ConvertTo-DoxygenPath ([System.IO.Path]::Combine($toolsDoxygenPath, "common"))
$env:ILLD_DOXYGEN_DST      = ConvertTo-DoxygenPath $OutputDirectory
$env:ILLD_DOXYGEN_WARN_LOG = ConvertTo-DoxygenPath $WarningLogPath
$env:ILLD_DUT_SRC_FILES    = Join-DoxygenPathList $lldPaths
$env:ILLD_EXCLUDE_DIR      = ""
$env:ILLD_EXCLUDE_PATTERN  = "*/.git/* */build/* */_Reg/* */_RegInternal/* */Sfr/*"
$env:ILLD_HAVE_DOT         = if (Get-Command dot -ErrorAction SilentlyContinue) { "YES" } else { "NO" }
$env:ILLD_INFRA            = if ($infraPaths)   { Join-DoxygenPathList $infraPaths }   else { "" }
$env:ILLD_LOGO             = ConvertTo-DoxygenPath ([System.IO.Path]::Combine($toolsDoxygenPath, "common", "images", "infineon_logo.png"))
$env:ILLD_SRVSW            = if ($servicePaths) { Join-DoxygenPathList $servicePaths } else { "" }
$env:ILLD_SSW              = ""
$env:ILLD_STRIP_PATH       = ConvertTo-DoxygenPath $librariesPath
$env:ILLD_VERSION          = $version
$env:VERIF_DUT             = "TC4xx"
$env:VERIF_LLD             = ConvertTo-DoxygenPath $lldPaths[0]

$configPath = Join-Path $repoRoot "Doxyfile"
Write-Host "Generating Doxygen documentation for TC4xx iLLD $version"
Write-Host "Using Doxygen config: $sharedConfigPath"
Write-Host "Output directory: $OutputDirectory"
Write-Host "Graphviz dot enabled: $env:ILLD_HAVE_DOT"

& $DoxygenExecutable $configPath
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$htmlIndexPath = [System.IO.Path]::Combine($OutputDirectory, "html", "index.html")
if (-not (Test-Path -LiteralPath $htmlIndexPath)) {
    throw "Doxygen completed but no HTML index was found at $htmlIndexPath"
}

New-DoxygenWarningReport -LogPath $WarningLogPath -ReportPath $WarningReportPath -Version $version

Write-Host "Doxygen HTML generated at $htmlIndexPath"
Write-Host "Doxygen warning report generated at $WarningReportPath"
