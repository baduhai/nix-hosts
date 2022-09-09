{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./packages.nix
    ./users.nix
  ];

  boot = {
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_zen; # Zen kernel
    kernelModules = [
      "i2c-dev" # Required for arduino dev
      "i2c-piix4" # Required for arduino dev
    ];
    loader = {
      timeout = 1;
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "rotterdam";
    firewall = {
      enable = true;
      checkReversePath = "loose"; # Tailscale mail fail without this
    };
  };

  sound.enable = true;
  hardware = {
    bluetooth.enable = true;
    opengl.driSupport32Bit = true; # For OpenGL games
    steam-hardware.enable = true; # Allow steam client to manage controllers
    pulseaudio.enable = false; # Use pipewire instead
  };

  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IE.UTF-8";
      LC_IDENTIFICATION = "en_IE.UTF-8";
      LC_MEASUREMENT = "en_IE.UTF-8";
      LC_MONETARY = "en_IE.UTF-8";
      LC_NAME = "en_IE.UTF-8";
      LC_NUMERIC = "en_IE.UTF-8";
      LC_PAPER = "en_IE.UTF-8";
      LC_TELEPHONE = "en_IE.UTF-8";
      LC_TIME = "en_IE.UTF-8";
    };
  };

  services = {
    printing.enable = true;
    fwupd.enable = true; # Firmware upgrade service
    openssh.enable = true;
    tailscale.enable = true;
    flatpak.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "altgr-intl";
      excludePackages = ( with pkgs; [ xterm ]);
      desktopManager.plasma5 = {
        enable     = true;
        excludePackages = ( with pkgs.plasma5Packages; [ elisa oxygen khelpcenter ]);
      };
      displayManager = {
        defaultSession = "plasmawayland";
        sddm = {
          enable = true;
          settings = {
            Theme = {
              CursorTheme = "breeze_cursors";
            };
            X11 = {
              UserAuthFile = ".local/share/sddm/Xauthority";
            };
          };
        };
      };
    };
  };

  security.rtkit.enable = true; # Needed for pipewire to acquire realtime priority

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true; # Baisically aliases docker to podman
    };
  };

  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    gc = { # Garbage collector
      automatic = true;
      options = "--delete-older-than 8d";
    };
  };

  system.stateVersion = "22.05";
}
