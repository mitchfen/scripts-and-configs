$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"
$env:KUBE_EDITOR = "nvim"
$env:DOTNET_CLI_TELEMETRY_OPTOUT = 1
$env:NUKE_TELEMETRY_OPTOUT = 1
$env:AZURE_CORE_COLLECT_TELEMETRY = 0

oh-my-posh init pwsh | Invoke-Expression
#$theme="pixelrobots"
#$theme="avit"
$theme = "ys"
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/$theme.omp.json" | Invoke-Expression

# Aliases
Set-Alias -Name lf -Value lf.exe
Set-Alias -Name unzip -Value "Expand-Archive"
Set-Alias -Name rider -Value "rider64.exe"
Set-Alias -Name 7z -Value 'C:\Program Files\7-Zip\7zFM.exe'

# GNU Core utils from Git Bash
Set-Alias -Name grep -Value "C:\Program Files\Git\usr\bin\grep.exe"
Set-Alias -Name du -Value "C:\Program Files\Git\usr\bin\du.exe"
Set-Alias -Name openssl -Value "C:\Program Files\Git\usr\bin\openssl.exe"
Set-Alias -Name file -Value "C:\Program Files\Git\usr\bin\file.exe"
Set-Alias -Name file -Value "C:\Program Files\Git\usr\bin\xargs.exe"
Set-Alias -Name which -Value "C:\Program Files\Git\usr\bin\which.exe"
Set-Alias -Name touch -Value "C:\Program Files\Git\usr\bin\touch.exe"
Set-Alias -Name wc -Value "C:\Program Files\Git\usr\bin\wc.exe"
Set-Alias -Name sed -Value "C:\Program Files\Git\usr\bin\sed.exe"
Set-Alias -Name gnudiff -Value "C:\Program Files\Git\usr\bin\diff.exe"

Function Edit-PSReadLineHistory {
    code "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
}

Function Edit-NugetConfig {
    "code $env:APPDATA\NuGet\NuGet.Config" | Invoke-Expression
}

Function Clear-ConfigitNugetCache {
    $nugetCacheDir = "$HOME\.nuget\packages"
    $diskSpaceUsed = du -ch $nugetCacheDir/configit* | grep total
    Write-Host "Configit packages make up $diskSpaceUsed"
    Get-ChildItem -Path $(Join-Path $nugetCacheDir "configit*") | ForEach-Object {
        Write-Host "Deleting" $_.Name
        Remove-Item $_.FullName -Recurse -Force
    }
}

Function Remove-OldPowerShellModules {
    $modules = Get-InstalledModule
    foreach ($module in $modules) {
        Write-Host -Message "Uninstalling any old versions of $($module.Name) [Latest currently installed is $( $module.Version)]"
        Get-InstalledModule -Name $module.Name -AllVersions | Where-Object { $_.Version -ne $module.Version } | Uninstall-Module -Verbose
    }
}
