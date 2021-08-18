function Invoke-Process {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$FilePath,

        [string[]]$ArgumentList = @(),

        [int[]]$IgnoreExitCode = @(0)
    )
    
    begin {       
    }
    
    process {
        
        $pinfo = New-Object System.Diagnostics.ProcessStartInfo
        $pinfo.FileName = $FilePath
        $pinfo.RedirectStandardError = $true
        $pinfo.RedirectStandardOutput = $true
        $pinfo.UseShellExecute = $false
        $pinfo.Arguments = $ArgumentList -join " "

        $p = New-Object System.Diagnostics.Process
        $p.StartInfo = $pinfo
        $p.Start() | Out-Null
        $p.WaitForExit()

        $stdout = $p.StandardOutput.ReadToEnd()
        $stderr = $p.StandardError.ReadToEnd()

        Write-Host "stdout: $stdout"
        Write-Host "stderr: $stderr"   

        if ($stderr.Length -gt 0) {
            throw $stderr
        }

        if ($p.ExitCode -notin $IgnoreExitCode) {
            [System.Console]::Write($result.StandardError)
            throw "Process '${FilePath}' exited with code $($result.ExitCode)"
        }

        $stdout
    }
    
    end {      
    }
}