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