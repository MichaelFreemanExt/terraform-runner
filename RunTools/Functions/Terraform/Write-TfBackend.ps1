function Write-TfBackend {
    
    [CmdletBinding()]
    param (
        [Hashtable]$Backend
    )
    
    process {
        @{
            "terraform" = @{
                "backend" = $Backend
            }
        } | ConvertTo-Json -Depth 99 | Set-Content "backend.tf.json" -Encoding utf8NoBOM
    }
}