$ErrorActionPreference = 'Stop'
try {
  $x = pacman -Qtdq; 
  if( $null -ne $x ) { 
    sudo pacman -R $x
    return 
  }
  Write-Host "No uneccessary packages to remove."
}
catch {
  Write-Error $_
}
