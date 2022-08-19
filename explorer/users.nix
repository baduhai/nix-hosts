{ config, pkgs, ... }:
{
  environment.sessionVariables = rec {
    KDEHOME = "$XDG_CONFIG_HOME/kde4";
  };
  
  users.users = {
    work = {
      isNormalUser = true;
      description = "Work";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
      hashedPassword = "";
    };
    personal = {
      isNormalUser = true;
      description = "Personal";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
      hashedPassword = "";
    };
  };
}
