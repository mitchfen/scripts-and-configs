$ErrorActionPreference="Stop"
$ProgressPreference = "SilentlyContinue"
$env:KUBE_EDITOR="code -w"
$env:PATH+=":/dev/scripts_and_configs/scripts"
$env:DOTNET_CLI_TELEMETRY_OPTOUT=1
$env:NUKE_TELEMETRY_OPTOUT=1
$env:AZURE_CORE_COLLECT_TELEMETRY=0

oh-my-posh init pwsh | Invoke-Expression
#$theme="pixelrobots"
#$theme="avit"
$theme="ys"
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/$theme.omp.json" | Invoke-Expression

# Aliases
Set-Alias -Name lf -Value lf.exe
Set-Alias -Name vim -Value "C:/Program Files/Vim/vim90/vim.exe"
Set-Alias -Name unzip -Value "Expand-Archive"
Set-Alias -Name k -Value "kubectl"
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
Set-Alias -Name wc -Value "C:\Program Files\Git\usr\bin\touch.exe"
Set-Alias -Name gnudiff -Value "C:\Program Files\Git\usr\bin\diff.exe"
Set-Alias -Name sed -Value "C:\Program Files\Git\usr\bin\sed.exe"

Import-Module "/dev/scripts_and_configs/scripts/mitchHelperFunctions.psm1"
