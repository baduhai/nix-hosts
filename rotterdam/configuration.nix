{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./packages.nix
    ./users.nix
  ];

  boot = {
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
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
    };
  };

  sound.enable = true;
  hardware = {
    bluetooth.enable = true;
    opengl.driSupport32Bit = true;
    steam-hardware.enable = true;
    pulseaudio.enable = false;
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
    fwupd.enable = true;
    openssh.enable = true;
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
        supportDDC = true;
        excludePackages = ( with pkgs.plasma5Packages; [ elisa gwenview oxygen khelpcenter ]);
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

  security.rtkit.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 8d";
    };
  };

  system.stateVersion = "22.05";
}
