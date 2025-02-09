$ErrorActionPreference="Stop"
$ProgressPreference = "SilentlyContinue"

$env:DOTNET_CLI_TELEMETRY_OPTOUT=1
$env:NUKE_TELEMETRY_OPTOUT=1
$env:AZURE_CORE_COLLECT_TELEMETRY=0
$env:KUBE_EDITOR="nvim"

Function Invoke-CustomCommand {
	param (
		[Parameter(Mandatory)][string]$Command
	)

	Write-Host "Invoking: " -NoNewline
	Write-Host $Command -ForegroundColor Magenta
	$returnVal = Invoke-Expression -Command "$Command"
	if ($LASTEXITCODE -ne 0) {
		throw "Previous command failed with exit code $LASTEXITCODE."
	}
	return $returnVal
}

Function Edit-PSReadLineHistory {
  vim "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
}

Function Remove-Screenshots {
  Remove-Item $HOME\Pictures\Screenshots\*
}

Function Remove-Kubeconfig {
  Remove-Item $HOME/.kube/config -ErrorAction SilentlyContinue | Out-Null
}

Function Edit-NugetConfig {
  "vim $env:APPDATA\NuGet\NuGet.Config" | Invoke-Expression
}

Function Clear-NugetCache {
  $nugetCacheDir = "$HOME\.nuget\packages"
  $diskSpaceUsed = du -ch $nugetCacheDir/* | grep total
  Write-Host "NuGet packages make up $diskSpaceUsed"
  Get-ChildItem -Path $nugetCacheDir | ForEach-Object {
      Write-Host "Deleting" $_.Name
      Remove-Item $_.FullName -Recurse -Force
  }
}

Function Remove-OldPowerShellModules {
  $modules = Get-InstalledModule
  foreach ($module in $modules) {
      Write-Host -Message "Uninstalling any old versions of $($module.Name) [Latest currently installed is $( $module.Version)]"
      Get-InstalledModule -Name $module.Name -AllVersions | Where-Object {$_.Version -ne $module.Version} | Uninstall-Module -Verbose
  }
}

Function su {
	Start-Process pwsh -Verb runAs
}

function Prompt {
    $reset = "`e[0m"
    $bold = "`e[1m"
    $cyan= "`e[36m"
    $pink = "`e[38;5;205m"
    
    $currentDirectory = Get-Location
    try {
      $branch = $(git rev-parse --abbrev-ref HEAD).Trim()
      $prompt = "$pink$currentDirectory$reset | $cyan$branch$reset → "
    } catch {
      $prompt = "$pink$currentDirectory$reset → "
    }
    return $prompt
}

# Aliases
Set-Alias -Name j -Value createJournalEntry.ps1
Set-Alias -Name lf -Value lf.exe
Set-Alias -Name vim -Value "C:/Program Files/Neovim/bin/nvim.exe"
Set-Alias -Name unzip -Value "Expand-Archive"
Set-Alias -Name rider -Value "C:\Program Files (x86)\JetBrains\JetBrains Rider\bin\rider64.exe"
Set-Alias -Name 7z -Value 'C:\Program Files\7-Zip\7zFM.exe'

# K8s aliases
$wingetPackagesPath = "$env:LOCALAPPDATA\Microsoft\WinGet\Packages"
Set-Alias -Name kubectl -Value $(Join-Path $wingetPackagesPath "Kubernetes.kubectl_Microsoft.Winget.Source_8wekyb3d8bbwe\kubectl.exe")
Set-Alias -Name k -Value "kubectl"
Set-Alias -Name kubelogin -Value $(Join-Path $wingetPackagesPath "Microsoft.Azure.Kubelogin_Microsoft.Winget.Source_8wekyb3d8bbwe\bin\windows_amd64\kubelogin.exe")
Set-Alias -Name k9s -Value $(Join-Path $wingetPackagesPath "Derailed.k9s_Microsoft.Winget.Source_8wekyb3d8bbwe\k9s.exe")
Set-Alias -Name jq -Value $(Join-Path $wingetPackagesPath "jqlang.jq_Microsoft.Winget.Source_8wekyb3d8bbwe\jq.exe")

# GNU Core utils from Git Bash
Set-Alias -Name grep -Value "C:\Program Files\Git\usr\bin\grep.exe"
Set-Alias -Name du -Value "C:\Program Files\Git\usr\bin\du.exe"
Set-Alias -Name openssl -Value "C:\Program Files\Git\usr\bin\openssl.exe"
Set-Alias -Name file -Value "C:\Program Files\Git\usr\bin\file.exe"
Set-Alias -Name file -Value "C:\Program Files\Git\usr\bin\xargs.exe"
Set-Alias -Name which -Value "C:\Program Files\Git\usr\bin\which.exe"
Set-Alias -Name touch -Value "C:\Program Files\Git\usr\bin\touch.exe"
Set-Alias -Name wc -Value "C:\Program Files\Git\usr\bin\wc.exe"
Set-Alias -Name sed -Value "C:\Program Files\Git\usr\bin\sed.exe"
Set-Alias -Name gnudiff -Value "C:\Program Files\Git\usr\bin\diff.exe"
Set-Alias -Name gnucat -Value "C:\Program Files\Git\usr\bin\cat.exe"
Set-Alias -Name base64 -Value 'C:\Program Files\Git\usr\bin\base64.exe'
