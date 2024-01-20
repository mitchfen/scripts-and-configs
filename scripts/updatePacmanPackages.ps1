Set-Location ~/aur
Get-ChildItem -Path . -Directory | ForEach-Object { 
    Set-Location $_.FullName;
    $gitOutput = git pull;
    if ( $gitOutput -like "Already up to date." ) {
        Write-Host -Object "$($_.Name) is already up to date" -ForegroundColor Green
    }
    else { 
        makepkg -si
    }
}
Set-Location $PSScriptRoot
