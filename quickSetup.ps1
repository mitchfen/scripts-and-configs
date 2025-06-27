# Check if the OS is Linux
if ($PSVersionTable.PSVersion.Platform -ne 'Unix') {
    Write-Host "This script can only run on Linux."
    Exit
}

Function Get-FileFromUrl($url, $destination) {
    $response = Invoke-WebRequest $url
    $response.Content | Out-File $destination 
}

$baseUrl = "https://raw.githubusercontent.com/mitchfen/scripts-and-configs/refs/heads/main"

$nixConfigDir = "/etc/nixos/configuration.nix"
$lfrcDir = "~/.config/lf/lfrc"
$nvimConfigDir = "~/.config/nvim/init.vim"
$mangoHudDir = "~/.config/MangoHud/MangoHud.conf"

$downloadArray = @(
    @{url="$baseUrl/configs/configuration.nix"; destination=$nixConfigDir}
    @{url="$baseUrl/configs/powershell-profiles/linux/Microsoft.PowerShell_profile.ps1"; destination=$PROFILE}
    @{url="$baseUrl/configs/lfrc"; destination=$lfrcDir}
    @{url="$baseUrl/configs/init.lua"; destination=$nvimConfigDir}
    @{url="$baseUrl/configs/MangoHud.conf"; destination=$mangoHudDir}
)

ForEach($item in $downloadArray) {
    Get-FileFromUrl $item.url $item.destination
}

sudo nix-channel --update
sudo nixos-rebuild switch --dry-run

