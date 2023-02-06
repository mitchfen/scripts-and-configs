param(
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][SecureString]$SecurePassword
)

$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
$UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)

Add-Type -AssemblyName System.DirectoryServices.AccountManagement
$obj = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('machine',$env:COMPUTERNAME)
if($obj.ValidateCredentials($Username, $UnsecurePassword)) {
  Write-Host "Provided password was correct for $Username"
} else {
  Write-Error "Provided password was INCORRECT for $Username"
}
