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
    Resolve-WorkflowDirectory @resolve_params

    Write-Host "Resolved Working Directory $Env:ResolvedWorkingDirectory"

    Set-Location "$Env:ResolvedWorkingDirectory"

    #write the terraform backend
    $backendConfigHashTable = ConvertFrom-StringData -StringData $backendConfig
    Write-TfBackend $backendConfigHashTable    

    $childItem = Get-ChildItem
    Write-Host "Child items of current director $childItem"

    Add-PrComment "Michael"
    
    Invoke-Process -FilePath "terraform" -ArgumentList @(
        "init", "-no-color"
    )

    $planFile = "$Env:ResolvedWorkingDirectory/plan.tfplan"
    Write-Host "plan file name : $planFile"
    Invoke-Process -FilePath "terraform" -ArgumentList @(
        "plan", "-no-color", "-out",
        "$planFile"
    )
}
catch {
    Write-Host "An error occured while processing $actionType"
    Write-Host $_
    exit 1
}