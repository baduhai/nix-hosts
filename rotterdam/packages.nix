{ config, pkgs, lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = true; # Allow non open source packages
    packageOverrides = pkgs: {
      baduhai = import (builtins.fetchTarball "https://github.com/baduhai/nur/archive/master.tar.gz") { # Personal repo
        inherit pkgs;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    any-nix-shell # Use nix shell use any shell i.e. fish
    arduino
    ark
    bat
    bitwarden
    chatterino2
    fd
    filelight
    firefox-wayland # Until firefox moves to using wayland by default
    fzf
    gimp
    git
    gnupg
    gocryptfs # Encrypted vaults
    helvum
    # heroic
    inkscape
    # itch
    kate
    kitty
    kolourpaint
    libreoffice-qt
    mangohud
    megasync # Soon to be dropped once nas is fully operational
    micro
    mpv
    neofetch
    obs-studio
    obs-studio-plugins.obs-vkcapture
    partition-manager
    platformio
    polymc
    protonup
    prusa-slicer
    psst
    qbittorrent
    quickemu
    retroarchFull
    rpcs3
    rssguard
    signal-desktop
    solvespace
    space-cadet-pinball
    steam
    steam-run
    streamlink-twitch-gui-bin
    tdesktop
    thunderbird-wayland
    tmux
    traceroute
    tree
    ungoogled-chromium
    unrar
    vagrant
    ventoy-bin
    virt-manager
    wget
    yakuake
    yuzu-ea
    # App-specific overrides
    (appimage-run.override {
      extraPkgs = pkgs: [  ];
    })
    # Packages from 3rd party channels
    baduhai.koi
    baduhai.emulationstation-de
  ];

  programs = {
    fish.enable = true;
    dconf.enable = true;
    droidcam.enable = true;
    kdeconnect.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "qt";
    };
  };

  fonts = {
  	fontDir.enable = true;
  	fontconfig.enable = true;
    fonts = with pkgs; [
      inter
      roboto
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };
}
