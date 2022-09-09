{ config, pkgs, ... }:

{
  environment.sessionVariables = rec {
    KDEHOME = "$XDG_CONFIG_HOME/kde4"; # Stops kde from placing a .kde4 folder in the home dir
  };
  
  users.users = {
    work = {
      isNormalUser = true;
      description = "Work";
      shell = pkgs.fish;
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
      ];
      hashedPassword = "";
    };
    personal = {
      isNormalUser = true;
      description = "Personal";
      shell = pkgs.fish;
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
      ];
      hashedPassword = "";
    };
  };
}
