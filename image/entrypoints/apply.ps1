[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    $terraformFiles,

    [Parameter(Mandatory=$false)]
    $backendConfig
)

try {
    Write-Host "GITHUB_REPOSITORY : $env:GITHUB_REPOSITORY"
    
    #resolve actual directories
    $resolve_params = @{
        SourceDirectory = Get-Location
        WorkingDirectory = "$terraformFiles"
    }   
    Resolve-WorkflowDirectory @resolve_params
    Set-Location "$Env:ResolvedWorkingDirectory"

    #write the terraform backend
    $backendConfigHashTable = ConvertFrom-StringData -StringData $backendConfig
    Write-TfBackend $backendConfigHashTable    
    
    Invoke-Process -FilePath "terraform" -ArgumentList @(
        "init", "-no-color"
    )

    Invoke-Process -FilePath "terraform" -ArgumentList @(
        "apply", "-no-color", "-auto-approve"
    )
}
catch {
    Write-Host "An error occured while processing $actionType"
    Write-Host $_
    exit 1
}