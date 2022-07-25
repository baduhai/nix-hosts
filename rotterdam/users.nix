# Configuration file purely for users
{ config, pkgs, ... }:
{
  # System wide environment variables
  environment.sessionVariables = rec {
    MANGOHUD = "1";
    KWIN_DRM_NO_AMS = "1";             # RDNA2 colour/gamma modesetting bug workaround for kwin wayland.
    MOZ_ENABLE_WAYLAND = "1";          # Enables wayland support for firefox and thunderbird.
    KDEHOME = "$XDG_CONFIG_HOME/kde4"; # Stops kde from placing a .kde4 folder in you home dir.
  };
  
  # Users
  users.users.foxtrot = {
    isNormalUser = true;
    description = "William";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    hashedPassword = "";
  };
}
