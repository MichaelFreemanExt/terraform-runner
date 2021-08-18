function Write-TfBackend {
    
    [CmdletBinding()]
    param (
        [parameter(mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Hashtable]$Backend
    )
    
    process {
        
        Write-Host "Writing backend $Backend"

        @{
            "terraform" = @{
                "backend" = $Backend
            }
        } | ConvertTo-Json -Depth 99 | Set-Content "backend.tf.json" -Encoding utf8NoBOM

        Write-Host "Finished writing backend $Backend"
    }
}