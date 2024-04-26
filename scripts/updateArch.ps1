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

Write-Section "Updating pacman packages..."
sudo pacman -Syyu

Write-Section "Updating aur packages..."
Update-AurPackages

Write-Section "Updating ohmyposh..."
sudo curl -s https://ohmyposh.dev/install.sh | sudo bash -s

Write-Section "Updating flatpak packages..."
flatpak update

Write-Section "Removing unused pacman packages..."
Remove-UnusedPackmanPackages

Write-Section "Getting system info..."
neofetch
