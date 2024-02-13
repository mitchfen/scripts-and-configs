$ErrorActionPreference = 'Stop'
$ProgressPreference="SilentlyContinue"
$env:PATH+=":/home/mitchfen/dev/scripts_and_configs/scripts"
Set-Alias -Name k -Value kubectl
Set-Alias -Name home -Value Set-LocationHome
Set-Alias -Name j -Value createJournalEntry.ps1
Set-Alias -Name Get-Updates -Value updateArch.ps1

oh-my-posh init pwsh | Invoke-Expression
$env:POSHTHEMESPATH = "$HOME/.oh-my-posh-themes"
oh-my-posh init pwsh --config "$env:POSHTHEMESPATH/avit.omp.json" | Invoke-Expression
