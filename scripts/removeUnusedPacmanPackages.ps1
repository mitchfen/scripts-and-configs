$ErrorActionPreference = 'Stop'
try {
  $x = pacman -Qtdq; 
  if( $null -ne $x ) { 
    sudo pacman -R $x
    return 
  }
  Write-Host -Object "No uneccessary packages to remove." -ForegroundColor Green
}
catch {
  $line = $_.Exception.InvocationInfo.ScriptLineNumber
  Write-Host "Exception: $_ at $line" -ForegroundColor Red
}
