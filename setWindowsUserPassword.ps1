[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][securestring]$PlaintextPassword
)

Set-LocalUser -Name $Username -Password $securePassword
