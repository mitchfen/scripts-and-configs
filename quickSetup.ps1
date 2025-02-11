# Check if the OS is Linux
if ($PSVersionTable.PSVersion.Platform -ne 'Unix') {
    Write-Host "This script can only run on Linux."
    Exit
}

Write-Host "Getting configuration.nix..."
$nixConfigUrl = "https://raw.githubusercontent.com/mitchfen/scripts-and-configs/refs/heads/main/nixos/configuration.nix" 
$(Invoke-WebRequest $nixConfigUrl).Content | Out-File "/etc/nixos/configuration.nix"

Write-Host "Getting PowerShell profile..."
$pwshProfileUrl = "https://raw.githubusercontent.com/mitchfen/scripts-and-configs/refs/heads/main/pwsh/linux/Microsoft.PowerShell_profile.ps1"
$(Invoke-WebRequest $pwshProfileUrl).Content | Out-File $PROFILE
. $PROFILE

Write-Host "Getting lfrc..."
$lfrcDir = "~/.config/lf/lfrc"
$lfrcUrl = "https://raw.githubusercontent.com/mitchfen/scripts-and-configs/refs/heads/main/lf/linux/lfrc"
mkdir -p $lfrcDir
$(Invoke-WebRequest $lfrcUrl).Content | Out-File $lfrcDir

Write-Host "Getting neovim config..."
$nvimConfigUrl = "https://raw.githubusercontent.com/mitchfen/scripts-and-configs/refs/heads/main/nvim/init.lua"
$nvimConfigDir = "~/.config/nvim/init.vim"
$(Invoke-WebRequest $nvimConfigUrl).Content | Out-File $nvimConfigDir

Write-Host "Done! 🙂"

