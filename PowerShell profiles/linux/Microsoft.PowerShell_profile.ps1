$ErrorActionPreference = 'Stop'
$ProgressPreference="SilentlyContinue"
$env:DOTNET_ROOT="/home/mitchfen/.dotnet"
$env:DOTNET_CLI_TELEMETRY_OPTOUT=1

Set-Alias -Name k -Value kubectl
Set-Alias -Name home -Value Set-LocationHome
Set-Alias -Name Get-Updates -Value updateArch.ps1

oh-my-posh init pwsh | Invoke-Expression
$env:POSHTHEMESPATH = "$HOME/.oh-my-posh-themes"
oh-my-posh init pwsh --config "$env:POSHTHEMESPATH/avit.omp.json" | Invoke-Expression

function Get-Codes { ykman oath accounts code }
function Get-RunningDaemons { systemctl list-units --type=service --state=running }
function Add-PathVariable {
    param (
        [string]$addPath
    )
    if (Test-Path $addPath){
        $regexAddPath = [regex]::Escape($addPath)
        $arrPath = $env:PATH -split ':' | Where-Object {$_ -notMatch "^$regexAddPath\\?"}
        $env:PATH = ($arrPath + $addPath) -join ':'
    } else {
        throw "'$addPath' is not a valid path."
    }
}

foreach( $path in @(
    "/home/mitchfen/go/bin",
    "/home/mitchfen/dev/scripts_and_configs/scripts",
    "/home/mitchfen/.dotnet",
    "/home/mitchfen/.dotnet/tools"
)) {
    Add-PathVariable $path
}
