# Module I import to both Windows and Linux machines to get some useful functionsg
function Get-Codes { ykman oath accounts code }
function Get-RunningDaemons { systemctl list-units --type=service --state=running }

function Get-HerbPrices { 
  if ($IsLinux) {
    $global:gitDir = "~/dev"
  }
  elseif ($IsWindows) {
    $global:gitDir = "/dev"
  }
  $scriptPath = Join-Path $gitDir "osrs_herb_run_helper/checkHerbPrices.ps1"
  . $scriptPath
}

function Edit-PSReadLineHistory {
  code "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
 }
 
function Edit-NugetConfig {
    "code $env:APPDATA\NuGet\NuGet.Config" | Invoke-Expression
}

Export-ModuleMember Get-HerbPrices

if ($IsLinux) {
  Export-ModuleMember Get-RunningDaemons
  Export-ModuleMember Get-Codes
}

elseif ($IsWindows) {
  Export-ModuleMember Edit-PSReadLineHistory
  Export-ModuleMember Edit-NugetConfig
}
