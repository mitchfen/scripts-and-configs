$directories = Get-ChildItem -Directory | Select-Object Name

foreach ($directory in $directories) {
  Set-Location "./$($directory.Name)"
  Write-Host -ForegroundColor Green "Fetching/Pulling $($directory.Name)"
  git fetch; git pull
  Set-Location ..
  Write-Host ""
}
