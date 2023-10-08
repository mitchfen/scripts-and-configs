try {
    $invocationDirectory = $pwd
    $ErrorActionPreference="Stop"
    Write-Warning "This script will delete branches in this repo that have been deleted on the remote."
    Write-Warning "It should keep any local branches which were never pushed to the remote, but use at your own risk."
    
    $repoPath = Read-Host "What is the path to the repository you'd like to clean?"

    Write-Host "Moving to $repoPath..."
    if( $(Test-Path $repoPath) -ne $true) {
        throw "Invalid path."
    }
    Set-Location $repoPath
    
    $defaultBranch = Read-Host "What is the default branch for this repo?"
    
    git checkout $defaultBranch;
    if ( $LASTEXITCODE -ne 0 ) {
        throw "Git failed to checkout the specified branch."
    }
    
    Write-Host "Fetching and pruning local references to remote branches..."
    git fetch --prune;
    
    Write-Host "Deleting local branches which do not exist on remote..."
    git branch -vv | Select-String -Pattern ": gone]" | ForEach-Object { $_.toString().Trim().Split(" ")[0]} | ForEach-Object {git branch -D $_}
    
    Write-Host "Done!"
} 
catch {
    Write-Error $_
    exit
} 
finally {
    Set-Location $invocationDirectory
}

