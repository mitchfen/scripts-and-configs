[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][SecureString]$SecurePassword
)

$cmd = "Set-LocalUser -Name $Username -Password $SecurePassword"
Start-Process powershell -verb runas -ArgumentList "$cmd" -WindowStyle Hidden
