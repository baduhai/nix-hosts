{ config, pkgs, lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-11.5.0" ]; # Fuckin discord
  };

  environment.systemPackages = with pkgs; [
    amdvlk
    arduino
    ark
    bat
    bitwarden
    chatterino2
    cinny-desktop
    cura
    discord
    element-desktop
    fd
    filelight
    firefox-wayland
    fzf
    gimp
    git
    gnupg
    gocryptfs
    helvum
    heroic
    home-manager
    inkscape
    itch
    kalendar
    kate
    kitty
    kolourpaint
    mangohud
    megasync
    micro
    mpv
    neofetch
    obs-studio
    obs-studio-plugins.obs-vkcapture
    onlyoffice-bin
    openrgb
    p7zip
    partition-manager
    pass-wayland
    platformio
    polymc
    protonup
    # prusa-slicer
    psst
    qbittorrent
    qview
    retroarchFull
    rpcs3
    sc-controller
    signal-desktop
    solvespace
    space-cadet-pinball
    spotify
    steam
    steam-run
    streamlink-twitch-gui-bin
    tdesktop
    thunderbird-wayland
    tmux
    ungoogled-chromium
    usbutils
    vagrant
    ventoy-bin
    virt-manager
    vscode-fhs
    wget
    yakuake
    yuzu-ea
    (appimage-run.override {
      extraPkgs = pkgs: [  ];
    })
  ];

  programs.fish.enable = true;
  programs.dconf.enable = true;
  programs.droidcam.enable = true;
  programs.kdeconnect.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "qt";
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
    inter
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };
}
