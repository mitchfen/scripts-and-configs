$directories = Get-ChildItem -Directory | Select-Object Name

foreach ($directory in $directories) {
  Set-Location "./$($directory.Name)"
  Write-Host -ForegroundColor Green "Running a git clean on $($directory.Name)"
  git clean -fxd
  Set-Location ..
  Write-Host ""
}
