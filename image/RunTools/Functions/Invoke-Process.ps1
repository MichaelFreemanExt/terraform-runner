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
        $pinfo.WorkingDirectory = $PWD
        $pinfo.Arguments = $ArgumentList -join " "

        $p = New-Object System.Diagnostics.Process
        $p.StartInfo = $pinfo
        $p.Start() | Out-Null
        $p.WaitForExit()

        $stdout = $p.StandardOutput.ReadToEnd()
        $stderr = $p.StandardError.ReadToEnd()

        Write-Host "stdout: $stdout"
        Write-Host "stderr: $stderr"
        Write-Host "exitcode: $p.ExitCode"   

        if ($stderr.Length -gt 0) {
            Write-Host "throwing std error"   
            throw $stderr
        }

        if ($p.ExitCode -notin $IgnoreExitCode) {
            Write-Host "$p.ExitCode"
            throw "Process '${FilePath}' exited with code $($p.ExitCode)"
        }

        $stdout
    }
    
    end {      
    }
}