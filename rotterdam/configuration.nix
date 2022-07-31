{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./packages.nix
      ./users.nix
    ];

  # Configre boot preocess
  boot = {
    plymouth.enable = true; # Boot animations
    kernelPackages = pkgs.linuxPackages_zen; # Latest zen kernel
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    loader = { #  Configure boot loader(systemd-boot)
      timeout = 1;
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  # Configure networking
  networking = {
    networkmanager.enable = true;
    hostName = "rotterdam";
    firewall = {
      enable = true;
    };
  };

  # Hardware configuration
  sound.enable = true;
  hardware = {
   bluetooth.enable = true; # Enable bluetooth
   opengl.driSupport32Bit = true; # Needed for games
   steam-hardware.enable = true; # Allow steam to manage controllers
   pulseaudio.enable = false; # Disable pulseaudio
 };
  
  # Locallisation properties
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin";
  i18n.extraLocaleSettings = {
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

  # Configuring services
  services = {
  	printing.enable = true; # Enable CUPS
  	fwupd.enable = true; # Enable fwupd for firmware updates
    openssh.enable = true; # Enable SSH
  	pipewire = { # Sound server
  	    enable = true;
  	    alsa.enable = true;
  	    alsa.support32Bit = true;
  	    pulse.enable = true;
  	    jack.enable = true;
  	    wireplumber.enable = true;
  	};
  	xserver = { # Display server configuration
      enable = true;
      layout = "us"; # kb layout
      xkbVariant = "altgr-intl"; # kb layout variant
      desktopManager.plasma5 = { # Enable KDE Plasma
      	enable     = true;
      	supportDDC = true;
      };
      displayManager = {
      	defaultSession = "plasmawayland"; # Set plasma wayland as default
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

  # Miscellaneous options
  security.rtkit.enable = true;

  # VIrtualisation support
  virtualisation = {
  	libvirtd.enable = true;
  	docker.enable = true;
  };

  # Configure nix(the package manager)
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

  system.stateVersion = "22.05"; # Essentially the version of the nix language(not the system)
    
}
