{ pkgs, ... }: {
  nixpkgs.crossSystem.system = "aarch64-linux";
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest_hardened; # Raspberry pies have a hard time booting on the current LTS kernel.
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA1v3+q3EaruiiStWjubEJWvtejam/r41uoOpCdwJtLL foxtrot@rotterdam"
  ];
  system.stateVersion = "22.05";
}
