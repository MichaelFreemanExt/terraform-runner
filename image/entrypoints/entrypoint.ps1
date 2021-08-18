[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    $actionType,

    [Parameter(Mandatory=$false)]
    $terraformFiles
)

try {
    
    Install-Module -Name AWSPowerShell.NetCore -Force


    Write-Host "Hello 1 $1"
    Write-Host "Hello 2 $2"

    Write-Host "actionType : $actionType"
    Write-Host "terraformFiles : $terraformFiles"
    Write-Host "looks like everything is good!"
    Write-Host "PS Module Paths $Env:PSModulePath"
    $childItem = Get-ChildItem "/opt/microsoft/powershell/7-lts/Modules"
    Write-Host "Module Children $childItem"
    $childItem = Get-ChildItem "/opt/microsoft/powershell/7-lts/Modules/RunTools"
    Write-Host "RunTools Module Children $childItem"
    $installedModules = Get-Module -ListAvailable
    Write-Host "Available Modules $installedModules"


    Add-PrComment "Michael"
    & "terraform" version
    & "/usr/local/bin/terraform" version
}
catch {
    Write-Host "An error occured while processing $actionType"
    Write-Host $_
    exit 1
}