param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][securestring]$Password
)

$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
Set-LocalUser -Name $Username -Password $securePassword
