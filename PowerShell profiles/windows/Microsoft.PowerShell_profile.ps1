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

Function Clear-ConfigitNugetCache {
  $nugetCacheDir = "$HOME\.nuget\packages"
  $diskSpaceUsed = du -ch $nugetCacheDir/configit* | grep total
  Write-Host "Configit packages make up $diskSpaceUsed"
  Get-ChildItem -Path $(Join-Path $nugetCacheDir "configit*") | ForEach-Object {
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

# Aliases
Set-Alias -Name j -Value createJournalEntry.ps1
Set-Alias -Name lf -Value lf.exe
Set-Alias -Name k -Value "kubectl"
Set-Alias -Name vim -Value "C:/Program Files/Neovim/bin/nvim.exe"
Set-Alias -Name unzip -Value "Expand-Archive"
Set-Alias -Name 7z -Value 'C:\Program Files\7-Zip\7zFM.exe'

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

oh-my-posh init pwsh | Invoke-Expression
$theme = "avit" # Extremely fast and simple
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/$theme.omp.json" | Invoke-Expression

