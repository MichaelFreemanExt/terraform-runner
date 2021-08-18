function Resolve-WorkflowDirectory {
    
    [CmdletBinding()]
    param (
        [parameter(mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SourceDirectory,

        [ValidateNotNullOrEmpty()]
        [string]$WorkingDirectory = "./src"
    )
    
    process {
        
        if (-not(Test-Path $SourceDirectory)) {
            throw "Source Directory $SourceDirectory does not exist"
        }

        Push-Location $SourceDirectory
        $ResolvedSourceDirectory = (Get-Location).Path
        Pop-Location
        Write-Information "Source Directory is $ResolvedSourceDirectory"

        $JoinedWorkingDirectory = Join-Path $ResolvedSourceDirectory -ChildPath $WorkingDirectory
        
        try {
            $ResolvedWorkingDirectory = (Resolve-Path $JoinedWorkingDirectory).Path
            $Env:ResolvedWorkingDirectory = "$ResolvedWorkingDirectory"
            Write-Information "Working Dirctory is $ResolvedWorkingDirectory"     
        }
        catch {
            throw "Working Directory $JoinedWorkingDirectory does not exist : $PSItem"
        }
    }
}