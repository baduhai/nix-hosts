{ config, pkgs, lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    ark
    bat
    cinny-desktop
    clamav
    fd
    filelight
    firefox-wayland
    fzf
    gimp
    git
    gnupg
    gocryptfs
    helvum
    kalendar
    kate
    keepassxc
    kitty
    kolourpaint
    mattermost-desktop
    micro
    mpv
    mumble
    neofetch
    obs-studio
    onlyoffice-bin
    p7zip
    partition-manager
    pass-wayland
    psst
    qview
    spotify
    thunderbird-wayland
    tmux
    ungoogled-chromium
    vagrant
    ventoy-bin
    virt-manager
    vscode-fhs
    wget
    yakuake
    (appimage-run.override {
      extraPkgs = pkgs: [  ];
    })
  ];

  programs.fish.enable = true;
  programs.dconf.enable = true;
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
