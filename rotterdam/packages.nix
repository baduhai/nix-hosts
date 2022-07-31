{ config, pkgs, lib, ... }:

{
  # Configure nixpkgs
  nixpkgs.config = {
    allowUnfree = true;                                # Allow unfree packages
    permittedInsecurePackages = [ "electron-11.5.0" ]; # Fuckin discord
  };

  # Packages.
  environment.systemPackages = with pkgs; [
    # Terminal tools and utilities
    micro
    wget
    git
    tmux
    neofetch
    protonup
    kitty
    p7zip
    gocryptfs
    usbimager
    # Development tools
    vscode-fhs
    virt-manager
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
    psst
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
    prusa-slicer
    solvespace
    # Customising appimage appimage deps
    (appimage-run.override {
      extraPkgs = pkgs: [ pkgs.libthai ];
    })
  ];
  
  # Managing shells
  programs.fish.enable = true;
  programs.zsh.enable = true;

  # Misc program management
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;

  # Fonts
  fonts = {
    fontDir.enable = true;
  	fonts = with pkgs; [
	  inter
  	  (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };
}
