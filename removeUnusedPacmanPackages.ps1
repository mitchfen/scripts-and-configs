$ErrorActionPreference = 'Stop'
try {
  $x = pacman -Qtdq; 
  if( $null -ne $x ) { 
    sudo pacman -R $x
    return 
  }
  Write-Host -Object "No uneccessary packages to remove." -ForegroundColor Gray
}
catch {
  Write-Error $_
}
