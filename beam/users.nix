# Configuration file purely for users
{ config, pkgs, ... }:
{
  # Import home manager
  imports = [ <home-manager/nixos> ];
  home-manager.useGlobalPkgs = true;
  
  # Users
  users.users.foxtrot = {
    isNormalUser = true;
    description = "William";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "";
  };
  home-manager.users.foxtrot = { pkgs, ... }: {
    # Nix language version
    home.stateVersion = "22.05";
    # Bash configuration
  	programs.bash.enable = true;
  	# Allow fonts installed by home-manager to be used elsewhere
  	fonts.fontconfig.enable = true;
  	# Cursor configuration
  	home.pointerCursor = { package = pkgs.breeze-icons; gtk.enable = true; name = "breeze_cursors"; size = 24; };
  	# GTK configuration
  	gtk.enable = true;
  	gtk.font = { name = "Noto Sans"; size = 10; };
  	gtk.gtk3.bookmarks = [ "file:///home/foxtrot/Games" ];
  	gtk.iconTheme = { package = pkgs.breeze-icons; name = "Breeze"; };
  	gtk.theme = { package = pkgs.breeze-gtk; name = "Breeze"; };
  };

  # Environment variables
  environment.sessionVariables = rec {
    KWIN_DRM_NO_AMS    = "1"; # Fixes cursor colour on plasma
    MOZ_ENABLE_WAYLAND = "1"; # Enables wayland support for firefox and thunderbird
    KDEHOME            = "$XDG_CONFIG_HOME/kde4"; # Stops kde from placing a .kde4 folder in you home dir
  };
}
