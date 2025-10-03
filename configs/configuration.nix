{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "lumbridge";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Time
  time.timeZone = "America/Detroit";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.pcscd.enable = true;
  services.openssh.enable = true;
  services.displayManager.gdm.enable = true; # Gnome
  services.desktopManager.gnome.enable = true; # Gnome
  #services.printing.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire.noresample = { 
      "context.properties" = { 
        "default.clock.allowed-rates" = [ 48000 44100 96000 192000 ];
	"default.clock.rate" = 192000;
      }; 
    };
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  users.users.mitchfen = {
    isNormalUser = true;
    description = "mitchfen";
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
    ];
    shell = pkgs.powershell;
    packages = with pkgs; [
      # user specific packages here
    ];
  };

  # Uncomment these 4 to enable automatic login for the user.
  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "mitchfen";
  #systemd.services."getty@tty1".enable = false; # workaround
  #systemd.services."autovt@tty1".enable = false; # workaround

  # Determine which unfree packages can be installed
  #nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam-unwrapped"
      "steam"
      "google-chrome"
      "obsidian"
      "discord"
    ];

  programs.steam.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  environment.systemPackages = with pkgs; [
    go
    gh
    lf
    btop
    microfetch
    git
    powershell
    vlc
    librewolf-bin
    google-chrome
    mangohud
    github-desktop
    yubioath-flutter
    obsidian
    kubectl
    kubernetes-helm 
    k9s
    discord
    signal-desktop
    openssl
  ];
  environment.gnome.excludePackages = with pkgs; [ gnome-tour geary xterm epiphany ];

  # Do not change without reading the docs
  system.stateVersion = "24.11";
}


