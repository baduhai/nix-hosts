# Configuration file purely for packages.
{ config, pkgs, ... }:

{
  # Configure nix(the package manager).
  nixpkgs.config = {
    allowUnfree = true;                                # Allow unfree packages.
    permittedInsecurePackages = [ "electron-11.5.0" ]; # Fuckin discord.
  };

  # Packages.
  environment.systemPackages = with pkgs; [
    # Terminal tools and utilities.
    micro
    wget
    git
    tmux
    pfetch
    neofetch
    fish
    protonup
    # Development tools.
    vscode-fhs
    vagrant
    # Gaming related packages.
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
    # Programs.
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
    # Other packages.
    dconf
    ankacoder
  ];
}
