param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][securestring]$Password
)

Set-LocalUser -Name $Username -Password $Password
