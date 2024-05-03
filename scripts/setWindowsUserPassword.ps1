[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][string]$PlaintextPassword
)

Set-LocalUser -Name $Username -Password $( ConvertTo-SecureString $PlaintextPassword -AsPlainText -Force )
