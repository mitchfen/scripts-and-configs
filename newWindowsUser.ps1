[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][string]$Password
)

New-LocalUser -Name $Username -Password $(ConvertTo-SecureString -String $Password -AsPlainText -Force)


