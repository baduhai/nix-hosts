# Configuration file purely for packages
{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages
  environment.systemPackages = with pkgs; [
    # Terminal tools and utilities
    micro
    wget
    git
    tmux
    pfetch
    neofetch
    fish
    protonup
    # Development tools
    vscode-fhs
    vagrant
    # Gaming related packages
    retroarchFull
    mangohud
    heroic
    polymc
    rpcs3
    space-cadet-pinball
    steam
    amdvlk
    steam-run
    itch
    yuzu-ea
    sc-controller
    # Programs
    kate
    qview
    gimp
    kolourpaint
    firefox
    thunderbird
    ungoogled-chromium
    obs-studio
    obs-studio-plugins.obs-vkcapture
    spotify
    mpv
    kalendar
    onlyoffice-bin
    ark
    kcalc
    discord
    element-desktop
    megasync
    qbittorrent
    signal-desktop
    tdesktop
    helvum
    partition-manager
    ventoy-bin
    yakuake
    bitwarden
    filelight
    easyeffects
    # Other packages
    dconf
    ankacoder
  ];
  
  # Fuckin Discord...
  nixpkgs.config.permittedInsecurePackages = [
    "electron-11.5.0"
  ];
  
  # Settings needed for steam
  hardware.opengl.driSupport32Bit = true;
  hardware.steam-hardware.enable = true;
}
