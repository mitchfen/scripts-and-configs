[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][string]$Password
)

Set-LocalUser -Name $Username -Password $(ConvertTo-SecureString -String $Password -AsPlainText -Force)
