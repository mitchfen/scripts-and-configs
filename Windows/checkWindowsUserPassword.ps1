param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][string]$Password
)

Add-Type -AssemblyName System.DirectoryServices.AccountManagement
$obj = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('machine',$env:COMPUTERNAME)
if($obj.ValidateCredentials($Username, $Password)) {
  Write-Host "Provided password was correct for $Username"
} else {
  Write-Warning "Provided password was INCORRECT for $Username"
}
