[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][string]$PlaintextPassword
)

$securePassword = $(ConvertTo-SecureString -String $PlaintextPassword -AsPlainText -Force)
Set-LocalUser -Name $Username -Password $securePassword
