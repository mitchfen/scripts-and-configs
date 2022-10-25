
param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][string]$Password
)

$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
Set-LocalUser -Name $Username -Password $securePassword
