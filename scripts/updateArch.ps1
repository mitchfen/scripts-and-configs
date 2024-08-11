$aurPath = "~/aur" # set to location of downloaded aur git repos

function Write-Section {
  param(
      [Parameter(Mandatory)] [string] $msg
  )
  $color = "Magenta"
  $divider = "───────────────────────────────────────────────────────────────"
  Write-Host ""
  Write-Host $divider -ForegroundColor $color
  Write-Host $msg -ForegroundColor $color
  Write-Host $divider -ForegroundColor $color
}

function Update-AurPackages {
  Set-Location $aurPath
  Get-ChildItem -Path . -Directory | ForEach-Object {
      Set-Location $_.FullName;
      $gitOutput = git pull;
      if ( $gitOutput -like "Already up to date." ) {
          Write-Host "$($_.Name) is already up to date"
      }
      else {
          makepkg -si
          git clean -fxd
      }
  }
  Set-Location $PSScriptRoot
}

function Remove-UnusedPackmanPackages {
  try {
      $output = pacman -Qtdq;
      if( $null -ne $output ) {
        sudo pacman -R $output
        return
      }
      Write-Host "No uneccessary packages to remove."
    }
  catch {
    Write-Error $_
  }
  Write-Host ""
}

function Update-OhMyPosh {
  $ohMyPoshVersionFile = Join-Path $HOME ".oh-my-posh-version.txt"
  $version = Get-Content $ohMyPoshVersionFile
  Write-Host "Currently installed version is $version"
  $latestVersion = $(Invoke-WebRequest  "https://api.github.com/repos/JanDeDobbeleer/oh-my-posh/tags?per_page=1").Content |  jq -r '.[0].name'
  Write-Host "Latest version is $latestVersion"
  if ($version -eq $latestVersion) {
    Write-Host "Nothing to do!"
    return
  }
  sudo curl -s https://ohmyposh.dev/install.sh | sudo bash -s
  Write-Output $latestVersion> $ohMyPoshVersionFile
}

Write-Section "Updating pacman packages..."
sudo pacman -Syu

Write-Section "Updating aur packages..."
Update-AurPackages

Write-Section "Updating ohmyposh..."
Update-OhMyPosh

Write-Section "Updating flatpak packages..."
flatpak update

Write-Section "Removing unused pacman packages..."
Remove-UnusedPackmanPackages

Write-Section "Current package counts:"
Write-Host "Pacman packages: $(pacman -Q | wc -l)"
Write-Host "Flatpak packages: $(flatpak list | wc -l)"
