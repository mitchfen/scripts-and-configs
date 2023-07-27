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
    Write-Host -ForegroundColor Green "Fetching/Pulling $($gitRepo.Name)"
    git fetch; git pull
    Set-Location ..
    Write-Host ""
  }
  Set-Location $PSScriptRoot
} catch {
  Write-Error $_
}
