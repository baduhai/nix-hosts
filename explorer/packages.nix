{ config, pkgs, lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = true; # Allow non open source packages 
  };

  environment.systemPackages = with pkgs; [
    any-nix-shell # Use nix shell use any shell i.e. fish
    ark
    bat
    cinny-desktop
    clamav
    fd
    filelight
    firefox-wayland # Until firefox moves to using wayland by default
    fzf
    gimp
    git
    gnupg
    gocryptfs
    helvum
    libsForQt5.kasts
    kate
    kcalc
    keepassxc
    kolourpaint
    kitty
    mattermost-desktop
    micro
    mpv
    mumble
    neofetch
    nixfmt
    obs-studio
    onlyoffice-bin
    openssl
    p7zip
    psst
    spotify
    thunderbird-wayland # Until thunderbird moves to using wayland by default
    tmux
    ungoogled-chromium
    vagrant
    ventoy-bin
    virt-manager
    wget
    yakuake
    # App-specific overrides
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
      roboto
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };
}
