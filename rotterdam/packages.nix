# Configuration file purely for packages.
{ config, pkgs, lib, ... }:

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
    neofetch
    protonup
    kitty
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
    inkscape
    easyeffects
    discover
    # Other packages.
    dconf
    ankacoder
    p7zip
    # Customising appimage appimage deps.
    (appimage-run.override {
      extraPkgs = pkgs: [ pkgs.libthai ];
    })
  ];

  # For some reason kdeconnect needs its own thing.
  programs.kdeconnect.enable = true;

  # Fonts.
  fonts = {
    fontDir.enable = true;
  	fonts = with pkgs; [
	  inter
  	  nerdfonts
    ];
  };

  # Managing shells
  programs.fish.enable = true;
  programs.zsh.enable = true;
}
