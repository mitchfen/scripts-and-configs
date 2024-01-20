$ErrorActionPreference = 'Stop'
$ProgressPreference="SilentlyContinue"
$env:PATH+=":/home/mitchfen/dev/scripts"
Set-Alias -Name k -Value kubectl
Set-Alias -Name home -Value Set-LocationHome
Set-Alias -Name j -Value createJournalEntry.ps1

oh-my-posh init pwsh | Invoke-Expression
$env:POSHTHEMESPATH = "$HOME/.oh-my-posh-themes"
oh-my-posh init pwsh --config "$env:POSHTHEMESPATH/avit.omp.json" | Invoke-Expression

Function Set-LocationHome { Set-Location $HOME }

Function Get-Codes { ykman oath accounts code }

Function Get-RunningDaemons { systemctl list-units --type=service --state=running }

Function Get-HerbPrices { . ~/dev/osrs_herb_run_helper/checkHerbPrices.ps1 }
