[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Directory
)

try {
  $ErrorActionPreference="Stop"
  if(!$(Test-Path $Directory)) {
    throw "Directory $Directory does not exist!"
  }
  $gitRepos = Get-ChildItem -Directory $Directory | Select-Object Name
  Set-Location $Directory
  foreach ($gitRepo in $gitRepos) {
    Set-Location "./$($gitRepo.Name)"
    Write-Host -ForegroundColor Green "Running a git clean on $($gitRepo.Name)"
    git clean -fxd
    Set-Location ..
    Write-Host ""
  }
  Set-Location $PSScriptRoot
} catch {
    $line = $_.Exception.InvocationInfo.ScriptLineNumber
    Write-Host "Exception: $_ at $line" -ForegroundColor Red
}
