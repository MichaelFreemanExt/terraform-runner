Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$InformationPreference = "Continue"

Get-ChildItem "$PSScriptRoot/Functions/*.ps1" -File -Recurse | ForEach-Object {
    . $_.FullName
}

if ($PSVersionTable.PSVersion.Major -ge 7) {
    # Prevent unwrapping of arrays on PS7
    $PSDefaultParameterValues = @{
        "ConvertFrom-Json:NoEnumerate" = $true
    }
}
