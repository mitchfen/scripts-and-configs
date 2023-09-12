[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][securestring]$securePassword
)

#$securePassword = $(ConvertTo-SecureString -String $PlaintextPassword -AsPlainText -Force)
Set-LocalUser -Name $Username -Password $securePassword
