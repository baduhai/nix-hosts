{ config, pkgs, ... }:
{
  environment.sessionVariables = rec {
    KWIN_DRM_NO_AMS = "1"; # RDNA2 colour/gamma modesetting bug workaround for kwin wayland
    KDEHOME = "$XDG_CONFIG_HOME/kde4"; # Stops kde from placing a .kde4 folder in the home dir
  };

  users.users.foxtrot = {
    isNormalUser = true;
    description = "William";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "uaccess" # Needed for HID dev
      "dialout" # Needed for arduino dev
    ];
    hashedPassword = "";
  };
}
