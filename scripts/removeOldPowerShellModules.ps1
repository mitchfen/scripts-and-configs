$modules = Get-InstalledModule
foreach ($module in $modules) {
  Write-Host -Message "Uninstalling any old versions of $($module.Name) [Latest currently installed is $( $module.Version)]"
  Get-InstalledModule -Name $module.Name -AllVersions | Where-Object {$_.Version -ne $module.Version} | Uninstall-Module -Verbose 
}
