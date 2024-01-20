[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$GitDirectory
)

try {
  $ErrorActionPreference="Stop"
  if(!$(Test-Path $GitDirectory)) {
    throw "Directory $GitDirectory does not exist!"
  }
  $gitRepos = Get-ChildItem -Directory $GitDirectory | Select-Object Name
  Set-Location $GitDirectory
  foreach ($gitRepo in $gitRepos) {
    Set-Location "./$($gitRepo.Name)"
    Write-Host -ForegroundColor Green "Fetching/Pulling $($gitRepo.Name)"
    git fetch; git pull
    Set-Location ..
    Write-Host ""
  }
  Set-Location $PSScriptRoot
} catch {
  Write-Error $_
}
