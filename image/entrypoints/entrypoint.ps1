[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    $actionType,

    [Parameter(Mandatory=$false)]
    $terraformFiles,

    [Parameter(Mandatory=$false)]
    $backendConfig
)

try {
    
    $currentDirectory = Get-Location
    Install-Module -Name AWSPowerShell.NetCore -Force

    Write-Host "actionType : $actionType"
    Write-Host "terraformFiles : $terraformFiles"
    Write-Host "backendConfig : $backendConfig"

    Write-Host "GITHUB_REPOSITORY : $env:GITHUB_REPOSITORY"
    
    #resolve actual directories
    $resolve_params = @{
        SourceDirectory = "$currentDirectory"
        WorkingDirectory = "$terraformFiles"
    }   
    Resolve-PipelineDirectory @resolve_params

    Write-Host "Resolved Working Directory $Env:ResolvedWorkingDirectory"

    #write the terraform backend
    $backendConfigHashTable = ConvertFrom-StringData -StringData $backendConfig
    Write-TfBackend $backendConfigHashTable    

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