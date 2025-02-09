$ErrorActionPreference = 'Stop'
$ProgressPreference="SilentlyContinue"

Set-Alias vim nvim
$repoDir = "~/repos/scripts-and-configs"

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

function Start-NixRebuild {
  Push-Location
  sudo nixos-rebuild switch
  Copy-Item "/etc/nixos/configuration.nix" $(Join-Path $repoDir "nixos")
  Set-Location $repoDir
  git commit -am "update nix configuration"
  Pop-Location
}

function Start-NixGarbageCollect {
  sudo nix-collect-garbage -d
}

function Edit-NixConfig {
  sudo nvim "/etc/nixos/configuration.nix"
}

function Get-NixGenerations {
  sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
}

foreach( $path in @($(Join-Path $repoDir "scripts"))) {
    Add-PathVariable $path
}

function Prompt {
    $reset = "`e[0m"
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

